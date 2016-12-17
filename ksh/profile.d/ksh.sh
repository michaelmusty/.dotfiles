# If ksh93 as a login shell decided to give ENV a bizarre value, quietly shunt
# it out of the way. This is probably not how I'm supposed to do this, but I
# can't find documentation as to why ksh93 chooses this value.
case $ENV in
    .sh.ENV) [ -f "$ENV" ] || unset ENV ;;
esac
