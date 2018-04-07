git clone https://github.com/tensorflow/models.git models

cp video/*.mp4 models/research/object_detection/test_images/
cp setup-extras.sh models/research/setup-extras.sh

docker run -it --rm --name tensorflow -p 6006:6006 -p 8888:8888 -v $PWD/models:/models -v $PWD/my-notebooks:/models/research/object_detection/my-notebooks adsantos/tensorflow:latest-devel