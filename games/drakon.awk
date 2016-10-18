# TyPe lIkE AnDoR DrAkOn fRoM AnCiEnT DoMaInS Of mYsTeRy
# <http://www.adomgb.info/adomgb-4.html>
{
    s = ""
    u = 0
    for (i = 1; i <= length($0); i++) {
        c = substr($0, i, 1)
        if (c ~ /[a-zA-Z]/) {
            if (u) {
                c = toupper(c)
            }
            else {
                c = tolower(c)
            }
            u = !u
        }
        s = s c
    }
    print s
}
