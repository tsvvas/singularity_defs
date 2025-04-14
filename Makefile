include build.conf

SCRIPT_NAME ?= build.sh

.PHONY: all generate clean check_config

all: generate

generate: check_config
	echo "Generating SLURM job script: $(SCRIPT_NAME)"
	echo "#!/bin/bash" > $(SCRIPT_NAME)
	echo "#SBATCH --job-name=apptainer" >> $(SCRIPT_NAME)
ifneq ($(strip $(PARTITION)),)
	echo "#SBATCH --partition=$(PARTITION)" >> $(SCRIPT_NAME)
endif
	echo "#SBATCH --time=$(TIME)" >> $(SCRIPT_NAME)
ifneq ($(strip $(NODES)),)
	echo "#SBATCH --nodes=$(NODES)" >> $(SCRIPT_NAME)
endif
ifneq ($(strip $(CPUS)),)
	echo "#SBATCH --mincpus=$(CPUS)" >> $(SCRIPT_NAME)
endif
ifneq ($(strip $(MEM)),)
	echo "#SBATCH --mem=$(MEM)" >> $(SCRIPT_NAME)
endif
ifneq ($(strip $(GRES)),)
	echo "#SBATCH --gres=$(GRES)" >> $(SCRIPT_NAME)
endif
	echo "" >> $(SCRIPT_NAME) 
	cat build_template.sh >> $(SCRIPT_NAME)
	echo "Script generated: $(SCRIPT_NAME)"

check_config:
	@if [ -z "$(TIME)" ]; then \
		echo "Error: TIME is not set in build.conf"; \
		exit 1; \
	fi

clean:
	rm -f $(SCRIPT_NAME)
	echo "Cleaned generated script."
