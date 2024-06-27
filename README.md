# Bash Scripting Projects

Welcome to my collection of bash scripting projects! Below is a detailed overview of the Automated Backup Script project available in this repository.

## Project: Automated Backup Script

### Features
- **Local Backup:** Automates the compression of specified directories for local storage.
- **Verification:** Ensures the integrity of the local backup.
- **Cloud Upload:** Automatically uploads the compressed backup to an AWS S3 bucket.

### Usage
1. **Define Variables:**
   - `BACKUP_SRC`: Source directory to be backed up.
   - `BACKUP_DST`: Destination directory for storing backups.
   - `S3_BUCKET_NAME`: AWS S3 bucket name for cloud storage.
   - `S3_DIR_STRUC`: Directory structure within the S3 bucket.

2. **Run the Script:**
   ```bash
   ./backup_script.sh
   
### How It Works
- The script first creates a backup by compressing files from `$BACKUP_SRC` into a `.tar.gz` file stored in `$BACKUP_DST`.
- It verifies the success of the local backup and notifies the user accordingly.
- Lastly, it uploads the compressed backup file to AWS S3 using the AWS CLI.

### Requirements
- **AWS CLI:** Ensure it's installed and configured with appropriate permissions to upload to your S3 bucket.
- **tar:** Required for archiving files.
- **Basic Utilities:** Standard bash utilities such as `date`, `printf`, and `kill` are used.

### Notes
- Modify variables (`BACKUP_SRC`, `BACKUP_DST`, etc.) in the script to suit your environment.
- Ensure the AWS credentials have sufficient permissions for S3 uploads.
