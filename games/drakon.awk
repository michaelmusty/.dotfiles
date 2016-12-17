# TyPe lIkE AnDoR DrAkOn fRoM AnCiEnT DoMaInS Of mYsTeRy
# <http://www.adomgb.info/adomgb-4.html>
{
    line = ""
    toggle = 0
    for (i = 1; i <= length; i++) {
        char = substr($0, i, 1)
        if (char ~ /[a-zA-Z]/)
            char = (toggle = !toggle) ? tolower(char) : toupper(char)
        line = line char
    }
    print line
}
