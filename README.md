# java-app-on-kubernetes
Orchestrating a simple java app in a kubernetes cluster. This is a simple Spring Boot application that suports a REST API and does persistence using JPA.

# 01-Running a MySQL database in a docker container
To perform the tests, it is required to have docker ce installed in your Linux distribution. Link to [Ubuntu installation](https://docs.docker.com/v17.12/install/linux/docker-ce/ubuntu/#install-docker-ce-1). 

In order to setup the database, go to the docker package and execute the run.sh file, as shown bellow:

```
	# if you are in the root of maven project
	cd docker && ./run.sh
```

After that, then the tests can be performed executing the following command:

```
	cd .. && mvn test
```

# 02-Packaging and deploying the application with minikube
Minikube is being used as a single node Kubernetes cluster, in order to perform orchestration. For this example, coding, testing and delivering phases are being performed on the same machine. Tools like Jenkins can be used for continuous delivery. Ansible is an option to make easier the development of the script on delivery process. It is required to have minikube installed in your Linux distribution. In the current version, only one container will be created. However, when this container is killed, minikube will create another one. Link to [Ubuntu installation](https://kubernetes.io/docs/tasks/tools/install-minikube/#install-minikube). 

In order to deploy everything just execute the deploy.sh file in the kubernetes folder, as shown bellow:

```
	# if you are in the root of maven project
	cd kubernetes && ./run.sh
```

To shutdown everything execute the shutdown.sh file on the same folder.

```
	# if you are in the root of maven project
	cd kubernetes && ./shutdown.sh
```

On this example, no action occurs when the automated tests fail.

# 03-Update the application with minikube

This step will update the application. This update does not make the application unavailable. 

To update the application running in the cluster, is required to update the version of the container image in the file kubernetes/app/newversion.yaml, as this example bellow:
```
...
    spec:
      containers:
      - name: antarezapp
        image: marcelomata/antarezapp:0.0.11
...
```

After that, execute the following file in the kubernetes folder:
```
	# if you are in the kubernetes folder
	./update-app.sh -v '0.0.11'
```

Note that the new version of the container image must to be passed on v parameter.

One way to check how the system is answering the request is execute this command:
```
while true; do curl http://192.168.99.100:$(kubectl get service antarezapp-deployment --output jsonpath='{.spec.ports[*].nodePort}')/customers; sleep 0.3; done
```

To shutdown everything execute the shutdown.sh file on the same folder.

```
	# if you are in the root of maven project
	cd kubernetes && ./shutdown.sh
```


The tools and OS used on this examples were: Docker (version 18.06.1-ce), kubectl (version v1.13.2), Minikube (version v0.32.0), Maven (version 3.3.9), JDK (version 1.8.0_181) and Ubuntu 16.04.


This project is based on Spring Boot's [HATEOAS example](https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples/spring-boot-sample-hateoas).



