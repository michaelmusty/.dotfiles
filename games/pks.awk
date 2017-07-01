# Ha, ha, ha! Awk!

# Process arguments
BEGIN {

    # Look for options; keep a count of non-option args
    ac = ARGC
    for (i = 1; i <= ARGC; i++) {

        # Show a pic of Phil
        if (ARGV[i] == "--phil") {
            pic = 1
            ARGV[i] = ""
            ac--
        }

        # End-of-options
        if (ARGV[i] == "--") {
            break
            ARGV[i] = ""
            ac--
        }
    }

    # If no arguments left, assume a dictionary file
    if (ac == 1) {
        ARGC = 2
        if ("DICT" in ENVIRON)
            ARGV[1] = ENVIRON["DICT"]
        else
            ARGV[1] = "/usr/share/dict/words"
    }

    # Seed the random number generator
    "rnds 2>/dev/null" | getline seed
    if (length(seed))
        srand(seed)
    else
        srand()
}

# Iterate over the lines, randomly assigning the first field of each one with a
# decreasing probability; this method
$1 ~ /[[:alpha:]]/ && rand() * ++n < 1 { wr = $1 }

# Ha, ha, ha! Incompetent!
END {

    # Check that we processed at least one line
    if (!NR)
        exit 1

    # Strip trailing possessives and punctuation
    sub(/[^[:alpha:]]+s*$/, "", wr)

    # Two or three "ha"s? Important decisions here folks
    hr = int(rand()*2+1)
    for (ha = "Ha"; hi < hr; hi++)
        ha = ha ", ha"

    # Capitalise the word
    wr = toupper(substr(wr,1,1)) substr(wr,2)

    # Return the laughter and the word
    if (pic)
        dopic(ha, wr)
    else
        printf "%s! %s!\n", ha, wr
}

# Ha, ha! Low-res!
function dopic(ha, wr) {
    print ""
    print "        " ha "! " wr "!"
    print "                 \\"
    print "                      .''''''''''''''''''''''.."
    print "                    .'''''''''''''''''''''''''''"
    print "                   .'''''''''''''''''''''''''''''"
    print "                  ,'''''''''''''''''''''''''''''''"
    print "                  '''''''''''''''''''''''''''''''':"
    print "                 ,'''''''''''##`'''''''''''''''.'''`"
    print "                 ;''''''''.###########,'''''',###'''"
    print "                 ;'''''';#################:'#####.''"
    print "                 `:''''''#########################'."
    print "                 ::`   ,'+########################';"
    print "                 ''''''':   .#####################''"
    print "                 ''''''''.####` `;#############;##'"
    print "                 ;''''''',####,###:  +############."
    print "               ,###''''''#############` ;##:#######"
    print "               ,#:##''';+#####+   :######  +##+    +"
    print "               ,'#;#,''#####',+###` ;####`+         "
    print "               ,#'#,#';############++. ,`##         "
    print "               :#####+:#######,@,``@@,#####'        "
    print "               ;#+#+#############++++##.#+##       +"
    print "                ###+################'####'##        "
    print "                 #######+###################.#   :."
    print "                   ######'########################'"
    print "                   ,+#####;#######################"
    print "                   ,#######;############'####+###:"
    print "                   ,#######################+#####'"
    print "                   ,###############' `   #'#  +'#"
    print "                  #,##.###########'##+##'###'####"
    print "                ``@.############## `+#@@@@@######"
    print "              +```@@################ ,,. .  ####."
    print "             ;````@@,##.##############':..:######"
    print "            ;`````@@@########.##################"
    print "         +````````@@@@#####;####################:"
    print "      +`````.`````@@@@######`###################```+"
    print "   +````````,`````'@@@@@##'#####################`````."
    print "+ ``````````.``````@@@@@@##'###'################```````` +"
    print "```````````````````@@@@@@@'#####;##########,##'`````````````.+"
    print "```````````````````@@@@@@@@@+#####':####+:+'````````````````````,"
    print "```````````````````,@@@@@@@@@#:#########'@@@``````````````````````"
    print "```````````.````````@@@@@@@@@@@@#'#####@@@@@```````````````````````"
    print "```````````.````````@@@@@@@@@@@@@@'  @@@@@@@.``````````````````````"
}
