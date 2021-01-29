pipeline {
  environment {
    registryCredential = 'DockerHub'
  }
  agent any
  stages {
    stage('Build') {
      steps {
        sh "sudo docker-compose up -d"
      }
    }
    stage('Test') {
      steps {
        sh "sudo docker-compose run --service-ports vidly-backend npm test -- --forceExit"
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
        sh "sudo docker-compose down --rmi all" || true
  }
}
