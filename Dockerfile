FROM gcr.io/tensorflow/tensorflow:latest-devel

# Comment
RUN echo 'building...'

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