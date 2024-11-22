pipeline {
  agent none

  stages {
    stage('worker-docker-package') {
      agent any
      when {
        changeset '**/worker/**'
        branch 'master'
      }
      steps {
        echo 'Packaging worker app with docker'
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
            def sanitizedBranchName = env.BRANCH_NAME.replaceAll('/', '-')
            def workerImage = docker.build("nachodev666/worker:v${env.BUILD_ID}", './worker')
            workerImage.push()
            workerImage.push(sanitizedBranchName)
            workerImage.push('latest')
          }
        }
      }
    }

    stage('result-docker-package') {
      agent any
      when {
        changeset '**/result/**'
        branch 'master'
      }
      steps {
        echo 'Packaging result app with docker'
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
            def sanitizedBranchName = env.BRANCH_NAME.replaceAll('/', '-')
            def resultImage = docker.build("nachodev666/result:v${env.BUILD_ID}", './result')
            resultImage.push()
            resultImage.push(sanitizedBranchName)
            resultImage.push('latest')
          }
        }
      }
    }

    stage('vote-docker-package') {
      agent any
      steps {
        echo 'Packaging vote app with docker'
        script {
          docker.withRegistry('https://index.docker.io/v1/', 'dockerlogin') {
            def sanitizedBranchName = env.BRANCH_NAME.replaceAll('/', '-')
            def voteImage = docker.build("nachodev666/vote:${env.GIT_COMMIT}", './vote')
            voteImage.push()
            voteImage.push(sanitizedBranchName)
            voteImage.push('latest')
          }
        }
      }
    }

    stage('Sonarqube') {
      agent any
      when{
        branch 'master'
      }
      // tools {
       // jdk "JDK11" // the name you have given the JDK installation in Global Tool Configuration
     // }

      environment{
        sonarpath = tool 'SonarScanner'
      }

      steps {
            echo 'Running Sonarqube Analysis..'
            withSonarQubeEnv('sonar-instavote') {
              sh "${sonarpath}/bin/sonar-scanner -Dproject.settings=sonar-project.properties -Dorg.jenkinsci.plugins.durabletask.BourneShellScript.HEARTBEAT_CHECK_INTERVAL=86400"
            }
      }
    }


    stage("Quality Gate") {
        steps {
            timeout(time: 1, unit: 'HOURS') {
                // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                // true = set pipeline to UNSTABLE, false = don't
                waitForQualityGate abortPipeline: true
            }
        }
    }
  }

  post {
    always {
      echo 'Building mono pipeline for voting app is completed.'
    }
  }
}
