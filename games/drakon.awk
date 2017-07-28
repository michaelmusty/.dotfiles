# TyPe lIkE AnDoR DrAkOn fRoM AnCiEnT DoMaInS Of mYsTeRy
# <http://www.adomgb.info/adomgb-4.html>
{
    len = length($0)
    lin = ""
    tog = 0
    for (i = 1; i <= len; i++) {
        chr = substr($0, i, 1)
        if (chr ~ /[a-zA-Z]/)
            chr = (tog = !tog) ? tolower(chr) : toupper(chr)
        lin = lin chr
    }
    print lin
}
