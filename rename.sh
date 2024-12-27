count=5

for file in *.jpg; do
    [ -e "$file" ] || continue
    new_name="image-${count}-portrait.jpg"  # change the new name as per your requirement
    mv "$file" "$new_name"
    ((count++))
done
