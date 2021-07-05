# Deploying standard voting example on k8s using terraform

This repository contains the code to deploy [example voting app](https://github.com/dockersamples/example-voting-app) on local minikube cluster using terraform script.

## Pre-requisite
- Docker
  - curl -fsSL https://get.docker.com -o get-docker.sh
  - sudo sh get-docker.sh
- minikube and ingress
  - Install minikube
    - curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    - sudo install minikube-linux-amd64 /usr/local/bin/minikube
  - Start minikube
    - minikube start
  - Install ingress on minikube
    - minikube addons enable ingress

## Application Architecture
This is an simple distributed application running across multiple containers:
- A front-end web app in Python or ASP.NET Core which lets you vote between two options
- A Redis or NATS queue which collects new votes
- A .NET Core, Java or .NET Core 2.1 worker which consumes votes and stores them in…
- A Postgres or TiDB database
- A Node.js or ASP.NET Core SignalR webapp which shows the results of the voting in real time

![Architecture Diagram](https://raw.githubusercontent.com/dockersamples/example-voting-app/master/architecture.png)
