FROM python:3.5-stretch as build

RUN apt-get update && \
    apt-get install -y git gcc cmake software-properties-common build-essential python-dev libopenblas-dev libeigen3-dev sqlite3 libsqlite3-dev libboost-dev libboost-system-dev libboost-thread-dev libboost-serialization-dev libboost-iostreams-dev libboost-python-dev libboost-regex-dev libcairo2 libcairo2-dev libjpeg-dev libgif-dev && \
    pip install numpy==1.17.4

RUN export RDBASE=/usr/local/rdkit && \
    export LD_LIBRARY_PATH=$RDBASE/lib:$LD_LIBRARY_PATH && \
    export PYTHONPATH=$RDBASE:$PYTHONPATH && \
    git clone -b Release_2019_03_4 https://github.com/rdkit/rdkit.git $RDBASE && \
    cd $RDBASE && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j8 && \
    make install

FROM python:3.5-stretch

RUN apt-get update && \
    apt-get install -y python python-pip libboost-thread-dev libboost-python-dev libboost-iostreams-dev && \
    pip install numpy==1.17.4

COPY --from=build /usr/local/rdkit/rdkit /usr/local/rdkit/rdkit
COPY --from=build /usr/local/rdkit/lib /usr/local/rdkit/lib

ENV LD_LIBRARY_PATH=/usr/local/rdkit/lib:$LD_LIBRARY_PATH
ENV PYTHONPATH=/usr/local/rdkit:$PYTHONPATH
