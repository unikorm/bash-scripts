# script to update metadata of all files in a folder using pipes to make output of one command the input of another and awk to extract the filename from the output of the first command

aws s3 ls s3://momentkaph/weddings/full/ --endpoint=https://fra1.digitaloceanspaces.com | \  # this return something like (date, time, size, name): 2024-01-03 14:23:42    123456 image-1-wedding.jpg
awk '{print $4}' | \  # awk process text so here it prints the 4th column of the output of the previous command
while read -r filename; do  # read the output of the previous command line by line recursively
    aws s3 cp "s3://momentkaph/weddings/full/$filename" "s3://momentkaph/weddings/full/$filename" \
        --metadata-directive REPLACE \   # this is to replace the all metadata of the file
        --content-type "image/jpeg" \
        --cache-control "max-age=2592000" \
        --content-disposition "inline" \
        --endpoint=https://fra1.digitaloceanspaces.com
done