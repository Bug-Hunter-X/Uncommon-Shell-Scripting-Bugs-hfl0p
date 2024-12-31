#!/bin/bash

# Solution for handling large files
while IFS= read -r -d $'\0' line; do #Using null termination for large files
  echo "Processing: $line"
done < <(find "very_large_file.txt" -print0)

# Safer handling of temporary files - ensuring proper cleanup even on interruption
tmp_file=$(mktemp)
trap "rm -f $tmp_file; exit 1" INT TERM EXIT
echo "Writing to temporary file: $tmp_file"

# ... write to tmp_file ...

mv "$tmp_file" "final_file.txt"
trap - INT TERM EXIT

# Solution for infinite loop with timeouts and proper exit
counter=0
timeout 60s while true; do 
  echo "Looping..." $counter
  counter=$((counter + 1))
  if [ $counter -gt 100 ]; then
    break
  fi
done