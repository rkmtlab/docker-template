#!/bin/sh
service ssh start
jupyter lab --ip=0.0.0.0 --port=${PORT} --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''
