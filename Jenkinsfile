pipeline {
    agent any
    stages{
        stage("one"){
            steps{
                echo "stage one"
                sleep 2
            }
        }
        stage("two"){
            steps { 
                echo "Stage two"
                sleep 3
            }
        }
        stage("Three"){
            when{
            branch 'master'
            changeset "**/worker/**"
            }
              steps{
                  echo 'step 3'
                  sleep 5
              }
        }
    }
    post{
        always{
            echo "All stage are completed"
        }
    }
}
