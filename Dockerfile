FROM python:3.7-buster as build

RUN apt-get update && \
    apt-get install -y git gcc cmake software-properties-common build-essential python-dev libopenblas-dev libeigen3-dev sqlite3 libsqlite3-dev libboost-all-dev libcairo2 libcairo2-dev libjpeg-dev libgif-dev && \
    pip install numpy==1.19.0

COPY gh2855.patch /tmp/gh2855.patch

RUN export RDBASE=/tmp/rdkit && \
    git clone -b Release_2020_03_4 https://github.com/rdkit/rdkit.git $RDBASE && \
    cd $RDBASE && \
    git apply /tmp/gh2855.patch && \
    mkdir build && \
    cd build && \
    cmake -DRDK_INSTALL_INTREE=OFF -DCMAKE_INSTALL_PREFIX=/usr/local/rdkit .. && \
    make && \
    make install

FROM python:3.7-buster

RUN apt-get update && \
    apt-get install -y python python-pip libboost-thread-dev libboost-python-dev libboost-iostreams-dev && \
    pip install numpy==1.19.0

COPY --from=build /usr/local/rdkit /usr/local/rdkit

ENV LD_LIBRARY_PATH=/usr/local/rdkit/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH=/usr/local/rdkit/lib/python3.7/site-packages:$PYTHONPATH
