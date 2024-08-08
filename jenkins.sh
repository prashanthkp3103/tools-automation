LOG_FILE=/tmp/jenkins.log
rm -rf $LOG_FILE

PRINT () {
  echo &>>$LOG_FILE
  ecgo &>>$LOG_FILE
  echo "##################### $* #######################" &>>$LOG_FILE
  echo $*

  }

PRINT copying Jenkins repo config file
#Create Nginx Reverse Proxy Configuration to reach backend services.
cp jenkins.repo /etc/yum.repos.d/jenkins.repo &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-SUCCESS-\e[0m"
else
  echo -e "\e[31m-FAILURE-\e[0m"
  exit 1
fi

#PRINT Downloading-JenkinsRepofile
#
#wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOG_FILE
#
#if [ $? -eq 0 ]; then
#  echo -e "\e[32m-Downloading-JenkinsRepofile-SUCCESS-\e[0m"
#else
#  echo -e "\e[31m-Downloading-JenkinsRepofile-FAILURE-\e[0m"
#  exit 1
#fi
#
#PRINT Completed-Downloading-JenkinsRepofile-Completed

PRINT import Jenkins key

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-SUCCESS-\e[0m"
else
  echo -e "\e[31m-FAILURE-\e[0m"
  exit 1
fi

PRINT Installing Jenkins Prerequisite -Java

yum install fontconfig java-17-openjdk &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-SUCCESS-\e[0m"
else
  echo -e "\e[31m-FAILURE-\e[0m"
  exit 1
fi

PRINT Installing Jenkins

yum install jenkins -y &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-SUCCESS-\e[0m"
else
  echo -e "\e[31m-FAILURE-\e[0m"
  exit 1
fi

 #If you've previously imported the key from Jenkins, the rpm --import will fail because you already have a key. Please ignore that and move on.


PRINT Starting Jenkins
systemctl enable jenkins &>>$LOG_FILE
systemctl restart jenkins &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32m-SUCCESS-\e[0m"
else
  echo -e "\e[31m-FAILURE-\e[0m"
  exit 1
fi