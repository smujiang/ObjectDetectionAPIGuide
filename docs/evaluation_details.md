
Running arguments of eval.py

|arguments         | default| description |
|------------------|--------|-------------|
|eval_training_data| False|If training data should be evaluated for this job.|
|checkpoint_dir|' '|Directory containing checkpoints to evaluate, typically set to `train_dir` used in the training job.|
|eval_dir|' '|Directory to write eval summaries to.|
|pipeline_config_path| ' '|Path to a pipeline_pb2.TrainEvalPipelineConfig config file. If provided, other configs are ignored|
|eval_config_path|' '|Path to an eval_pb2.EvalConfig config file.|
|input_config_path|' '|Path to an input_reader_pb2.InputReader config file.|
|model_config_path|' '|Path to a model_pb2.DetectionModel config file.|
|run_once|False|Option to only run a single pass of evaluation. Overrides the `max_evals` parameter in the provided config.|

Tried:
1. different check point
2. different value of "run_once"
3. eval_training_data = True