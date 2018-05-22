# Installation
## Dependencies
Tensorflow Object Detection API depends on the following libraries:

*   Protobuf 2.6
*   Python-tk
*   Pillow 1.0
*   lxml
*   tf Slim (which is included in the "tensorflow/models/research/" checkout)
*   Jupyter notebook
*   Matplotlib
*   Tensorflow
*   cocoapi

For detailed steps to install Tensorflow, follow the [Tensorflow installation
instructions](https://www.tensorflow.org/install/). A typical user can install
Tensorflow using one of the following commands:

``` bash
# For CPU
pip install tensorflow
# For GPU
pip install tensorflow-gpu
```

The remaining libraries can be installed on Ubuntu 16.04 using via apt-get:

``` bash
sudo apt-get install protobuf-compiler python-pil python-lxml python-tk
sudo pip install jupyter
sudo pip install matplotlib
```

Alternatively, users can install dependencies using pip:

``` bash
sudo pip install pillow
sudo pip install lxml
sudo pip install jupyter
sudo pip install matplotlib
```

## COCO API installation

Download the
<a href="https://github.com/cocodataset/cocoapi" target=_blank>cocoapi</a> and
copy the pycocotools subfolder to the tensorflow/models/research directory if
you are interested in using COCO evaluation metrics. The default metrics are
based on those used in Pascal VOC evaluation. To use the COCO object detection
metrics add `metrics_set: "coco_detection_metrics"` to the `eval_config` message
in the config file. To use the COCO instance segmentation metrics add
`metrics_set: "coco_mask_metrics"` to the `eval_config` message in the config
file.

```bash
git clone https://github.com/cocodataset/cocoapi.git
cd cocoapi/PythonAPI
make
cp -r pycocotools <path_to_tensorflow>/models/research/
```
__Note:__
*  If you are using Windows, you must install “make” first.
*  if you don’t have a C/C++ compiler (such as gcc/g++) on your computer, you should install one first. Visual Studio throw errors when I tried, so you’d better install a Cygwin on your windows.
*  Check if Path Lib and Include is added to the environment, after the installation.
*  You should modify the setup.py first to meet your OS.

## Protobuf Compilation

The Tensorflow Object Detection API uses Protobufs to configure model and
training parameters. Before the framework can be used, the Protobuf libraries
must be compiled. This should be done by running the following command from
the tensorflow/models/research/ directory:


``` bash
# From tensorflow/models/research/
protoc object_detection/protos/*.proto --python_out=.
```
__Note:__
Install protoc first, don’t use V3.5, because protoc version 3.5.1 cannot recognize the file extensions. However, version 3.4.0 is OK. see this [link](https://github.com/tensorflow/models/issues/2930).
## Add Libraries to PYTHONPATH

When running locally, the tensorflow/models/research/ and slim directories
should be appended to PYTHONPATH. This can be done by running the following from
tensorflow/models/research/:


``` bash
# From tensorflow/models/research/
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
```
<font color=green>__If everything goes right, Object-detection API is installed in your computer.__</font>

Note: This command needs to run from every new terminal you start. If you wish
to avoid running this manually, you can add it as a new line to the end of your
~/.bashrc file.

# Testing the Installation

You can test that you have correctly installed the Tensorflow Object Detection\
API by running the following command:

```bash
python object_detection/builders/model_builder_test.py
```

Note: You may get an error like this:
```
..........................
 File "/usr/local/lib/python3.5/dist-packages/tensorflow/python/framework/op_def_library.py", line 528, in _apply_op_helper
    (input_name, err))
ValueError: Tried to convert 't' to a tensor and failed. Error: Argument must be a dense tensor: range(0, 3) - got shape [3], but wanted [].
```
The issue is with models/research/object_detection/utils/learning_schedules.py lines 167-169. Currently it is
```
rate_index = tf.reduce_max(tf.where(tf.greater_equal(global_step, boundaries),
                                      range(num_boundaries),
                                      [0] * num_boundaries))
```
Wrap list() around the range() like this:
```
rate_index = tf.reduce_max(tf.where(tf.greater_equal(global_step, boundaries),
                                     list(range(num_boundaries)),
                                      [0] * num_boundaries))
```
Check the link below as an reference.
https://github.com/tensorflow/models/issues/3705#issuecomment-375563179
