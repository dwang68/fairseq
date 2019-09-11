#!/bin/bash
export CUDA_VISIBLE_DEVICES=2
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

source /home/dalinw/.bashrc
which python
conda activate fairseq
which python
fairseq-train $DATA_PATH \
  --task simple_classification \
  --arch pytorch_tutorial_rnn \
  --optimizer adam --lr 0.001 --lr-shrink 0.5 \
  --max-tokens 1000 \
  --no-epoch-checkpoints \
  --save-dir $CHECKPOINT_PATH \
  --max-epoch 100

