pipeline {

  environment {
    dockerimagename = "mynaniag/python-app"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        sh 'sed -i \"s/<TAG>/${BUILD_NUMBER}/\" application/demo/views.py'
        git branch: 'main',
            url: 'https://github.com/Mynaniag/final_project.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhublogin'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("${BUILT_NUMBER}")
            dockerImage.push("latest") 
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" Deployment.yaml'
          kubernetesDeploy(configs: "Deployment.yaml", kubeconfigId: "kubernetes")
        }
      }
    }
  }
}
