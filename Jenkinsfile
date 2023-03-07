pipeline {
    
    agent none

    stages{
        stage("build"){
            when{
                changeset "**/worker/**"
            }
            agent{
              docker{
                image 'maven:3.6.3-jdk-8'
                args '-v $HOME/.m2:/root/.m2'
                }   
            }    
            steps{
                echo "Building the app"
                dir("worker"){
                 sh 'mvn compile'
                }
            }
        }
    
        stage('test'){
            when{
                changeset "**/worker/**"
            }
            agent{
              docker{
                image 'maven:3.6.3-jdk-8'
                args '-v $HOME/.m2:/root/.m2'
                }   
            }

            steps{
                echo "Running unit tests on worker app"
                dir('worker'){
                sh 'mvn clean test'
            }
        }
    }
        stage('package'){
            when{
                branch 'master'
                changeset "worker/Dockerfile"
            }
            agent{
              docker{
                image 'maven:3.6.3-jdk-8'
                args '-v $HOME/.m2:/root/.m2'
                }   
            }
            
            steps{
                echo "packaging worker app into a jar"
                dir('worker'){
                sh 'mvn package -DskipTests'
                archiveArtifacts artifacts: '**/target/*.jar, fingerprint: true'  
            }
        }
    }
        stage('docker-package'){
            //when{
            //    changeset "worker/Dockerfile "
            //}
            agent any
            steps{
                echo "Packaging docker app"
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin'){
                        def workerImage = docker.build("zenux88/worker:v${env.BUILD_ID}", "./worker")
                        workerImage.push
                        workerImage.push("latest")
                    }
                }
            }
        }
}
    post{         
        always{      
             echo 'Pipelined finished.'
        }
    }
}