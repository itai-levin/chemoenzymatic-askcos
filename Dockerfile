FROM continuumio/miniconda3:4.8.2-alpine

USER root

RUN apk update && apk upgrade && apk add bash

COPY environment.yml /tmp/environment.yml

RUN /usr/sbin/addgroup -S askcos && \
    /usr/sbin/adduser -D -u 1000 askcos -G askcos && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/askcos/.profile && \
    echo "conda activate base" >> /home/askcos/.profile

RUN /opt/conda/bin/conda env update --file /tmp/environment.yml && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# Manually fix https://github.com/rdkit/rdkit/issues/2854
RUN sed -i 's/latin1/utf-8/g' /opt/conda/lib/python3.7/site-packages/rdkit/Chem/Draw/cairoCanvas.py

USER askcos

ENV PATH=/opt/conda/bin:${PATH}
