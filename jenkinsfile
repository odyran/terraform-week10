pipeline {
    agent any

    stages {
        stage('initialize') {
            steps {
                sh 'terraform init'
            }
        }
        stage('test') {
            steps {
                echo 'Hello test'
            }
        }
         stage('package') {
            steps {
                echo 'Hello package'
            }
        }
    }
}
