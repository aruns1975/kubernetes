pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                
            }
        }
        stage('Proceed') {
            steps {
                input message: 'User input required'
            }
        }
        stage('Input Credentials') {
            steps {
                script{
                    env.credentials = input(
                         id: 'userInput', message: 'Please Provide Docker hub credentials', parameters: [
                             [$class: 'TextParameterDefinition', defaultValue: '', description: 'Docker User Name', name: 'dockerUserName'],
                             [$class: 'PasswordParameterDefinition', defaultValue: '', description: 'Docker Password', name: 'dockerPassword']
                        ]
                    )
                echo 'The user name is ${env.credentials.dockerUserName} and the password is ${env.credentials.dockerPassword}'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
