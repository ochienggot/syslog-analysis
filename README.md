# syslog data analysis
I have made two attempts at solving the problem. 

1. The first solution is a shell script (analyze_logs.sh) that calls three awk scripts (script1.awk, script2.awk and script3.awk). To run the scripts, simply add execute permissions to the file. 

Some assumptions this solution makes: 
+ The thousand-seperator only works for some locale settings. I have tested with the locale setting LANG="en_GB.UTF-8", but others may work too.
+ I have tested the script with awk and GNU awk. With mawk (the default awk implementation in some versions of Ubuntu), the thousand-seperator produces an error.

2. The second solution uses Python (analyze_logs.py). This can be run by typing "python analyze_logs.py" at the command prompt. Tested with Python 2.7 on Ubuntu 14.04, Ubuntu Server 16.04 and OSX 10.9.5.

Notes
-----
- The first command-line argument to the scripts, if present, is taken to be the filename. Both solutions default to the filename "syslog.txt" in the absence of a filename from the command-line. The scripts will fail with an error if no such file exists.
- The scripts transparently ignore any command-line arguments after the first one i.e. calling the scripts with more than one argument produces no error, but the extraneous arguments are silently ignored.
- Since the test asks to "output a table with three columns...", I have made the decision to simply display the table without writing the output to a file. The outputs can be redirected to a file should this be needed.
