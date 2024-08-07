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
  echo -e "\e[32m-Downloading-Jenkins-repo-config-file-SUCCESS-\e[0m"
else
  echo -e "\e[31m-Downloading-Jenkins-repo-config-file-FAILURE-\e[0m"
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
  echo -e "\e[32m-import-Jenkins-key-SUCCESS-\e[0m"
else
  echo -e "\e[31m-import Jenkins key-FAILURE-\e[0m"
  exit 1
fi

PRINT Installing Jenkins Prerequisite -Java

yum install fontconfig java-17-openjdk &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-Installing Jenkins Prerequisite -Java-SUCCESS-\e[0m"
else
  echo -e "\e[31m-Installing Jenkins Prerequisite -Java-FAILURE-\e[0m"
  exit 1
fi

PRINT Installing Jenkins

yum install jenkins -y &>>$LOG_FILE

if [ $? -eq 0 ]; then
  echo -e "\e[32m-Installing Jenkins-SUCCESS-\e[0m"
else
  echo -e "\e[31m-Installing Jenkins-FAILURE-\e[0m"
  exit 1
fi

 #If you've previously imported the key from Jenkins, the rpm --import will fail because you already have a key. Please ignore that and move on.


PRINT Starting Jenkins
systemctl restart jenkins &>>$LOG_FILE
if [ $? -eq 0 ]; then
  echo -e "\e[32m-Starting Jenkins-SUCCESS-\e[0m"
else
  echo -e "\e[31m-Starting Jenkins-FAILURE-\e[0m"
  exit 1
fi