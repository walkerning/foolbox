#!/bin/bash
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
PYTHONPATH="/mock:${PYTHONPATH}" pytest --cov-append foolbox/tests/test_models_caffe.py
