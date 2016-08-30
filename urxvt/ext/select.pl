# Tom Ryder's choice of selection behaviours for urxvt, butchered from included
# URxvt extension scripts.

# Force me to write this properly
use strict;
use warnings;
use utf8;

# Require at least this version of Perl
use 5.006;

# Use plain-English variable names
use English qw(-no_match_vars);

# Set version of this extension
our $VERSION = 1.0;

# On creation, read all of cutchars into a list of regex-quoted patterns
sub on_init {
    my ($self) = @_;
    if ( defined( my $res = $self->resource('cutchars') ) ) {
        $res = $self->locale_decode($res);
        push @{ $self->{patterns} },
          qr{\G [\Q$res\E[:space:]]* ([^\Q$res\E[:space:]]+) }msx;
    }
    return ();
}

# Handle multiple-clicking selection extension
sub on_sel_extend {
    my ($self) = @_;

    # Get attributes of the current selection
    my ( $row, $col ) = $self->selection_mark;
    my $line    = $self->line($row);
    my $text    = $line->t;
    my $markofs = $line->offset_of( $row, $col );
    my $curlen =
      $line->offset_of( $self->selection_end ) -
      $line->offset_of( $self->selection_beg );

    # Find all the possible matches
    my @matches;
    if ( $markofs < $line->l ) {

        # `perldoc -f study` says this does nothing useful anymore since
        # version 5.16
        study $text;

        for my $regex ( @{ $self->{patterns} } ) {
            while ( $text =~ m{$regex}gmsx ) {
                if (    $LAST_MATCH_START[1] <= $markofs
                    and $markofs <= $LAST_MATCH_END[1] )
                {
                    my $ofs   = $LAST_MATCH_START[1];
                    my $match = $1;

                    push @matches, [ $ofs, length $match ];
                }
            }
        }
    }

    # If no more clever patterns matched, just snarf the whole line
    push @matches, [ 0, ( $line->end - $line->beg + 1 ) * $self->ncol ];

    # Iterate over the matches to choose the shortest one
  MATCH:
    for (
        sort {    ## no critic (ProhibitReverseSortBlock)
            $a->[1] <=> $b->[1]
              or $b->[0] <=> $a->[0]
        } @matches
      )
    {
        my ( $ofs, $len ) = @{$_};
        next MATCH if $len <= $curlen;
        $self->selection_beg( $line->coord_of($ofs) );
        $self->selection_end( $line->coord_of( $ofs + $len ) );
        return 1;
    }

    # Done
    return ();
}

# Copy selections to CLIPBOARD as well as PRIMARY.
sub on_sel_grab {
    my ( $self, $time ) = @_;
    $self->selection( $self->selection, 1 );
    $self->selection_grab( $time, 1 );
    return ();
}
