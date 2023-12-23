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
  post {
    always {
      echo 'This pipeline is completed.'
    }
  }
}
