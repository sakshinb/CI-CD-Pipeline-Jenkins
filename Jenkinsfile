pipeline {
    agent any

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '''
                    python3 -m venv .venv
                    .venv/bin/pip install -r app/requirements.txt
                    .venv/bin/pip install pytest
                    docker build -t jenkins-terraform-demo:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    .venv/bin/python -m pytest -v tests/
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker rm -f jenkins-terraform-demo || true

                    docker run -d \
                      --name jenkins-terraform-demo \
                      --restart unless-stopped \
                      -p 5000:5000 \
                      jenkins-terraform-demo:${BUILD_NUMBER}
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    for i in $(seq 1 15); do
                      if curl -fsS http://localhost:5000/health; then
                        exit 0
                      fi
                      sleep 2
                    done

                    echo "Application health check failed"
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'CI/CD pipeline completed successfully!'
        }

        failure {
            echo 'CI/CD pipeline failed. Check the console output.'
        }
    }
}