# Dockerfile

```dockerfile
FROM gcr.io/tensorflow/tensorflow:latest-devel

# Comment
RUN echo 'building...'

RUN git clone https://github.com/tensorflow/models.git /models

WORKDIR /models/research/

# Make sure you grab the latest version
RUN curl -OL https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip
# Unzip
RUN unzip protoc-3.5.1-linux-x86_64.zip -d protoc3
# Move protoc to /usr/local/bin/
RUN mv protoc3/bin/* /usr/local/bin/
# Move protoc3/include to /usr/local/include/
RUN mv protoc3/include/* /usr/local/include/

RUN apt-get update && apt-get install -y \
  python-pil \
  python-lxml \
  python-tk \
  python-opencv \
  ffmpeg \
  protobuf-compiler

RUN pip install --upgrade pip
RUN pip install Cython matplotlib jupyter lxml pillow opencv-python moviepy

RUN git clone https://github.com/cocodataset/cocoapi.git object_detection/cocoapi

RUN cd object_detection/cocoapi/PythonAPI && make && cp -r pycocotools /models/research/

RUN cd /models/research/ && protoc object_detection/protos/*.proto --python_out=.

ENV PYTHONPATH $PYTHONPATH:`pwd`:`pwd`/slim

COPY video/video1.mp4 object_detection/test_images/
COPY video/video2.mp4 object_detection/test_images/

RUN rm /models/research/protoc-3.5.1-linux-x86_64.zip

EXPOSE 6006/tcp
EXPOSE 8888/tcp
```

## Building
docker build -t adsantos/tensorflow:0.1 -t adsantos/tensorflow:latest .

# Running image

```bash
docker run -it -p 6006:6006 -p 8888:8888 -v $PWD:/models adsantos/tensorflow:latest-devel

cd /models/research
```

## Testing

```
docker run -it adsantos/tensorflow:0.1

export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

python object_detection/builders/model_builder_test.py
```

## Runnig notebook
jupyter notebook --no-browser --allow-root

## Open notebook
open object_detection_video.ipynb