import sys

if len(sys.argv) <= 1:
    filename = 'syslog.txt'
else:
    filename = sys.argv[1]

file_handle = open(filename, 'r')

total_orig_sent = {}
total_term_sent = {}
# Initialize column widths
width_col_name = 0
width_col_origsent = 0
width_col_termsent = 0
for line in file_handle:
    if 'application_end' in line:
        string_list = line.split() # split line on space
        for index, string in enumerate(string_list):
            length_app = len('application')
            length_origsent = len('origsent')
            length_termsent = len('termsent')

            # Slice the interesting parts of the string
            if string[:11] == 'application':
                app_name = string[length_app+1:]
                orig_sent = string_list[index+1][length_origsent+1:]
                term_sent = string_list[index+2][length_termsent+1:]
                # Determine width of name column
                if len(app_name) > width_col_name:
                    width_col_name = len(app_name)

                if app_name in total_orig_sent:
                    total_orig_sent[app_name] += int(orig_sent)
                else:
                    total_orig_sent[app_name] = int(orig_sent)

                if app_name in total_term_sent:
                    total_term_sent[app_name] += int(term_sent)
                else:
                    total_term_sent[app_name] = int(term_sent)
                    
file_handle.close()

# Determine the length of the origsent and termsent columns
for app in total_orig_sent:
    if len(str(total_orig_sent[app])) > width_col_origsent:
        width_col_origsent = len(str(total_orig_sent[app]))

for app in total_term_sent:
    if len(str(total_term_sent[app])) > width_col_termsent:
        width_col_termsent = len(str(total_term_sent[app]))
# add thousand-seperator to column lengths
width_col_origsent += width_col_origsent / 3
width_col_termsent += width_col_termsent / 3

# Header lines
print '{0:{1}}  {2:>{3}}  {4:>{5}}'.format('Name', width_col_name, 'Origsent', width_col_origsent, 'Termsent', width_col_termsent)
print '{0:{1}}  {2:>{3}}  {4:>{5}}'.format('-' * width_col_name, width_col_name, '-' * width_col_origsent, width_col_origsent, '-' * width_col_termsent, width_col_termsent)
# display sorted contents of the two dictionaries
for app, value in sorted(total_orig_sent.items()):
    print '{0:{1}}  {2:>{3},}  {4:>{5},}'.format(app, width_col_name, value, width_col_origsent, total_term_sent[app], width_col_termsent)
