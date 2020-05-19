FROM python:3.7.1-slim

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  gcc

RUN apt-get install git -y

WORKDIR /hub
RUN pip install pyzmq
RUN git clone https://github.com/spel-uchile/SUCHAI-Flight-Software.git
WORKDIR /hub/SUCHAI-Flight-Software/sandbox/csp_zmq

CMD ["python", "-u", "zmqhub.py", "--mon"]