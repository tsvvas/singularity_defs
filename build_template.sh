INPUT="$1"

if [ -z "$INPUT" ]; then
    echo "Error: No container name was provided."
    echo "Usage: $0 <container-name>"
    exit 1
fi

case "$INPUT" in
  *.def)
    DEF_FILE="$INPUT"
    NAME="${INPUT%.def}"
    ;;
  *)
    DEF_FILE="$INPUT.def"
    NAME="$INPUT"
    ;;
esac

if [ -n "${PROJECTDIR:-}" ]; then
    CONTAINER_DIR="$PROJECTDIR/containers"
else
    echo "Warning: PROJECTDIR is not set. Using current directory for output."
    CONTAINER_DIR="."
fi

if [ ! -f "$DEF_FILE" ]; then
    echo "Error: Definition file '$DEF_FILE' not found."
    exit 1
fi

echo "Job started at: $(date)"
echo "Job is running on the node: $SLURMD_NODENAME"
echo "Starting Apptainer build for $NAME..."
echo "Output will be saved to: $CONTAINER_DIR/$NAME.sif"

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
