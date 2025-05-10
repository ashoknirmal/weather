pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ashok3182004/react-weather-app'
        NPM_CONFIG_CACHE = "${WORKSPACE}/.npm"
        NVM_DIR = "$HOME/.nvm"
        PATH = "$NVM_DIR/versions/node/v22.15.0/bin:$PATH"
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/ashoknirmal/weather.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                    nvm install 22.15.0
                    nvm use 22.15.0
                    node -v
                    npm -v
                    npm install
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                    nvm use 22.15.0
                    npm run build
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Docker Login & Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Docker Run') {
            steps {
                sh 'docker rm -f react-weather || true'
                sh 'docker run -d -p 80:80 --name react-weather $DOCKER_IMAGE'
            }
        }
    }
}
