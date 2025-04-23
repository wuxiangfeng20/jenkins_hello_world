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
                script {
                    try {
                        sh 'rm -rf ${WORKSPACE_DIR}'
                        sh 'mkdir -p ${WORKSPACE_DIR}'
                        dir("${WORKSPACE_DIR}") {
                            git branch: 'main',
                                credentialsId: 'wxfgithub',
                                url: 'https://github.com/wuxiangfeng20/jenkins_hello_world.git'
                        }
                    } catch (Exception e) {
                        echo "Git clone failed: ${e.getMessage()}"
                        error "Failed to clone repository"
                    }
                }
            }
        }
        
        stage('Docker Build and Test') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    script {
                        // 构建 Docker 镜像
                        sh 'docker build -t hello_world_jenkins .'
                        
                        // 运行 Docker 容器进行测试
                        sh 'docker run --rm hello_world_jenkins'
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
            sh 'docker rmi hello_world_jenkins || true' // 清理镜像，忽略错误
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed, check logs for details.'
        }
    }
}