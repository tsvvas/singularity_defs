#!/bin/bash
#SBATCH --job-name=apptainer
#SBATCH --partition=short
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --mincpus=4
#SBATCH --mem=16G


NAME="$1"
DEF_FILE="$NAME.def"
CONTAINER_DIR="$PROJECTDIR/containers"

if [ -z "$1" ]; then
    echo "Error: No container name was provided."
    echo "Usage: $0 <container-name>"
    exit 1
fi

if [ ! -f "$DEF_FILE" ]; then
    echo "Error: Definition file '$DEF_FILE' not found."
    exit 1
fi

if [ -z "${PROJECTDIR:-}" ]; then
    echo "Error: PROJECTDIR environment variable is not set."
    exit 1
fi


echo "Job started at: $(date)"
echo "Starting Apptainer build for $NAME..."

if apptainer build \
    --fakeroot \
    --force \
    --bind "${TMPDIR:-/tmp}":/tmp \
    "$CONTAINER_DIR/$NAME.sif" "$DEF_FILE"; then
    echo "Build completed successfully: $CONTAINER_DIR/$NAME.sif"
else
    echo "Build failed for $NAME"
    exit 1
fi

echo "Job finished at: $(date)"
