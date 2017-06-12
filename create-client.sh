#!/bin/bash -e
ambariClientSrc=( "/usr/hdp" "/usr/jdk64" "/etc/hadoop" "/etc/hive" "/etc/spark" "/etc/zookeeper" "/etc/tez" )

if [[ "$1" == 'hdp' && "$2" == "normalnode" ]] 
then
if [ "$#" -ne 4 ]
then 
  echo "Usage : $0 hdp normalnode sourceserver user"
  exit 1 
fi
    for i in "${ambariClientSrc[@]}"
    do
      if [ -d $i ]
      then
           #sudo cp -R $i ./
	   echo "Copying $i"
	   IFS='/' read -ra path <<< "$i"
           
           echo $path[1]
           if [ "${path[1]}" == 'etc' ]
           then
             echo "Here"
	     rsync -avz --exclude "container-executor" $4@$3:$i ./etc/
	     #sudo cp -R $i ./etc/   
             #sudo chown -R $USER:$USER ./etc/${path[2]}
	   elif [ "${path[1]}" == 'usr' ]
	   then
	     rsync -avz $4@$3:$i --exclude "container-executor" ./usr/
	     #sudo cp -R $i ./usr/
             echo "Here"
	     #sudo chown -R $USER:$USER ./usr/${path[2]}
	   fi
      fi
    done
#Start building the docker file dynamically
> Dockerfile
echo 'FROM ubuntu
RUN apt-get update
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get clean

RUN apt-get install -y openssh-server
RUN apt-get install -y openssh-client
RUN apt-get install -y rsync
RUN apt-get install -y iputils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y vim
RUN apt-get install -y sudo
RUN apt-get install -y python
RUN apt-get install -y bc' >> Dockerfile


echo 'COPY usr/ /usr/' >> Dockerfile
echo 'COPY etc/ /etc/' >> Dockerfile
echo 'COPY HiBenchRoot/ ./' >> Dockerfile

echo 'ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
ENV PATH=$PATH:$JAVA_HOME/bin
ENV HADOOP_HOME=/usr/hdp/current/hadoop-client
ENV PATH=$PATH:$HADOOP_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/sbin
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
ENV CLASSPATH=$CLASSPATH:/usr/hdp/current/hadoop-client/lib/*:.


ENV HIVE_HOME=/usr/hdp/current/hive-client
ENV PATH=$PATH:$HIVE_HOME/bin
ENV CLASSPATH=$CLASSPATH:/usr/hdp/current/hive-client/lib/*:.

ENV SPARK_HOME=/usr/hdp/current/spark-client
ENV PATH=$PATH:$SPARK_HOME/bin' >> Dockerfile

echo 'ENV HDP_VERSION=2.3.6.0-3796' >> Dockerfile



echo 'RUN useradd hdfs
RUN chown -R hdfs:hdfs HiBench
USER hdfs' >> Dockerfile


sudo docker build -t normalnode .
sudo docker run --name benchmarknormalnode --network=host -p 8080:80 -it normalnode bash
elif [[ "$1" == "hdp" && "$2" == "edgenode" ]]
then 
mkdir -p papbedge
cd papbedge
echo "Building Dockerfile for edgenode"
#Start building the docker file from here
> Dockerfile
echo 'FROM ubuntu
RUN apt-get update

RUN useradd hdfs
RUN mkdir HiBench
RUN chown -R hdfs:hdfs HiBench
USER hdfs' >> Dockerfile

sudo docker build -t edgenode .
#sudo docker run -it edgenode bash
sudo docker run --name edgenodevolume --network=host -p 8080:80 -it -v /etc/:/etc -v /usr/:/usr -v /home/sc/papbfiles/HiBenchRoot/HiBench/:/HiBench edgenode bash
fi
