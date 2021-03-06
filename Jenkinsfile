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
            sh "docker tag ${DOCKERHUB_USERNAME}/vidly-backend:${BUILD_NUMBER} ${DOCKERHUB_USERNAME}/${JOB_NAME}:latest"
            sh "docker tag ${DOCKERHUB_USERNAME}/vidly-backend:${BUILD_NUMBER} ${DOCKERHUB_USERNAME}/${JOB_NAME}:${BUILD_NUMBER}"
            sh "docker push ${DOCKERHUB_USERNAME}/${JOB_NAME}:latest"
            sh "docker push ${DOCKERHUB_USERNAME}/${JOB_NAME}:${BUILD_NUMBER}"
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
