pipeline {
    
    agent{
        docker{
            image 'maven:3.6.3-jdk-8'
            args '-v $HOME/.m2:/root/.m2'
        }
    }         

    stages{
        stage("build"){
            steps{
                echo "Building the app"
                dir("worker"){
                 sh 'mvn compile'
                }
            }
        }
    
        stage('test'){
            steps{
                echo "Running unit tests on worker app"
                dir('worker'){
                sh 'mvn clean test'
            }
        }
    }
        stage('package'){
            steps{
                echo "packaging worker app into a jar"
                dir('worker'){
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: '**/target/*.jar, fingerprint: true'  
            }
        }
    }
}

    post{         
        always{      
             echo 'This pipeline is completed.'
        }
    }
}