#!/bin/bash
#SBATCH --account=csci_ga_2572_2022fa_10
#SBATCH --partition=n1s8-v100-1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6:00:00
#SBATCH --mem=16GB
#SBATCH --job-name=eval
#SBATCH --mail-type=END
#SBATCH --mail-user=zd662@nyu.edu
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --gres=gpu:1

singularity exec --nv --overlay /scratch/DL22FA/overlay_11-15.ext3:ro \
-B /scratch/DL22FA/unlabeled_224.sqsh:/unlabeled:image-src=/ \
-B /scratch/DL22FA/labeled.sqsh:/labeled:image-src=/ \
-B /scratch -B /scratch_tmp \
/scratch/DL22FA/cuda11.2.2-cudnn8-devel-ubuntu20.04.sif /bin/bash -c "source /ext3/env.sh; python eval.py"
