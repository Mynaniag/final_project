pipeline {

  environment {
    dockerimagename = "mynaniag/python-app"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        sh 'sed -i -e "s/{{BUILD_NUMBER}}/${BUILD_NUMBER:=1}/g" application/demo/views.py'
        git branch: 'main',
            url: 'https://github.com/Mynaniag/final_project.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename + ":$BUILD_NUMBER" 
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
            dockerImage.push("$BUILD_NUMBER") 
            dockerImage.push("latest") 
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps {
        script {
          sh 'sed -i "s/<TAG>/${BUILD_NUMBER}/" Deployment.yaml'
          sh 'sed "s/{{BUILD_NUMBER}}/${BUILD_NUMBER:=1}/g" Deployment.yaml' 
          kubernetesDeploy(configs: "Deployment.yaml", kubeconfigId: "kubernetes")
        }
      }
    }
  }
}
