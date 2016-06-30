# find all lines matching the pattern /application_end/ and print the interesting portions
/application_end/ { 
    # Find the columns of interest
    for (i = 1; i <= NF; i++) {
        if (substr($i, 1, length("application=")) == "application=")
            col_name = i
        if (substr($i, 1, length("origsent=")) == "origsent=")
            col_origsent = i
        if (substr($i, 1, length("termsent=")) == "termsent=")
            col_termsent = i
    }

    # Print the interesting portions of the line: application, origsent and termsent
    printf("%s\t%s\t%s\n", substr($col_name, length("application=")+1), substr($col_origsent, length("origsent=")+1), substr($col_termsent, length("termsent=")+1)) 
} 
