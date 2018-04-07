#!/bin/bash

echo "Run inside docker"

git clone https://github.com/cocodataset/cocoapi.git models/research/object_detection/cocoapi

cd /models/research/object_detection/cocoapi/PythonAPI

make

cp -r pycocotools /models/research

cd /models/research

protoc object_detection/protos/*.proto --python_out=.

export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

python object_detection/builders/model_builder_test.py

cd object_detection/

jupyter notebook --no-browser --allow-root
