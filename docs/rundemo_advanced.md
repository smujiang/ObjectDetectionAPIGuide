# Run a demo in an advanced way
This guidline will lead you know more about how to work with Object-detection API, including how to bring in the specific dataset,and how to configure the pipeline.
## 1. Prepare your dataset
There are several data sets available online. You can download one of them from the website.
1. [Oxford-IIIT Pets ](http://www.robots.ox.ac.uk/~vgg/data/pets/) (Recommeded)
2. [Open Images Dataset V3](https://github.com/openimages/dataset#download-the-data)
3. [MS COCO](http://cocodataset.org/#home)
4. [ILSVRC](http://www.image-net.org/challenges/LSVRC/)

Or, you can create your own dataset.If you are using Mac OS X, you can use [RectLabel](https://rectlabel.com),
an image annotation tool to label images for bounding box object detection and segmentation.


If you want to enlarge your dataset,there are services like CrowdFlower, CrowdAI or Amazon’s Mechanical Turk that offer data labeling services.
## 2. Convert the dataset into TF records
In this step, you should read the original image files and anotation files in your dataset,and convet them into TF-records. It will be much easier if you have [this code](../Samples/create_pet_tf_record.py) as reference.

By the way, you should split the whole dataset into two parts,one for training the other for testing/validation.

----
<font color=green>__From now on, you can play with Object-detection API without writing even a line of python code. You just need to modify the pipeline config file and write some bash/bat scripts to let the demo run.__</font>
----
I offer one example of [.config file](../Samples/models/ssd_inception_v2/ssd_inception_v2_mitoses.config) and scripts for both [Windows](../Samples/ScriptsforWin.sh) and [Linux/Mac](../Samples/ScriptsforLinux.sh) OS.
## 3. Configure the pipline
All the training and evaluation procedures are defined in .config file. You can find [some examples on the offical page](https://github.com/smujiang/models/tree/master/research/object_detection/samples/configs), just download one as reference.
A skeleton configuration file is shown below:
```
model {
(... Add model config here...)
}

train_config : {
(... Add train_config here...)
}

train_input_reader: {
(... Add train_input configuration here...)
}

eval_config: {
}

eval_input_reader: {
(... Add eval_input configuration here...)
}
```
Search for "PATH_TO_BE_CONFIGURED" in that file to find the fields that should be configured. Typically, there are 5 places to modify, assoiating with 3 process:
#### a) Model initializing
load a pre-trained model from a check point
seems wrong when I read the source code of export_inference_graph.py
you need to generate a .ckpt file from the model files first.
``` consel
python object_detection/export_inference_graph.py \
    --input_type image_tensor \
    --pipeline_config_path ${PIPELINE_CONFIG_PATH} \
    --trained_checkpoint_prefix ${TRAIN_PATH} \
    --output_directory output_inference_graph.pb
```
Finetune checkpoint can point to a single model.ckpt file OR refer to a to a set of three files (.data-00000-of-00001, .index, .meta).

There's nothing wrong with your downloaded checkpoint files. Just use model.ckpt and replace "???" with the directory that contains the files.	  
https://github.com/tensorflow/models/issues/2173   
if your OS is windows, make sure use \\\ as the dir separater.   
just as:    
fine_tune_checkpoint: "H:\\\Dataset\\\modelzoo\\\test\\model.ckpt"
#### b) Training inputs/outputs

#### c) Evaluation inputs/outputs
The .config file also defines the evaluation presedure.


###
## 4. Train the model
use the API to train the model.  
```
python object_detection\train.py --logtostderr --pipeline_config_path=C:\Users\m192500\Documents\GitHub\PetDetection\config\faster_rcnn_inception_resnet_v2_atrous_pets.config --train_dir=H:\DataOutput\Oxford-IIITPet\checkpt
```
## 5. Inspect the training job
Progress for training and eval jobs can be inspected by using Tensorboard. If using the recommended directory structure, Tensorboard can be run using the following command:
```
tensorboard --logdir=$\{PATH_TO_MODEL_DIRECTORY}    
```
where $\{PATH_TO_MODEL_DIRECTORY\} points to the directory that contains the train and eval directories. Please note it may take Tensorboard a couple minutes to populate with data.

The terminal will give you an address to monitor the training progress with your web browser.

## 6. Export exact graph


## 7. Testing/Evaluation
Evaluation is run as a separate job. The eval job will periodically poll the train directory for new checkpoints and evaluate them on a test dataset. The job can be run using the following command:   
```
python object_detection/eval.py \
    --logtostderr \
    --pipeline_config_path=$\{PATH_TO_YOUR_PIPELINE_CONFIG} \
    --checkpoint_dir=$\{PATH_TO_TRAIN_DIR} \
    --eval_dir=$\{PATH_TO_EVAL_DIR}   
```
where ${PATH_TO_YOUR_PIPELINE_CONFIG} points to the pipeline config, ${PATH_TO_TRAIN_DIR} points to the directory in which training checkpoints were saved (same as the training job) and ${PATH_TO_EVAL_DIR} points to the directory in which evaluation events will be saved. As with the training job, the eval job run until terminated by default.

