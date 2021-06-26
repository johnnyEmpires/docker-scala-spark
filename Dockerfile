FROM openjdk:8u151-jre-alpine

WORKDIR /root

ENV SCALA_VERSION=2.12.4 \
    SCALA_HOME=/usr/share/scala \
    ENV=/root/.ashrc \
    SPARK_VER=spark-3.1.2 \
    HADOOP_VER=hadoop3.2

# NOTE: bash is used by scala/scalac scripts, and it cannot be easily replaced with ash.
RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash curl jq && \
    cd "/tmp" && \
    wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*


# update wget
RUN apk add --no-cache wget
RUN wget --no-verbose https://ftp.tsukuba.wide.ad.jp/software/apache/spark/${SPARK_VER}/${SPARK_VER}-bin-${HADOOP_VER}.tgz \
   -P /root

RUN mkdir /root/spark && \
   cd /root && \
   tar -xzf /root/${SPARK_VER}-bin-${HADOOP_VER}.tgz && \
   mv /root/${SPARK_VER}-bin-${HADOOP_VER}/* /root/spark && \
   rm -rf /root/${SPARK_VER}-bin-${HADOOP_VER}.tgz && \
   rm -rf /root/${SPARK_VER}-bin-${HADOOP_VER}

# workaround: spark nohup error
RUN apk --update add coreutils

ADD .ashrc /root

# convert windows formatted file to unix-like
RUN dos2unix /root/.ashrc

