#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition deeplearn
#SBATCH -q gpgpudeeplearn
#SBATCH --gres=gpu:v100:1
#SBATCH --time 3:00:00
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G

# Load required modules
echo "Load required modules"
module load web_proxy
module load Java/1.8.0_152
module load Anaconda3/5.3.1
CONDA_ENV="fairseq"

# Load up environment
echo "Load up environment"
source activate $CONDA_ENV


# Non-spartan script
PROJECT="char_rnn_classifier"
DATASET="names-bin"
HOME_PATH="/data/cephfs/punim0478/dalinw"
if [ ! -d $HOME_PATH ]
then
    HOME_PATH="/home/dalinw"
fi
echo $HOME_PATH
DATA_PATH="$HOME_PATH/datasets/$DATASET"
CHECKPOINT_PATH="$HOME_PATH/results/$PROJECT"

# Check python version
which python

# Append paths to PYTHONPATH
# export PYTHONPATH=/home/dalinw/DeployedProjects/ml_models/models/pygcn/coco-caption:$PYTHONPATH

# Run scripts
echo "Running scripts"
if [ ! -d $CHECKPOINT_PATH ]; then
  mkdir -p $CHECKPOINT_PATH;
fi

fairseq-train $DATA_PATH \
  --task simple_classification \
  --arch pytorch_tutorial_rnn \
  --optimizer adam --lr 0.001 --lr-shrink 0.5 \
  --max-tokens 1000
  --no-epoch-checkpoints
  --save-dir $CHECKPOINT_PATH