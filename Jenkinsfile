pipeline {
    agent none

    stages {
        // Stages del pipeline de worker
        stage("Build Worker App") {
            when {
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.9.8-sapmachine-21'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                echo 'Compiling worker app...'
                dir('worker') {
                    sh 'mvn compile'
                }
            }
        }

        stage("Test Worker App") {
            when {
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.9.8-sapmachine-21'
                    args '-v $HOME/.m2:/root/.m2'
                }
            }
            steps {
                echo 'Running Unit Tests on worker app...'
                dir('worker') {
                    sh 'mvn clean test'
                }
            }
        }

        stage("Package Worker App") {
            when {
                branch 'master'
                changeset "**/worker/**"
            }
            agent {
                docker {
                    image 'maven:3.9.8-sapmachine-21'
                    args '-v $HOME/.m2:/root/.m2'
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

        stage("Docker Package Worker App") {
            when {
                changeset "**/worker/**"
                branch 'master'
            }
            agent any
            steps {
                echo 'Packaging worker app with docker...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                        def workerImage = docker.build("nachodev666/worker:v${env.BUILD_ID}", "./worker")
                        workerImage.push()
                        workerImage.push("${env.BRANCH_NAME}")
                        workerImage.push("latest")
                    }
                }
            }
        }

        // Stages del pipeline de vote
        stage("Build Vote App") {
            agent {
                docker {
                    image 'python:3.11-slim'
                    args '--user root'
                }
            }
            steps {
                echo 'Compiling vote app...'
                dir('vote') {
                    sh "pip install -r requirements.txt"
                }
            }
        }

        stage("Test Vote App") {
            agent {
                docker {
                    image 'python:3.11-slim'
                    args '--user root'
                }
            }
            steps {
                echo 'Running Unit Tests on vote app...'
                dir('vote') {
                    sh "pip install -r requirements.txt"
                    sh 'nosetests -v'
                }
            }
        }

        stage("Docker Package Vote App") {
            agent any
            steps {
                echo 'Packaging vote app with docker...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
                        def voteImage = docker.build("nachodev666/vote:v${env.BUILD_ID}", "./vote")
                        voteImage.push()
                        voteImage.push("${env.BRANCH_NAME}")
                        voteImage.push("latest")
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline for worker and vote apps is complete.'
        }
    }
}
