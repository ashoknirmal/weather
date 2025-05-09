pipeline {
    agent {
        docker {
            image 'node:18'   // or any Node.js version you need
        }
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/ashoknirmal/weather.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'mkdir -p /.npm && chown -R 122:125 /.npm'
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t react-app .'
            }
        }
        stage('Docker Run') {
            steps {
                sh 'docker run -d -p 3000:3000 --name react-container react-app'
            }
        }
    }
}
