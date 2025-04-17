pipeline {
    agent {
        node {
            label 'ubuntu'
        }
    }

    environment {
        WORKSPACE_DIR = '/home/test/jenkins_hello_world_test'
    }

    stages {
        stage('Checkout') {
            steps {
                // 清理工作目录
                sh 'rm -rf ${WORKSPACE_DIR}'
                sh 'mkdir -p ${WORKSPACE_DIR}'
                dir("${WORKSPACE_DIR}") {
                    git branch: 'main',
                        credentialsId: 'wxfgithub',
                        url: 'https://github.com/wuxiangfeng20/jenkins_hello_world.git'
                }
            }
        }
        
        stage('Build') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'make'
                }
            }
        }
        
        stage('Test') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'make test'
                }
            }
        }
        
        stage('Docker Build') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'docker build -t hello_world_jenkins .'
                }
            }
        }
        
        stage('Docker Test') {
            steps {
                sh 'docker run hello_world_jenkins'
            }
        }
    }
    
    post {
        always {
            // 清理工作空间
            cleanWs()
            // 可选：清理 Docker 镜像
            // sh 'docker rmi hello_world_jenkins || true'
        }
    }
} 