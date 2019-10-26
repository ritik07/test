#!/bin/bash

BUCKET=cloud-training-demos-ml
REGION=us-central1
OUTPUT_DIR=gs://${BUCKET}/flights/chapter9/output
DATA_DIR=gs://${BUCKET}/flights/chapter8/output
JOBNAME=flights_$(date -u +%y%m%d_%H%M%S)

PATTERN="Flights-00001*"
#PATTERN="Flights*"

echo "Launching training job ... trained model will be in $OUTPUT_DIR"

gsutil -m rm -rf $OUTPUT_DIR
gcloud ml-engine jobs submit training $JOBNAME \
  --region=$REGION \
  --module-name=trainer.task \
  --package-path=$(pwd)/flights/trainer \
  --job-dir=$OUTPUT_DIR \
  --staging-bucket=gs://$BUCKET \
  --config=hyperparam.yaml \
  -- \
   --output_dir=$OUTPUT_DIR \
   --traindata $DATA_DIR/train$PATTERN --evaldata $DATA_DIR/test$PATTERN --num_training_epochs=5
