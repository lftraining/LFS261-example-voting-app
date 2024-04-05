pipeline{
    agent any
    
    stages{
        stage("One"){
            steps{
                echo 'step 1'
                sleep 3
            }
        }
        stage("Two"){
            steps{
                echo 'step 2'
                sleep 6
            }
        }
        stage("Three"){
            steps{
                echo 'step 3'
                sleep 5
            }
        }
    }
    post{
        always{
            echo 'This pipeline is completed'
        }
    }
}
