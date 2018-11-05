#!/bin/bash
# Only python2 caffe image is provided now.
# See https://github.com/BVLC/caffe/issues/5781

pip install -r requirements-dev.txt
pip install mock
pip install -e .
mkdir /mock
cat >>/mock/tensorflow.py<<EOF
__version__ = "mock"
EOF
cat >>/mock/torch.py<<EOF
__version__ = "mock"
EOF
find . -type d -name __pycache__  -o \( -type f -name '*.py[co]' \) -print | xargs rm -rf

PYTHONPATH="/mock:${PYTHONPATH}" pytest --cov-append foolbox/tests/test_models_caffe.py
