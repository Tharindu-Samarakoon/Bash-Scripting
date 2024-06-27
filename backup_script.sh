#!/bin/bash

# Defining the variables

set -e

BACKUP_SRC="/home/tharusmara/Documents"
BACKUP_DST="/home/tharusmara/Backups"
BACKUP_DATE=$(date +%Y%m%d%H%M%S)
S3_BUCKET_NAME="ubuntu-backup-tharindu"
S3_DIR_STRUC="ubumtu-tharusmara"

BACKUP_FILENAME="backup_$BACKUP_DATE.tar.gz"

localBackup() {

	printf "\nCompressing files..."

	spinner &
	pid=$!
	
	tar -czf "$BACKUP_DST/$BACKUP_DATE/$BACKUP_FILENAME" "$BACKUP_SRC" 2>/dev/null

	kill $pid

}

verifyBackup() {

	printf "\nVerifying local backup"
	spinner &
	pid=$!

	if [ $? -eq 0 ]; then
		printf "\nBackup Successful: $BACKUP_FILENAME"
	else
		printf "\nBackup failed"
	fi

	kill $pid

}

upload() {
	
	printf "\nUploading compressed files to cloud storage..."

	spinner &
	pid=$!


	aws s3api put-object --bucket "$S3_BUCKET_NAME" --key "$S3_DIR_STRUC/$BACKUP_DATE/$BACKUP_FILENAME" --body "$BACKUP_DST/$BACKUP_DATE/$BACKUP_FILENAME" || {
		printf "\nError : Cloud upload failed"
		exit 1
	}

	kill $pid
}

spinner() {
	while true
	do 
		echo -ne "."
		sleep 1
	done
}


mkdir -p "$BACKUP_DST/$BACKUP_DATE"

# Archive the source directory

localBackup

# Verify the backup was created succesfully

verifyBackup

# Uploading compressed files to Cloud Storage

upload

echo "Data backup on cloud was successful"
echo "Have a great day!!!"

