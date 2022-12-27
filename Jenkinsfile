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
            steps {
                echo "Stage three"
                sleep 4
            }
        }
    }
    post{
        always{
            echo "All stage are completed"
        }
    }
}
