pipeline {
  environment {
    registryCredential = 'DockerHub'
  }
  agent any
  stages {
    stage('Build') {
      steps {
        sh "docker-compose up -d"
      }
    }
    stage('Test') {
      steps {
        sh "docker-compose run --service-ports vidly-backend npm test -- --forceExit"
      }
    }
    stage('Publish') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            sh "docker tag ${DOCKERHUB_USERNAME}/vidly-backend:${BUILD_NUMBER} ${DOCKERHUB_USERNAME}/vidly-backend:latest"
            sh "docker push ${DOCKERHUB_USERNAME}/vidly-backend:latest"
            sh "docker push ${DOCKERHUB_USERNAME}/vidly-backend:${BUILD_NUMBER}"
          }
        }
      }
    }
  }
  post {
    cleanup {
      sh "docker-compose down --rmi all"
    }
  }
}
