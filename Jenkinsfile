pipeline {
  environment {
    registryCredential = 'DockerHub'
  }
  agent any
  stage('Build') {
    steps {
      sh "docker-compose up -d"
    }
  }
  stage('Test') {
    steps {
      sh "docker-compose run --service-ports vidly-backend npm test -- --forceExit"
      sh "docker-compose down"
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
