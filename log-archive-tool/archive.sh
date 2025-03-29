#!/bin/bash
#  archive logs on a set schedule by compressing them and storing them in a new directory
#!/bin/bash

# Get log directory
echo "Please enter the path to the directory containing log files (e.g., /var/log):"
read -r LOG_DIR

# Check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: The directory $LOG_DIR does not exist."
  exit 1
fi

# Prompt the user for the archive destination directory
echo "Where do you want to store the archived logs (e.g., /path/to/archive):"
read -r ARCHIVE_DIR

# Create the archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Get the current date for naming the archive
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Generate name of compressed archive
ARCHIVE_NAME="logs_$DATE.tar.gz"

# Delete log inquiry
echo "Do you want to delete the original log files after archiving? (y/n):"
read -r DELETE_OLD_LOGS

# Compress the logs and create the archive
tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Notify the user about the archiving process
echo "Logs have been archived to $ARCHIVE_DIR/$ARCHIVE_NAME."

# If the user wants to delete the original log files
if [ "$DELETE_OLD_LOGS" == "y" ]; then
  echo "Deleting original log files..."
  rm -f "$LOG_DIR"/*.log
  echo "Original log files have been deleted."
else
  echo "Original log files have not been deleted."
fi

echo "Archiving complete."
