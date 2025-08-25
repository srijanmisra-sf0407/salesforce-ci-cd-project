// Jenkinsfile for a single Dev Org
pipeline {
    agent any

    // Define environment variables for the Dev Org
    environment {
        DEV_CONSUMER_KEY = credentials('DEV_CONSUMER_KEY')
        DEV_USERNAME     = credentials('DEV_USERNAME')
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                echo 'Checking out the source code...'
                checkout scm
            }
        }

        stage('Validate Code Against Dev Org') {
            steps {
                // Use the 'withCredentials' wrapper to securely access the private key file
                withCredentials([file(credentialsId: 'sfdx-server-key', variable: 'SFDX_SERVER_KEY_FILE')]) {
                    script {
                        echo "Authenticating to the Dev org..."
                        // Authenticate to the Dev Org using JWT
                        sh "sfdx auth:jwt:grant --clientid ${env.DEV_CONSUMER_KEY} --jwtkeyfile ${SFDX_SERVER_KEY_FILE} --username ${env.DEV_USERNAME} --alias DevOrg --set-default"

                        echo "Validating deployment and running specified tests..."
                        // Perform a validation deployment (--checkonly) against the Dev Org
                        // This checks if the code is deployable and if the tests pass
                        sh "sfdx force:source:deploy --sourcepath force-app --checkonly --testlevel RunSpecifiedTests --tests MyAwesomeClassTest"
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
            cleanWs()
        }
    }
}