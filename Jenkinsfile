pipeline {
  agent any

  tools {
    maven 'maven'
  }

  stages {
      stage('build') {
        when {
          changeset '**/worker/**'
        }
          steps {
        echo 'Starting to Build'

        dir('worker') {
          sh  'mvn compile'
        }
          }
      }
    stage('test') {
        when {
          changeset '**/worker/**'
        }
          steps {
        echo 'Starting to test'
        dir('worker') {
          sh  'mvn clean test'
        }
          }
    }
      stage('package') {
          when {
            branch 'master'
            changeset '**/worker/**'
          }
          steps {
            echo 'Starting to Build'
            dir('worker') {
              sh  'mvn package -DskipTests'
            }
          }
          post {
            success {
              archiveArtifacts(artifacts: '**/target/*.jar', fingerprint: true)
            }
          }
      }
  }
  post {
    failure {
      slackSend(channel: '#ci-cd', message: "Build Failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}")
    }
    success {
      slackSend(channel: '#ci-cd', message: "Build Success: ${env.JOB_NAME} ${env.BUILD_NUMBER}")
    }
    always {
      echo 'This pipeline is completed.'
    }
  }
}
