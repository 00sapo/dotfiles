#!/usr/bin/env fish

# Get the current date in seconds since epoch
set current_date (date +%s)

# Define one year in seconds
set one_year_seconds (math "3600*24*365")

argparse v/verbose -- $argv

# Check if the -v or --version flag is set
if set -q _flag_v
    printf "%-20s %-20s %-20s\n" User "Last Login" "Creation Date"
end

# Loop through each user in /etc/passwd
for user in (cut -d: -f1 /etc/passwd)
    # Check if the user is in the groups "student" or "faculty" or has a home directory
    set user_groups (id -nG $user)
    # if echo $user_groups | grep -qE '\b(student|faculty)\b'
    if test -d /home/$user -o (echo $user_groups | grep -cE '\b(student|faculty)\b') -gt 0
        # if the user has no home, alert
        if test -z /home/$user
            echo "$user has no home. You can delete this user with: "
            echo "sudo userdel -r $user"
            continue
        end

        # Get the last status change of its home
        set last_login_seconds (stat -c %Z /home/$user)

        # Calculate the difference in seconds
        set diff (math "$current_date-$last_login_seconds")

        # If the difference is greater than one year, print the delete command
        if test $diff -gt $one_year_seconds
            # Convert the last login time to seconds since epoch
            set last_login (date -d @$last_login_seconds -I)
            echo "User $user doesn't login since $last_login. You can delete this user with: "
            echo "sudo userdel -r $user"
        end

        # same with the creation date
        # Get the user creation date
        set creation_seconds (stat -c %W /home/$user)
        set diff_creation (math "$current_date-$creation_seconds")
        if test $diff_creation -gt $one_year_seconds
            set creation_date (date -d @$creation_seconds -I)
            echo "User $user was created on $creation_date. You can delete this user with: "
            echo "sudo userdel -r $user"
        end

        # if option -v is used, print $user and $last_login
        if set -q _flag_v
            set last_login (date -d @$last_login_seconds -I)
            set creation_date (date -d @$creation_seconds -I)
            printf "%-20s %-20s %-20s\n" $user $last_login $creation_date
        end
    end
end
