# This is docker file for our sonarqube-scanner. You don't need to read it since
# the goal of this tutorial isn't about teaching docker or about presenting the best 
# way for creating Sonarqube scanner image. Of course feel free to check on it if you like.
# Get dotnetcore SDK
FROM microsoft/dotnet:2.2.104-sdk AS sonarqube

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOM

# Env variables
ENV NODE_VERSION 10.13.0
ENV NODE_DOWNLOAD_SHA b4b5d8f73148dcf277df413bb16827be476f4fa117cbbec2aaabc8cc0a8588e1

# Install node.js
RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# Install global tools
RUN dotnet tool install -g dotnetsay
RUN dotnet tool install --global dotnet-sonarscanner --version 4.5.0

# Add global tools folder to PATH
ENV PATH="${PATH}:/root/.dotnet/tools"

# Get required packages for sonar scanner
RUN apt-get update && apt-get -y install curl bash unzip yarn bzip2

WORKDIR /root

ENV LATEST='sonar-scanner-cli-3.3.0.1492-linux.zip'

# Get & install sonar scanner
RUN env && \
curl -OL 'https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/'$LATEST && \
mkdir sonar_scanner && unzip -d sonar_scanner $LATEST && mv sonar_scanner/* sonar_home && \
rm -rf sonar_scanner $LATEST

# Add sonar scanner to PATH
ENV SONAR_RUNNER_HOME=/root/sonar_home
ENV PATH ${SONAR_RUNNER_HOME}/bin:$PATH

ARG SONAR_HOST
ARG SONAR_LOGIN_TOKEN

# make temporary folder for seed analysis for javascript scanner
WORKDIR /root/temp1
RUN mkdir src
RUN touch src/test.js
# Init sonarscanner cache with plugins
RUN sonar-scanner -Dsonar.host.url=$SONAR_HOST -Dsonar.login=$SONAR_LOGIN_TOKEN -Dsonar.analysis.mode=preview -Dsonar.projectKey="pluginsSeedJS" -Dsonar.sources="src"

WORKDIR /root

# Remove temporary folder
RUN rm /root/temp1 -rf

# make temporary folder for seed analysis
WORKDIR /root/temp2
# Init sonarscanner cache with plugins for .NET scanner
RUN dotnet sonarscanner begin /k:"pluginsSeedNET" /d:sonar.host.url=$SONAR_HOST /d:sonar.login=$SONAR_LOGIN_TOKEN /d:sonar.analysis.mode=preview
RUN dotnet new sln --name FooBar
RUN dotnet new mvc --name Foo --output Foo
RUN dotnet new console --name Bar --output Bar
RUN dotnet sln add ./Foo/Foo.csproj
RUN dotnet sln add ./Bar/Bar.csproj
RUN dotnet restore
RUN dotnet build FooBar.sln
RUN dotnet sonarscanner end /d:sonar.login=$SONAR_LOGIN_TOKEN ; exit 0

WORKDIR /root

# Remove temporary folder
RUN rm /root/temp2 -rf

# # It is our freshly build sonar-scanner-image from previous steps that
# # is used here as a base image in docker file that we will be working on
# FROM sonar-scanner-image:latest AS sonarqube_scan
# # Here we are setting up a working directory to /app. It is like using `cd app` command
# WORKDIR /app
# # Copying all files from the project directory to our current location (/app) in image
# # except patterns mention in .dockerignore
# COPY . .
# # Execution of example command. Here it is used to show a list of files and directories.
# # It will be useful in later exercises in this tutorial. 
# RUN ls -list
# # To execute sonar-scanner we just need to run "sonar-scanner" in the image. 
# # To pass Sonarqube parameter we need to add "-D"prefix to each as in the example below
# # sonar.host.url is property used to define URL of Sonarqube server
# # sonar.projectKey is used to define project key that will be used to distinguish it in 
# # sonarqube server from other projects
# # sonar.sources directory for sources of project

# ARG SONAR_HOST
# ARG SONAR_LOGIN_TOKEN

# RUN sonar-scanner \
#     -Dsonar.host.url=${SONAR_HOST} \
#     -Dsonar.projectKey=ee100bbdcf2b5866487a937ede2017e2da9b99a0 \
#     -Dsonar.sources="src"