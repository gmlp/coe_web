pipeline {
   agent { node { label 'test' } }

   stages {
      stage('Spin Up') {
         steps {
             sh 'docker-compose up -d'
         }
      }
      stage('Lint Validation') {
         steps {
             script {
                sh "docker-compose ps -q chefdk > pid" 
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} rubocop -r cookstyle -D --format emacs ."
                sh "docker exec ${pid} foodcritic ."
             }
         }
      }
      stage('ChefSpec') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} chef exec rspec --color -fd"
             }
         }
      }
      stage('Kitchen Create') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen create"
             }
         }
      }
      stage('Kitchen Converge') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen converge"
             }
         }
      }
      stage('Kitchen Setup') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen setup"
             }
         }
      }
      stage('Kitchen Exec Test') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen verify"
             }
         }
      }
      stage('Kitchen clean up') {
         steps {
             script {
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} kitchen destroy"
                sh "docker-compose down"
             }
         }
      }
   }
}
