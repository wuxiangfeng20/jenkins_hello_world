pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                sh 'make'
            }
        }
        
        stage('Test') {
            steps {
                sh 'make test'
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t hello-world-c .'
            }
        }
        
        stage('Docker Test') {
            steps {
                sh 'docker run hello-world-c'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
} 