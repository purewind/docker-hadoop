FROM purewind/jdk-7:latest

MAINTAINER purewind "qingfengbaozai@gmail.com"  

ENV PATH=$PATH:/hadoop/bin

WORKDIR /

# Install Oracle JDK 7u80
# https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz"
RUN apt-get update && \
    apt-get install -y ssh openssh-server && \
    service ssh start && \
    wget -q 'https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz' && \
    tar -xf "hadoop-2.7.3.tar.gz" && \
    rm -f "hadoop-2.7.3.tar.gz"  && \
    ln -s hadoop* hadoop && \
    { rm -rf hadoop/share/doc; : ; } && \
    /hadoop/bin/hdfs namenode -format
    
COPY entrypoint.sh /
COPY conf/core-site.xml /hadoop/etc/hadoop/
COPY conf/hdfs-site.xml /hadoop/etc/hadoop/
COPY conf/yarn-site.xml /hadoop/etc/hadoop/
COPY conf/mapred-site.xml /hadoop/etc/hadoop/
COPY profile.d/hadoop.sh /etc/profile.d/

EXPOSE 8020 8042 8088 9000 10020 19888 50010 50020 50070 50075 50090

CMD "/entrypoint.sh"