# TyPe lIkE AnDoR DrAkOn fRoM AnCiEnT DoMaInS Of mYsTeRy
# <http://www.adomgb.info/adomgb-4.html>
{
    line = ""
    case = 0
    for (i = 1; i <= length; i++) {
        char = substr($0, i, 1)
        if (char ~ /[a-zA-Z]/)
            char = (case = !case) ? tolower(char) : toupper(char)
        line = line char
    }
    print line
}
