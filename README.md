[![CircleCI](https://circleci.com/gh/ssb68/capstone/tree/master.svg?style=svg)](https://circleci.com/gh/ssb68/capstone/tree/master)

## Project Overview

This is a Udacity DevOps "capstone" project.  It represents the skills acquired through the completion of this course. 
The actual application deployed by this repository of code is a simple python application that displays a web page (which includes version info, a hello message and a coloured background.)

### Technoloy stacks

CirleCI - for Continous build and deployment (including AWS EKS build)
AWS CloudFormation utilised via eksctl
eksctl - for simplyfing the Kubernetes cluster config in AWS
Kubernetes (EKS)
kubectl for managing the kubernetes deployments from command line
Docker Hub (built image repo used in this project)
GitHub

### How to configure
In order to run this project in CircleCI

Clone the GitHub repo to your own.
Configure your CirceCI project with your Git credentials
Create the following required Project ENV variables with appropriate values:
```
  AWS_ACCESS_KEY_ID
  AWS_DEFAULT_REGION
  AWS_SECRET_ACCESS_KEY
  CAPSTONE_PROJECT
  CLUSTER_STACK_NAME
  DOCKER_PASS
  DOCKER_USER
```

### How to use
The Circle CI workflow will not only build the project, but will also deploy the the full EKS cluster in AWS.  Typically you would only do this once.  In order to control when the EKS cluster is build you MUST set the following workflow flag 
```
- createEKScluster: 
          # ONLY set to true for first deployment 
          create: true

For subsequent builds set the flag as follows
- createEKScluster: 
          # ONLY set to true for first deployment 
          create: false
```

On initial deployment of the application image into the kubernetes cluster it will deploy "V1" aka version 1 of the application.  In order to test the rolling update (no down time) capability of the application all you need to do is alter a variable in the Dockerfile as per below exert. 

    ## Step 5:
    # just change this value for to v2 for testing rolling updates
    ENV HELLO_VERSION=hello-v1.html

### Sample Output
Version 1
```
![Link](https://github.com/ssb68/capstone/blob/master/sample-output/V1-Screenshot.png)
```
Version 2
```
![Link](https://github.com/ssb68/capstone/blob/master/sample-output/V2-Screenshot.png)
```
