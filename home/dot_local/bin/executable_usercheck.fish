#!/usr/bin/env fish

# Get the current date in seconds since epoch
set current_date (date +%s)

# Define one year in seconds
set one_year_seconds (math "3600*24*365")

argparse v/verbose -- $argv

# Check if the -v or --version flag is set
if set -q _flag_v
    printf "%-20s %-20s\n" User "Last Login"
end

# Loop through each user in /etc/passwd
for user in (cut -d: -f1 /etc/passwd)
    # Check if the user is in the groups "student" or "faculty"
    set user_groups (id -nG $user)
    if echo $user_groups | grep -qE '\b(student|faculty)\b'
        # Get the last login time in seconds since epoch
        set last_login (lastlog -u $user | awk 'NR==2 {print $4, $5, $6, $9}')

        # if the user never logged in, `last_login` trimmed is `"in**"`
        if string match -q "in**" $last_login
            echo "$user has never logged in. You can delete this user with: "
            echo "sudo userdel -r $user"
            continue
        end

        # Convert the last login time to seconds since epoch
        set last_login_seconds (date -d "$last_login" +%s)

        # Calculate the difference in seconds
        set diff (math "$current_date-$last_login_seconds")

        # If the difference is greater than one year, print the delete command
        if test $diff -gt $one_year_seconds
            echo "User $user doesn't login since $last_login. You can delete this user with: "
            echo "sudo userdel -r $user"
        end

        # if option -v is used, print $user and $last_login
        if set -q _flag_v
            printf "%-20s %-20s\n" $user $last_login
        end
    end
end
