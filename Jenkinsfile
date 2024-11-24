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
      when {
        branch 'master'
      }

      environment {
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
          waitForQualityGate abortPipeline: true
        }
      }
    }

    // Aquí se agrega el nuevo stage de Trigger deployment
    stage('Trigger deployment') {
      agent any
      environment {
        def GIT_COMMIT = "${env.GIT_COMMIT}"
      }
      steps {
        echo "${GIT_COMMIT}"
        echo "triggering deployment"
        build job: 'deployment', parameters: [string(name: 'DOCKERTAG', value: GIT_COMMIT)]
      }
    }
  }

  post {
    always {
      echo 'Building mono pipeline for voting app is completed.'
    }
  }
}
