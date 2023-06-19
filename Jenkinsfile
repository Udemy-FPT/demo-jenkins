pipeline {
  agent any
  environment {

  }

   stages {
      stage('Pre-Build') {
          steps {
            echo "Hello world"
          }
      }
      stage('Build') {
          steps {

          }
      }
      stage('Test') {
          steps {
              echo 'Testing..'
              def testContainer = docker.image("node:18-alpine")
              testContainer.pull()
              testContainer.inside {
                sh 'npm install --only=dev'
                sh 'npm test'
              }

          }
      }
      stage('Push') {
          steps {

          }
      }
      stage('Deploy') {
          steps {
          }
      }

   }

    post {
       always {
           echo 'One way or another, I have finished'
           deleteDir() /* clean up our workspace */
       }
       success {
           echo 'I succeeeded!'
       }
       unstable {
           echo 'I am unstable :/'
       }
       failure {
           echo 'I failed :('
       }
       changed {
           echo 'Things were different before...'
       }
    }
}
