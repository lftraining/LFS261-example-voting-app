pipeline {
    agent any

    stages {
        stage('Stage 1') {
            steps {
                echo 'step 1'
                sleep 3
            }
        }
        stage('Stage 2') {
            steps {
                echo 'step 2'
                sleep 9
            }
        }
        stage('Stage 3') {
            steps {
                echo 'step 3'
                sleep 5
            }
        }
    }
    post {
        always {
            echo "this pipeline is completed"
        }
    }
}
