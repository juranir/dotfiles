
# GIT FUNCTIONS
##################################

git_pull_current (){
    R='\033[0;31m'
    G='\033[0;32m'
    NOCOLOR='\033[0m'
    
    CURRENT_DIR=`pwd`
    echo "----------------------------------------"
    for DIR in `find $CURRENT_DIR -maxdepth 2 -name .git -type d | sort |rev | cut -d "/" -f2 | rev`; do
        # echo "dir: $DIR"
        cd "$CURRENT_DIR/$DIR"
        CURRENT_BRANCH=`git branch --show-current`

        echo "Updating '$DIR'"

        if [[ $CURRENT_BRANCH != "master" ]];then
            echo "Current branch:$R $CURRENT_BRANCH $NOCOLOR"
        else
            echo "Current branch:$G $CURRENT_BRANCH $NOCOLOR"
        fi

        # echo "Current Branch:$Y `git branch --show-current` $NOCOLOR" &&
        git fetch origin &&\
        git pull &&\
        cd ..
        echo "----------------------------------------"
    done
    cd $CURRENT_DIR
}

git_pull_all (){ 
    echo "\n>>>>> Updating Infra <<<<<\n"
    cd-i
    git_pull_current

    echo "\n>>>>> Updating Terraform-APS <<<<<\n"
    cd-itaps
    git_pull_current

    echo "\n>>>>> Updating Terraform-Modules <<<<<\n"
    cd-itm 
    git_pull_current

    echo "\n>>>>> Updating Terraform-Deploy <<<<<\n"
    cd-itd
    git_pull_current

    echo "\n>>>>> Updating General Helm-charts <<<<<\n"
    cd-ih
    git_pull_current

    echo "\n>>>>> Updating Platform Helm-charts <<<<<\n"
    cd-ihp
    git_pull_current

    echo "\n>>>>> Updating Tasks <<<<<\n"
    cd-itask
    git_pull_current

    echo "\n>>>>> Updating Docker Images <<<<<\n"
    cd-d
    git_pull_current
    
    cd ~
}

git_details (){
    R='\033[0;31m'
    G='\033[0;32m'
    O='\033[0;33m'
    Y='\033[1;33m'
    NOCOLOR='\033[0m'

    for i in `find . -maxdepth 2 -name .git -type d | sort`; do
        REPOSITORY=`echo $i|cut -d '/' -f2`
        URL=`git --git-dir=$i --work-tree $i config --get remote.origin.url`
        CURRENT_BRANCH=`git --git-dir=$i --work-tree $i branch --show-current`
        
        echo "Repo Name:$Y $REPOSITORY $NOCOLOR"
        
        if [[ $CURRENT_BRANCH != "master" ]];then
            echo "Current branch:$R $CURRENT_BRANCH $NOCOLOR"
        else
            echo "Current branch:$G $CURRENT_BRANCH $NOCOLOR"
        fi

        echo "Repo URL:$O $URL $NOCOLOR"
        echo "------------------------------"
    done
}

git_remove_merged (){ # Git_Remove_local_branchs_already_merged
    git branch --merged >/tmp/merged-branches && \
    vi /tmp/merged-branches && \
    xargs git branch -d < /tmp/merged-branches
}

# DOCKER FUNCTIONS
##################################

docker_clean_containers (){ # Docker_Clean_all_containers
    docker container stop $(docker container ls -aq)
    docker container rm $(docker container ls -aq)
}

docker_clean_images (){ # Docker_Prune_images
    docker image prune -a
}

# KUBERNETES FUNCTIONS
##################################

k8s_clean_k8s_jobs (){ # K8S_Clean_jobs_on_current_NS
    echo "deleting Error pods"
    kubectl get pods | awk 'IF $3 == "Error" { print $1}' | while read pod
    do
        echo $pod
        kubectl delete pod $pod
    done
    echo "deleting ContainerCannotRun pods"
    kubectl get pods | awk 'IF $3 == "ContainerCannotRun" { print $1}' | while read pod
    do
        echo $pod
        kubectl delete pod $pod
    done
    echo "deleting incomplete jobs older then 1h"
    kubectl get jobs | awk 'IF $2 == "0/1"  && $4 ~ /h|d/ {print $1}' | while read job
    do
        echo $job
        kubectl delete job $job
    done
    echo "deleting complete jobs older then 1d"
    kubectl get jobs | awk 'IF $2 == "1/1"  && $4 ~ /d/ {print $1}' | while read job
    do
        echo $job
        kubectl delete job $job
    done
}

k8s_get_pods_alb (){ # Kubectl get pods with readiness gates (alb ingress)
    kubectl get pods -o wide -A | awk '{if ($10 != "<none>" ) print $0}'
}

# CURL
########
curl_sc(){
    URL=$1
    curl -L --max-redirs 5 -I $URL 2>/dev/null | head -n 1 | cut -d$' ' -f2
}

# AWS
######## 

function alv-dms-start-tasks() {
if [[ $1 == '' ]] ; then
  echo "need env please"
else
  aws dms describe-replication-tasks --profile alv-$1 --no-paginate| jq -jr '.ReplicationTasks[] | .ReplicationTaskIdentifier, " ", .ReplicationTaskArn, " ", .Status,  "\n"' | while read task ; do
  task_status=$(echo $task | awk '{print $3}')
  task_arn=$(echo $task | awk '{print $2}')
  task_name=$(echo $task | awk '{print $1}')
  if [ $task_status == "stopped" ] || [ $task_status == "ready" ] || [ $task_status == "failed" ] ; then
    echo -e   "\033[0;31mStarting \033[0m$task_name has arn $task_arn with status $task_status"
    aws dms start-replication-task --replication-task-arn $task_arn --start-replication-task-type reload-target --profile alv-$1  > /dev/null 2>&1
    if [[ $2 != '' ]] ; then
      echo "waiting $2 before the starting the next task"
      sleep $2
    fi
  else
    echo -e "\033[0;32mSkipping\033[0m $task_name has arn $task_arn with status $task_status"
  fi
done
fi
}
