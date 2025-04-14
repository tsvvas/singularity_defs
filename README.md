# A collection of Singularity (Apptainer) definition files.

This repository helps you build Apptainer containers on an HPC system using SLURM.

Because SLURM setups vary across HPC systems, this repository does not include a static build script.
Instead, it allows you to quickly generate one using your own configuration.

## Steps to Build a Container

1. Create config

    In the root of the repository, create a file called `build.conf`.
    This file defines your SLURM resource requests such as time, CPUs, memory, etc.

    To get started, copy an example from the [config examples](config_examples/) folder:

    ```bash
    cp config_examples/hpc1_build.conf build.conf
    ```

2. Generate the build script

    Run the following command from the root directory:

    ```bash
    make
    ```

3. Submit the container build job

    To build a container, run the build script and pass the name of your definition file (without the .def extension):

    ```bash
    sbatch build.sh <container_name>
    ```

    This will build `<container_name>.sif` from `<container_name>.def` and place the output in your `$PROJECTDIR/containers/ directory`. If `PROJECTDIR` is not set the container will be put in the current directory.

