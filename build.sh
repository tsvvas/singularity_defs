#!/bin/bash
#SBATCH --job-name=apptainer
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --mincpus=4
#SBATCH --mem=16G

NAME=$1

apptainer build \
    --fakeroot \
    --force \
    --bind "$TMPDIR":/tmp \
    $PROJECTDIR/containers/$NAME.sif $NAME.def