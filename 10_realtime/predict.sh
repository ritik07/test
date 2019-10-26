#!/bin/bash

gsutil -m rm -rf gs://cloud-training-demos-ml/flights/chapter10/output
bq rm -f flights.predictions

cd ../08_dataflow/chapter8

mvn compile exec:java \
 -Dexec.mainClass=com.google.cloud.training.flights.AddRealtimePrediction \
 -Dexec.args="--realtime --speedupFactor=300 --maxNumWorkers=10 --autoscalingAlgorithm=THROUGHPUT_BASED"

