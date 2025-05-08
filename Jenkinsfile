pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/ashoknirmal/weather.git'
            }
        }
        stage('Install Dependencies') {
            steps {
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
