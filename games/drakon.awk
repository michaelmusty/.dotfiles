# TyPe lIkE AnDoR DrAkOn fRoM AnCiEnT DoMaInS Of mYsTeRy
# <http://www.adomgb.info/adomgb-4.html>
{
    s = ""
    for (i = 1; i <= length($0); i++) {
        c = substr($0, i, 1)
        if (i % 2) {
            c = tolower(c)
        }
        else {
            c = toupper(c)
        }
        s = s c
    }
    print s
}
