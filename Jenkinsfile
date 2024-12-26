pipeline {
    agent any
    tools {
        jdk "jdk"
        maven "maven"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Cloud-Gen-DevOps-Projects/Full-Stack-App.git'
            }
        }
        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Trivy FS') {
            steps {
                sh "trivy fs . --format table -o fs.html"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-scanner') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=Blogging-app -Dsonar.projectKey=Blogging-app \
                          -Dsonar.java.binaries=target'''
                }
            }
        }
        stage('Build') {
            steps {
                sh "mvn package"
            }
        }
        stage('Publish Artifacts') {
            steps {
                        sh "mvn deploy"
            }
        }
        stage('Docker Build & Tag') {
            steps {
                script{
                
                sh "docker build -t thanish/gab-blogging-app ."
                }
                }
            }
        
        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format table -o image.html thanish/gab-blogging-app:latest"
            }
        }
        stage('Docker Push Image') {
            steps {
                script{
                withDockerRegistry(credentialsId: 'docker-thanish', url: 'https://index.docker.io/v1/') {
                    sh "docker push thanish/gab-blogging-app"
                }
                }
            }
        }
    }  // Closing stages
}  // Closing pipeline
