# Use an Ubuntu base image
FROM ubuntu:20.04

# Install necessary packages (SSH, OpenJDK, Hadoop dependencies, etc.)
RUN apt-get update && apt-get install -y \
    openssh-client \
    openssh-server \
    openjdk-8-jdk \
    wget \
    sudo \
    && apt-get clean

# Install Hadoop
ENV HADOOP_VERSION 3.4.1
RUN wget https://downloads.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz \
    && tar -xzvf hadoop-$HADOOP_VERSION.tar.gz \
    && mv hadoop-$HADOOP_VERSION /opt/hadoop \
    && rm hadoop-$HADOOP_VERSION.tar.gz


# Set environment variables
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /opt/hadoop/etc/hadoop/hadoop-env.sh
ENV PATH : $PATH:$JAVA_HOME/bin

# Create hdfs user
RUN useradd -m hdfs

# Set the HDFS user environment variables
ENV HDFS_NAMENODE_USER hdfs
ENV HDFS_DATANODE_USER hdfs
ENV HDFS_SECONDARYNAMENODE_USER hdfs
ENV YARN_RESOURCEMANAGER_USER hdfs
ENV YARN_NODEMANAGER_USER hdfs
ENV MAPRED_HISTORYSERVER_USER hdfs

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile.d/hadoop-env.sh && \
    echo "export HADOOP_HOME=/opt/hadoop" >> /etc/profile.d/hadoop-env.sh && \
    echo "export PATH=\$PATH:/opt/hadoop/bin:/opt/hadoop/sbin:/usr/lib/jvm/java-8-openjdk-amd64/bin" >> /etc/profile.d/hadoop-env.sh


# Configure SSH: Set up passwordless login and configure SSH for Hadoop
RUN mkdir -p /home/hdfs/.ssh && \
    ssh-keygen -t rsa -P "" -f /home/hdfs/.ssh/id_rsa && \
    cat /home/hdfs/.ssh/id_rsa.pub >> /home/hdfs/.ssh/authorized_keys && \
    chown -R hdfs:hdfs /home/hdfs/.ssh && \
    chmod 700 /home/hdfs/.ssh && \
    chmod 600 /home/hdfs/.ssh/authorized_keys && \
    chown -R hdfs:hdfs /opt/hadoop && \
    chmod -R 755 /opt/hadoop

# Expose port for SSH
EXPOSE 22

# Set entry point
CMD service ssh start && /bin/bash
