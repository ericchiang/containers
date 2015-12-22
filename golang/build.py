#!/usr/bin/python

from __future__ import print_function

import os
import subprocess as sp
import sys

if len(sys.argv) != 2:
    print("usage: %s [go version]" % (sys.argv[0],))
    sys.exit(2)

version = sys.argv[1]

tar = "go" + version + ".linux-amd64.tar.gz"
dockerfile = """FROM quay.io/brianredbeard/corebox
ADD %s /usr/local
ENV PATH $PATH:/usr/local/go/bin
RUN mkdir /go
ENV GOPATH /go
WORKDIR /go
CMD ["/bin/sh"]
""" % (tar,)
try:
    with open("Dockerfile", "w+") as f:
        f.write(dockerfile)
    sp.check_call(["wget", "https://storage.googleapis.com/golang/" + tar])
    img = "quay.io/ericchiang/golang:" + version
    sp.check_call(["docker", "build", "-t", "quay.io/ericchiang/golang:" + version, "."])
    sp.check_call(["docker", "push", img])
    sp.check_call(["docker", "rmi", img])
finally:
    for file in ["Dockerfile", tar]:
        if os.path.exists(file):
            os.remove(file)
