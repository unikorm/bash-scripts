# script to update metadata of all files in a folder using pipes to make output of one command the input of another and awk to extract the filename from the output of the first command

aws s3 ls s3://momentkaph/weddings/full/ --endpoint=https://fra1.digitaloceanspaces.com | \
awk '{print $4}' | \
while read -r filename; do
    aws s3 cp "s3://momentkaph/weddings/full/$filename" "s3://momentkaph/weddings/full/$filename" \
        --metadata-directive REPLACE \
        --content-type "image/jpeg" \
        --cache-control "max-age=2592000" \
        --content-disposition "inline" \
        --endpoint=https://fra1.digitaloceanspaces.com
done