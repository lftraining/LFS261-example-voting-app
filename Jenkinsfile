pipeline {
    agent any

    stages {
        stage('one') {
            steps {
                echo 'Step 01'
                sleep 3
            }
        }
        stage('two') {
            steps {
                echo 'Step 02'
                sleep 9
            }
        }
        stage('three') {
            steps {
                echo 'Step 03'
                sleep 5
            }
        }
    }
    post{
        always {
            echo "This pipeline is completed"
        }
    }
}
    
