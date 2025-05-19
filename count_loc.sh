#!/bin/bash

EXT="*.gd"

TMP_STATS=$(mktemp)
TMP_LOC=$(mktemp)

# 1. Collect additions and deletions by author email
git log --numstat --pretty="AUTHOR:%ae" -- "$EXT" | awk '
BEGIN { email = "" }
/^AUTHOR:/ { email = substr($0, 8) }
/^[0-9]/ { print email "\t" $1 "\t" $2 }
' | awk -F'\t' '
{
  add[$1] += $2
  del[$1] += $3
}
END {
  for (email in add) {
    print email "\t" add[email] "\t" del[email]
  }
}
' > "$TMP_STATS"

# 2. Count LOC by author email using blame
git ls-files "$EXT" | while read -r file; do
  git blame --line-porcelain "$file" | grep '^author-mail ' | sed 's/^author-mail //;s/[<>]//g'
done | sort | uniq -c | awk '{print $2 "\t" $1}' > "$TMP_LOC"

# 3. Merge and print the final table
awk -F'\t' '
FNR==NR {
  email = $1
  add[email] = $2 + 0
  del[email] = $3 + 0
  seen[email] = 1
  next
}
{
  email = $1
  loc[email] = $2 + 0
  seen[email] = 1
}
END {
  printf "%-35s %10s %10s %10s\n", "Author Email", "Additions", "Deletions", "LOC"
  for (email in seen) {
    printf "%-35s %10d %10d %10d\n", email, add[email], del[email], loc[email]
  }
}
' "$TMP_STATS" "$TMP_LOC" | sort -k4 -nr

rm "$TMP_STATS" "$TMP_LOC"

