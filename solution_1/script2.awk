# Add the values for origsent and termsent
{ origsent[$1] += $2 } { termsent[$1] += $3 } 

END { 
    # Initialize column widths
    width_name = 0
    width_origsent = 0
    width_termsent = 0
    for (name in origsent)
        if (length(name) > width_name)
        {
            width_name = length(name)
        }
        if (length(origsent[name]) > width_origsent)
        {
            width_origsent = length(origsent[name])
        }

    for (name in termsent)
        if (length(termsent[name]) > width_termsent)
        {
            width_termsent = length(termsent[name])
        }
        # Account for the thousand-seperator(s)
        width_origsent = width_origsent + int(width_origsent/3)
        width_termsent = width_termsent + int(width_termsent/3)

    # Header lines
    printf("%-*s\040\040%*s\040\040%*s\n", width_name, "Name", width_origsent, "Origsent", width_termsent, "Termsent")
    for (c = 0; c < width_name; c++) printf "-"; printf "\040\040"
    for (c = 0; c < width_origsent; c++) printf "-"; printf "\040\040"
    for (c = 0; c < width_termsent; c++) printf "-"; printf "\040\040\n"

# locale settings should support thousand-seperator: set locale environment
# variable or specify the locale setting during awk runtime
# (e.g. export LANG="en_GB.UTF-8")
# Only works with gawk (mawk complains about the thousand-seperator)
    for (app_name in origsent) 
        printf("%-*s\040\040%*\047d\040\040%*\047d\n", width_name, app_name, width_origsent, origsent[app_name], width_termsent, termsent[app_name]) 
}
