#!/bin/bash




# Check if all 3 arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <huggingface_url> <output_path> <sha256_hash>"
    exit 1
fi

URL="$1"
OUTPUT_PATH="$2"
EXPECTED_HASH="$3"

# 1. Prepare the directory
DIR_NAME=$(dirname "$OUTPUT_PATH")
if [ ! -d "$DIR_NAME" ]; then
    echo "Directory '$DIR_NAME' does not exist. Creating it..."
    mkdir -p "$DIR_NAME"
fi

# 2. Check if file exists; if so, verify before re-downloading
if [ -f "$OUTPUT_PATH" ]; then
    echo "File already exists. Checking hash..."
    # --status hides output, returns 0 if success
    echo "$EXPECTED_HASH  $OUTPUT_PATH" | sha256sum -c - --status
    
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32mFile already exists and hash matches. Skipping download.\033[0m"
        exit 0
    else
        echo "Hash mismatch on existing file. Re-downloading..."
        rm "$OUTPUT_PATH"
    fi
fi

# 3. Download the file
echo "Downloading from Hugging Face..."
# -L follows redirects (crucial for HF), -o specifies output file
curl -L "$URL" -o "$OUTPUT_PATH" --progress-bar

if [ $? -ne 0 ]; then
    echo -e "\033[0;31mDownload failed.\033[0m"
    exit 1
fi

# 4. Verify the Hash
echo "Verifying SHA256 checksum..."
# Note: Two spaces between hash and path are required by sha256sum
echo "$EXPECTED_HASH  $OUTPUT_PATH" | sha256sum -c -

# 5. Handle success/failure
if [ $? -eq 0 ]; then
    echo -e "\033[0;32mSuccess! Model verified and saved to: $OUTPUT_PATH\033[0m"
else
    echo -e "\033[0;31mERROR: Hash mismatch! The file is likely corrupted.\033[0m"
    echo "Deleting corrupted file..."
    rm "$OUTPUT_PATH"
    exit 1
fi