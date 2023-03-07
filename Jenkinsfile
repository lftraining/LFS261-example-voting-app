pipeline {
    agent none
    stages{

        stage("build"){
            when{
                branch 'master'
                changeset "**/worker/**"
            }
            agent{
                docker{
                    image 'maven:3.6.1-jdk-8-slim'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                echo 'Compiling worker app..'
                    dir('worker'){
                        sh 'mvn compile'
                    }
                }
            }

        stage("test"){
            when{
                branch 'master'
                changeset "**/worker/**"
            }
            agent{
                docker{
                    image 'maven:3.6.1-jdk-8-slim'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps{
                echo 'Running Unit Tests on worker app..'
                dir('worker'){
                    sh 'mvn clean test'
                }
            }
        }

        stage("package"){
            when{
                branch 'master'
                changeset "**/worker/**"
            }
            agent{
                docker{
                        image 'maven:3.6.1-jdk-8-slim'
                        args '-v $HOME/.m2:/root/.m2'
                    }
                }
            steps{ 
                echo 'Packaging worker app'
                dir('worker'){
                    sh 'mvn package -DskipTests'
                    archiveArtifacts artifacts: '**/target/*.jar',fingerprint: true
                }
            }
        }

        stage('docker-package'){
        agent any
        when{
            changeset "**/worker/**"
        }

            steps{
                echo 'Packaging worker app with docker'
            script{
                docker.withRegistry('https://index.docker.io/v1/','dockerlogin') {
                    def workerImage =
                    docker.build("zenux88/worker:v${env.BUILD_ID}", "./worker")
                    workerImage.push()
                    workerImage.push("${env.BUILD_ID}")
                    workerImage.push("latest")
                    }      
                }
            }
        }
    }
    post{
        always{
            echo 'Building multibranch pipeline for worker is completed..'
        }
    }
}
