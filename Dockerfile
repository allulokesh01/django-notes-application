pipeline{ 
  agent any
  stages{
    stage("Code"){
      steps{
        echo "Code cloned"
git url:'https://github.com/allulokesh01/Django-Notes-Application.git',
        branch:'main'
      }
    }
    stage('ls -ltra'){
       steps{
         sh 'ls -ltra'
            }
        }
    stage("Build"){
      steps{
        sh "docker build -t  django-notes-app ."
      }
    }
    stage("Pushing to Docker Hub"){
      steps{
        withCredentials ([usernamePassword( credentialsId:"allulokesh",passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
        sh "docker tag notes-app ${env.DOCKER_USERNAME}/django-notes­ application:latest"
        sh "docker login -u ${env.DOCKER_USERNAME}-p${env.DOCKER_PASSWORD} "
        sh "docker push ${env.DOCKER_USERNAME}/django-notes:latest"
        }
      }
    }
    stage("Deploy"){ 
      steps{
        echo "deploy"
        sh "docker-compose down && docker-compose up "
       }
     }
   }
 }
