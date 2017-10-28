# Change an ASCII checklist with [/], [x], and [ ] boxes to a Unicode one
/^#/d
s_^\[ \]_☐_
s_^\[/\]_☑_
s_^\[[xX]\]_☒_
