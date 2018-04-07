git clone https://github.com/tensorflow/models.git /models

git clone https://github.com/cocodataset/cocoapi.git object_detection/cocoapi

cd models/object_detection/cocoapi/PythonAPI && make && cp -r pycocotools /models/research/

cd /models/research/ && protoc object_detection/protos/*.proto --python_out=.

export PYTHONPATH $PYTHONPATH:`pwd`:`pwd`/slim

cp video/video1.mp4 object_detection/test_images/
cp video/video2.mp4 object_detection/test_images/

#rm /models/research/protoc-3.5.1-linux-x86_64.zip

docker run -it -p 6006:6006 -p 8888:8888 -v $PWD/models:/models/research/object_detection -v $PWD/my-notebooks:/models/research/object_detection/my-notebooks adsantos/tensorflow:latest-devel