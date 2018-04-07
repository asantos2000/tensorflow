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

EXPOSE 6006/tcp
EXPOSE 8888/tcp
```

## Building with built-in model
docker build -t adsantos/tensorflow-model:0.1 -t adsantos/tensorflow-model:latest-devel .

## Building without
docker build -t adsantos/tensorflow:0.1 -t adsantos/tensorflow:latest-devel .


# Running image

```bash
docker run -it -p 6006:6006 -p 8888:8888 -v $PWD/my-samples:/models/research/object_detection/my-samples adsantos/tensorflow:latest-devel

```

## Testing

```
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

python object_detection/builders/model_builder_test.py

cd object_detection/

jupyter notebook --no-browser --allow-root
```

## Runnig notebook
jupyter notebook --no-browser --allow-root

## Open notebook
open object_detection_video.ipynb