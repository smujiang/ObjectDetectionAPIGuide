#!/bin/bash


# ##You should configure these virables according to your directories.
export MODEL_BASE=/Users/general/Projects/GitHub/raccoon_dataset/models/ssd_mobilenet_v1
# For Training
export PIPELINE_CONFIG_PATH=$MODEL_BASE/ssd_mobilenet_v1_pets.config
export MY_TRAIN_DIR=$MODEL_BASE/train

# For exporting a trained graph
export CHECKPOINT_PREFIX=$MY_TRAIN_DIR/model.ckpt-44
export GRAPH_OUT_DIR=$CHECKPOINT_PREFIX
#export GRAPH_OUT_DIR=$MY_TRAIN_DIR

# For evaluation
export EVAL_DIR=$MODEL_BASE/eval

cd /Users/general/Projects/GitHub/models/research
# #Training
#python object_detection/train.py --logtostderr --pipeline_config_path=$PIPELINE_CONFIG_PATH --train_dir=$MY_TRAIN_DIR

# #Monitor training process
#tensorboard --logdir=$MY_TRAIN_DIR

# #Export graph
#python object_detection/export_inference_graph.py --input_type=image_tensor --pipeline_config_path=$PIPELINE_CONFIG_PATH --trained_checkpoint_prefix=$CHECKPOINT_PREFIX --output_directory=$GRAPH_OUT_DIR

# #Evaluation
python object_detection/eval.py --logtostderr --pipeline_config_path=$PIPELINE_CONFIG_PATH --checkpoint_dir=$GRAPH_OUT_DIR --eval_dir=$EVAL_DIR --runonce=True

# #Monitor evaluation process
# tensorboard --logdir=$EVAL_DIR



