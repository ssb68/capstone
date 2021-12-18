#!/usr/bin/env bash

minikube delete
sudo sysctl fs.inotify.max_user_instances=512
minikube start

