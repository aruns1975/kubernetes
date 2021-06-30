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
                input(
 id: 'userInput', message: 'Please Provide Docker hub credentials', parameters: [
 [$class: 'TextParameterDefinition', defaultValue: '', description: 'Docker User Name', name: 'dockerUserName'],
 [$class: 'PasswordParameterDefinition', defaultValue: '', description: 'Docker Password', name: 'dockerPassword']
])
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
