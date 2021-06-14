#!/bin/bash
while [ true ]
do
    echo $(date +%H%M%S) $(curl -s http://127.0.0.1:8080)
    sleep 1
done
