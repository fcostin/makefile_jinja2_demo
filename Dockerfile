FROM debian:stable-slim

RUN apt update --yes && apt install --yes python-pip make
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV WORKING_DIR /tmp/work
RUN mkdir -p ${WORKING_DIR}
WORKDIR ${WORKING_DIR}

COPY env.yaml .
COPY Makefile .
COPY scripts/* ./scripts/
COPY templates/* ./templates/

RUN make
