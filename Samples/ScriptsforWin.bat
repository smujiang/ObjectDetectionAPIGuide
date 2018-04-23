:: ##You should configure these virables according to your directories.
@echo off
cls
set DATA_BASE=H:\PathologicalImages\MitosesTFRecord
set MODEL_BASE=H:\DataOutput\Mitoses\models
set PROJECT_MODEL_BASE=C:\Users\m192500\Documents\GitHub\DigitalPathology\MitosesDetection\models
:: For Training
set PIPELINE_CONFIG_PATH=C:\Users\m192500\Documents\GitHub\DigitalPathology\MitosesDetection\models\ssd_inception_v2\ssd_inception_v2_mitoses.config
set MY_TRAIN_DIR=H:\DataOutput\Mitoses\models\ssd_inception_v2\train
:: For exporting a trained graph
set CHECKPOINT_PREFIX=H:\DataOutput\Mitoses\models\ssd_inception_v2\train\model.ckpt-14991
set GRAPH_OUT_DIR=%CHECKPOINT_PREFIX%
:: set GRAPH_OUT_DIR=%MY_TRAIN_DIR%

:: For evaluation
set EVAL_DIR=%MODEL_BASE%\ssd_inception_v2\eval

set C_DIR=%~dp0
echo Current Dir:%~dp0

C:
cd C:\Users\m192500\Documents\GitHub\models\research

::echo PIPELINE_CONFIG_PATH=%PIPELINE_CONFIG_PATH%
::echo GRAPH_OUT_DIR=%GRAPH_OUT_DIR%
::echo EVAL_DIR=%EVAL_DIR%
::echo %C_DIR%
echo %MY_TRAIN_DIR%
:: #Training
::python object_detection/train.py --logtostderr --pipeline_config_path=%PIPELINE_CONFIG_PATH% --train_dir=%MY_TRAIN_DIR%


::python object_detection/train.py --logtostderr --pipeline_config_path=C:\Users\m192500\Documents\GitHub\DigitalPathology\MitosesDetection\models\ssd_inception_v2\ssd_inception_v2_mitoses.config --train_dir=H:\DataOutput\Mitoses\models\ssd_inception_v2\train
:: #Monitor training process
::tensorboard --logdir=%MY_TRAIN_DIR%


:: #Export graph
:: python object_detection/export_inference_graph.py --input_type=image_tensor --pipeline_config_path=%PIPELINE_CONFIG_PATH% --trained_checkpoint_prefix=%CHECKPOINT_PREFIX% --output_directory=%GRAPH_OUT_DIR%

:: #Evaluation
python object_detection/eval.py --logtostderr --pipeline_config_path=%PIPELINE_CONFIG_PATH% --checkpoint_dir=%CHECKPOINT_PREFIX% --eval_dir=%EVAL_DIR%

::echo python object_detection/eval.py --logtostderr --eval_training_data=Ture --pipeline_config_path=%PIPELINE_CONFIG_PATH% --checkpoint_dir=%CHECKPOINT_PREFIX% --eval_dir=%EVAL_DIR% --runonce=True

:: #Monitor evaluation process
:: tensorboard --logdir=%EVAL_DIR%

%C_DIR:~,2%
cd %C_DIR%

pause 