FROM oraclelinux:latest
RUN yum install sudo git wget docker-engine java kubectl python-setuptools -y --enablerepo=ol7_addons
RUN easy_install pip && pip install ansible && pip install youtube-dl 
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo && rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && yum install jenkins -y
RUN chown jenkins:jenkins /etc/sysconfig/jenkins
RUN echo "jenkins	ALL=(ALL)	NOPASSWD: ALL" > /etc/sudoers.d/010-jenkins
EXPOSE 8080
VOLUME /var/lib/jenkins
USER jenkins
CMD . /etc/sysconfig/jenkins; java -DJENKINS_HOME=/var/lib/jenkins -jar /usr/lib/jenkins/jenkins.war
