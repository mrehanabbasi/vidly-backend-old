pipeline {
  environment {
    registryCredential = 'DockerHub'
  }
  agent any
  stages('Build') {
    steps {
      sh "docker-compose up -d"
    }
  }
  stages('Test') {
    steps {
      sh "docker-compose run --service-ports vidly-backend npm test -- --forceExit"
      sh "docker-compose down"
    }
  }
  stages('Publish') {
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
