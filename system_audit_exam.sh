#!/bin/bash

#||| System Audit |||

#----------------------------------
DIR="$HOME/exam-results/audit"
#----------------------------------

# Part |1| ----> Environment setup

mkdir -p "$DIR"

touch "$DIR/notes.txt"

echo "# | Working Directory Path |" > "$DIR/cwd.txt"

pwd >> "$DIR/cwd.txt"

#----------------------------------

# Part |2| ----> Account analysis

echo "# | Usernames |" > "$DIR/users.txt"

cut -d: -f1 /etc/passwd >> "$DIR/users.txt"

echo "# | Users with /bin/bash shell |" > "$DIR/bash_users.txt"

grep "/bin/bash" /etc/passwd | cut -d: -f1 >> "$DIR/bash_users.txt"

echo "# | Shell preview |" > "$DIR/shell_preview.txt"

sed 's|/bin/bash|/usr/bin/zsh|g' /etc/passwd | head -5 >> "$DIR/shell_preview.txt"

#----------------------------------

# Part |3| ----> System information collection

echo "# | System information |" > "$DIR/sysinfo.txt"

{ uname -s; uname -r; }  >> "$DIR/sysinfo.txt"

arch >> "$DIR/sysinfo.txt"

echo "# | Group summary |" > "$DIR/group_summary.txt"

{ head -3 /etc/group; tail -2 /etc/group; } >> "$DIR/group_summary.txt"

#----------------------------------

# Part |4| ----> Logs

echo "# | Conf files |" > "$DIR/conf_files.txt"

find /etc -name "*.conf" 2>/dev/null > "$DIR/conf_files.txt"

echo "# | Top logs |" > "$DIR/top_logs.txt"
du -ah /var/log 2>/dev/null | sort -rh | head -10 >> "$DIR/top_logs.txt"

#----------------------------------

# Part |5| ----> Logs

cp /etc/hosts "$DIR/hosts.bak"

chmod 600 "$DIR/hosts.bak"

echo "# | Hosts perm |" > "$DIR/hosts_perm.txt"

ls -l "$DIR/hosts.bak" >> "$DIR/hosts_perm.txt"

#----------------------------------

# Part |6| ----> Cleanup

#find "$DIR" -name "*.txt" \
 # ! -name "hosts_perm.txt" \
  #! -name "notes.txt" \
  #-delete
  
#----------------------------------
