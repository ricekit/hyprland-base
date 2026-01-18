#!/bin/bash

# Script to extract function names and their top comments from commands.sh
# Usage: ./generate-docs.sh [input_file] [output_file]
# Default: ./generate-docs.sh commands.sh README.md

INPUT_DIR="${1:-scripts.d}"
OUTPUT_FILE="${2:-README.md}"

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Error: Input directory '$INPUT_DIR' not found"
    exit 1
fi

# Generate documentation header if README.head exists, otherwise create basic header
if [[ -f "README.head" ]]; then
    cat README.head > "$OUTPUT_FILE"
fi

echo "" >> "$OUTPUT_FILE"
echo "## Modules provided" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

for INPUT_FILE in "$INPUT_DIR"/*.sh; do
    sed -n '/^#/{s/^# ?//;p;}' "$INPUT_FILE" | head -n 1 >> "$OUTPUT_FILE"
    sed -n '/^##/{s/^## ?//;p;}' "$INPUT_FILE" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "### Available functions" >> "$OUTPUT_FILE"
    # Extract functions and their comments
    awk -f /.github/scripts/generate-docs.awk "$INPUT_FILE" >> "$OUTPUT_FILE"
done

if [[ -f README.tail ]]; then
    cat README.tail >> "$OUTPUT_FILE"
fi

echo "Documentation generated: $OUTPUT_FILE"
