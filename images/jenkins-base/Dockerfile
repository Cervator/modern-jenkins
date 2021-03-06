# images/jenkins-base/Dockerfile
FROM centos:7
MAINTAINER matt@notevenremotelydorky

LABEL dockerfile_location=https://github.com/technolo-g/modern-jenkins/tree/master/images/jenkins-base/Dockerfile \
      image_name=modernjenkins/jenkins-base \
      base_image=centos:7

# Jenkins' Environment
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_ROOT /usr/share/jenkins
ENV JENKINS_WAR /usr/share/jenkins/ref/warfile/jenkins.war
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV user=jenkins
ENV group=jenkins
ENV uid=1000
ENV gid=1000

# Jenkins Version info
ENV JENKINS_VERSION 2.176.2
ENV JENKINS_SHA 33a6c3161cf8de9c8729fd83914d781319fd1569acf487c7b1121681dba190a5

# These URLs can be swapped out for internal repos if needed. Secrets required may vary :)
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_URL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

# Optional extra hook for Job DSL examples, used in one of the init scripts if present. No DSL repo env var == no job DSL set up
ENV GITOPS_DSL_REPO https://github.com/Cervator/GitOpsUtilityJobs.git

# The manifest repo is meant to contain additional configuration
ENV GITOPS_MANIFEST_REPO https://github.com/Cervator/GitOpsManifest.git

# This context allows a set of tiered Jenkins Masters to pull config out from a specific tier
ENV GITOPS_JENKINS_CONTEXT dev

# Default examples work without credentials but will read this one if set (creating it in Jenkins is a different topic)
# ENV GIT_CREDENTIAL SomeCredential

# Optional extra - set a different branch to use by default (which is master)
# ENV GITOPS_PLATFORM_LEVEL develop

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${group} -s /bin/bash ${user}

# Install our tools and make them executable
COPY files/jenkins-support /usr/local/bin/jenkins-support
RUN mkdir -p ${JENKINS_ROOT}
RUN chown jenkins /usr/local/bin/* ${JENKINS_ROOT} \
    && chmod +x /usr/local/bin/*

# Configure to New York TZ
RUN unlink /etc/localtime && ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

# Install Java, Git, and Unzip
RUN yum install -y java-1.8.0-openjdk-devel tzdata-java git unzip \
    && yum clean all
