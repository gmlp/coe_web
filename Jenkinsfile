pipeline {
    agent { node { label 'test' } }
  // options {
  //    // Only keep the 10 most recent builds
  //    buildDiscarder(logRotator(numToKeepStr:'10'))
  // }
   stages {
      stage('Spin Up') {
         steps {
             sh 'docker-compose up -d'
         }
      }
      stage('Lint Validation') {
         steps {
             sh "echo here run linters"
         }
      }
      stage('ChefSpec') {
         steps {
             script {
                sh "docker-compose ps -q chefdk > pid" 
                def pid=readFile('pid').trim()
                sh "docker exec ${pid} chef exec rspec"
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
             }
         }
      }
   }

  // pending agregations
  //         sh 'rubocop -r cookstyle -D --format emacs --fail-level E cookbooks'
  //         sh 'foodcritic ./cookbooks/*/'
  // post {
  //    always {
  //       // Parsing log
  //       step([$class: 'WarningsPublisher', canRunOnFailed: true, consoleParsers: [[parserName: 'Foodcritic'],[parserName: 'Rubocop']]])
  //       echo "job terminated : ${currentBuild.result} "
  //    }
  // }
}
