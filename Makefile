## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.capstone

source:
	. ~/.capstone/bin/activate

install:
	# This should be run from inside a virtualenv
	pip3 install --upgrade pip && \
	pip3 install -r requirements.txt
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:	
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 app.py

hadolint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile

build-image:
	# Build image and add a descriptive tag
	docker build -t ${PROJECT} .
	docker images

push-image:
	# push image to docker.io
    docker tag ${PROJECT} ${USER}/${PROJECT}:${IMAGE_TAG}
    echo ${PASS} | docker login -u ${USER} --password-stdin
    docker push ${USER}/${PROJECT}:${IMAGE_TAG}

deploy-app:
    # using the current context and default namespace
	kubectl apply -f ./deployment.yaml

deploy-service:
    # using the current context and default namespace
	kubectl apply -f ./service-yaml

all: install lint test
