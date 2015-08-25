#!/bin/bash
cd /home/sampath/projects/analytics-server/
source /home/sampath/projects/analytic-env/bin/activate
/home/sampath/projects/analytics-server/g celery worker -Q master

