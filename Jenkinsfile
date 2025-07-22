pipeline {
    agent none

    stages {
        stage("worker_build") {
            when {
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.8.6-openjdk-11-slim'
                    args "-v /var/jenkins_home/.m2:/root/.m2"
                }
            }
            steps {
                echo 'Compiling worker app...'
                dir('worker') {
                    sh 'mvn compile'
                }
            }
        }

		
		stage('result_build'){
				when{
					changeset "**/result/**"
				}
				agent{
					docker{
						image 'node:24.4.0-alpine3.22'
					}
				}
				steps{
					echo 'Compiling result app..'
					dir('result'){
						sh 'npm install'
					}
				}
		}

		stage('vote_build'){ 
            agent{
                docker{
                    image 'python:3.11-slim'
                    args '--user root'
                    }
                    }

            steps{ 
                echo 'Compiling vote app.' 
                dir('vote'){
            
                        sh "pip install -r requirements.txt"

                } 
            } 
        }

        stage("worker_test") {
            when {
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.8.6-openjdk-11-slim'
                    args "-v /var/jenkins_home/.m2:/root/.m2"
                }
            }
            steps {
                echo 'Running Unit Tests on worker app...'
                dir('worker') {
                    sh 'mvn clean test'
                }
            }
        }
		
		stage('result_test'){
			when {
				changeset "**/result/**"
			}
			agent{
				docker{
                    image 'node:24.4.0-alpine3.22'
                }
            }
			steps{
				echo 'Running Unit Tests n result app..'
				dir('result'){
					sh 'npm install'
					sh 'npm test'
				}
			}
		}

		stage('vote_test'){ 
           
            agent {
                docker{
                    image 'python:3.11-slim'
                    args '--user root'
                    }
                }
            steps{ 
                echo 'Running Unit Tests on vote app.' 
                dir('vote'){ 
                   
                        sh "pip install -r requirements.txt"
                        sh 'pytest'
                        
                        
                } 
            } 
        }

        stage("worker_package") {
            when {
                branch 'master'
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.8.6-openjdk-11-slim'
                    args "-v /var/jenkins_home/.m2:/root/.m2"
                }
            }
            steps {
                echo 'Packaging worker app...'
                dir('worker') {
                    sh 'mvn package -DskipTests'
                    archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
                }
            }
        }
		
		stage('result_docker_package'){
            agent any

            steps{
                echo 'Packaging result app with docker'
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                    // ./result is the path to the Dockerfile that Jenkins will find from the Github repo
                    def resultImage = docker.build("emmiduh93/result:v${env.BUILD_ID}", "./result")
                    resultImage.push()
                    resultImage.push("${env.BRANCH_NAME}")
                    resultImage.push("latest")
                    }
                }
			}
		}

        stage('vote_docker_package'){
            agent any
           
            steps{
                echo 'Packaging vote app with docker'
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                    // ./vote is the path to the Dockerfile that Jenkins will find from the Github repo
                    def voteImage = docker.build("emmiduh93/vote:v${env.BUILD_ID}", "./vote")
                    voteImage.push()
                    voteImage.push("${env.BRANCH_NAME}")
                    voteImage.push("latest")
                    }
                }
            }
        }

		stage("worker_docker_package") {
            when {
                branch 'master'
                changeset "**/worker/**"
            }
            agent any
            steps {
                echo 'Packaging worker app with Docker...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                        def workerImage = docker.build("emmiduh93/worker:v${env.BUILD_ID}", "./worker")
                        workerImage.push()
                        workerImage.push("${env.BRANCH_NAME}")
                        workerImage.push("latest")
                    }
                }
            }
        }
		
		stage('Deploy to dev'){
			agent any
			when {
				branch 'master'
			}
			steps{
				echo 'Deploy instavote app with docker compose'
				sh 'docker compose up -d'
			}
		}
    }

    post {
        always {
            echo 'Building multibranch pipeline for worker is completed...'
        }
        failure {
            slackSend(
                channel: "instavote-cd",
                message: "❌ Build Failed - ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
            )
        }
        success {
            slackSend(
                channel: "instavote-cd",
                message: "✅ Build Succeeded - ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"
            )
        }
    }
}

