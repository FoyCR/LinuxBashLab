# Default values
owner=''
month=''

# Function to show help
help() {
    echo "Usage: "
    echo "$0 [-o <owner>] "
    echo "$0 [-m <month>] "
    echo "$0 [-h show this help]"
}

# function to validate the month argument
validate_month() {
    local _month=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local months=("jan" "feb" "mar" "apr" "may" "jun" "jul" "aug" "sep" "oct" "nov" "dec")

    for valid_month in "${months[@]}"; do
        if [[ $_month == $valid_month ]]; then
            return 0
        fi
    done
    echo "Invalid month abbreviation: $_month"
    echo "Valid month abbreviations: ${months[*]}"
    return 1
}

#validate arguments only one at a time
validate_arguments() {
    local _owner=$1
    local _month=$2  

    if [[ -z "${_owner}" && -z "${_month}" ]]; then
        help
        exit 1
    fi

    if [[ -n $_month ]]; then
        if ! validate_month "$_month"; then           
            exit 1
        fi
    fi
}

# Parsing command line arguments
while getopts ":o:m:h" option; do
    case "${option}" in
        o) owner=${OPTARG};;         
        m) month=${OPTARG};;           
        h) help
           exit 1;;
    esac
done

# Validate the arguments
validate_arguments "$owner" "$month"

# build find command up based on the provided arguments
find_command="find . -maxdepth 1 -type f"
if [[ -n $owner ]]; then
    echo "Looking for files where the owner is: $owner"
    find_command+=" -user $owner"
fi
if [[ -n $month ]]; then
     echo "Looking for files where the month is: $month"
    find_command+=" -newermt $(date -d "$month 1" +%Y-%m-%d) -not -newermt $(date -d "$month 1 +1 month" +%Y-%m-%d)"
fi
   
# Executing 
result=$(eval "$find_command")
if [[ -z $result ]]; then
    echo "No files found"
else
    echo "$result" | while IFS= read -r file; do
       #echo "File: $file           Lines: $(wc -l < "$file")"
       #echo "Hello world" | awk -v val1="$file" -v val2="$(wc -l < "$file")" '{ printf "File:%s\tLines:%s\n", val1, val2 }'
       printf "File:%30s\tLines:%s\n" $file $(wc -l < "$file") 
      # column -t  -s' ' <<< File:$file Lines:$(wc -l < "$file") 
    done
fi