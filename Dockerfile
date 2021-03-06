FROM ubuntu
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
RUN apt-get install -y bc
COPY usr/ /usr/
COPY etc/ /etc/
COPY HiBenchRoot/ ./
ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
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
ENV PATH=$PATH:$SPARK_HOME/bin
ENV HDP_VERSION=2.3.6.0-3796
RUN useradd hdfs
RUN chown -R hdfs:hdfs HiBench
USER hdfs
