# LinuxBashLab
DevOps Upskills program Lab 1

Usage: 

./countlines.bash [-o <owner>] => find the files when the owner is equal to <owner>

./countlines.bash [-m <month>] => find the files where its creation date match with <month> provided

./countlines.bash [-h] => show the help


valid month abbreviations => "jan" "feb" "mar" "apr" "may" "jun" "jul" "aug" "sep" "oct" "nov" "dec"

instrunctions for the lab:

Create a Bash Shell script using functions to count the number of lines in text files located in the current directory when:
They belong to an owner OR
When were created in a specific month

The shell script should accept the following options:

-o <owner>
To select files where the owner is <owner>

-m <month>
To select files where the creation month is <month>

When receiving invalid arguments, show help 
