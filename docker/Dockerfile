FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

COPY certs /certs
COPY conf/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN apt-get update && \
    apt-get -y install curl python3-pip build-essential libssl-dev libffi-dev python3-dev

RUN curl -O https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    bash Anaconda3-2020.02-Linux-x86_64.sh -b -p /opt/conda && \
    eval "$(/opt/conda/bin/conda shell.bash hook)" && \
    conda create -y --name env python=3.7 && \
    conda install -n env -c rapidsai -c nvidia -c conda-forge -c defaults -c anaconda -c bioconda \
    rapids=0.13 jupyterlab==2.1.3 scikit-learn tensorflow-gpu tensorboard dask-kubernetes ray seaborn && \
    conda init

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /code
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
