#!/bin/bash -e

envs=(data qc multiqc assembly bakta abricate busco prokka base)

data=("ncbi-genome-download --help" "ncbi-acc-download --help")
qc=("fastqc --help" "bracken --help" "kraken2 --help" "quast.py --version")
multiqc=("multiqc --help")
assembly=("spades.py --help" "unicycler --help")
bakta=("bakta --help")
abricate=("abricate --help" "abricate --check" "abricate --list")
busco=("busco --help" "busco --list-datasets")
prokka=("prokka --help" "prokka --listdb")
base=("$HOME/bbmap/bbduk.sh --help")

for a in "${envs[@]}" ; do
        declare -n list=$a
        echo ">>>>> Activating environment" $a
        conda activate $a
        for b in "${list[@]}" ; do
                read -p "Press any key to run command: $b"
                $b
                read -p "Press any key for next test..."
        done
        echo "<<<<< Deactivating environment" $a
        conda deactivate
        echo "Syncing..."
        sync
        echo "Syncing done"
done
conda activate base

