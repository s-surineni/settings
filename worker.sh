#!/bin/bash
cd $HOME/projects/analytics-server/
source $HOME/projects/servenv/bin/activate
$HOME/projects/analytics-server/g celery worker -Q worker 
