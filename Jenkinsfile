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
             sh "docker-compose exec chefdk chef exec rspec"
         }
      }
      stage('Kitchen Create') {
         steps {
             sh "docker-compose exec chefdk kitchen create"
         }
      }
      stage('Kitchen Converge') {
         steps {
             sh "docker-compose exec chefdk kitchen converge"
         }
      }
      stage('Kitchen Setup') {
         steps {
             sh "docker-compose exec chefdk kitchen setup"
         }
      }
      stage('Kitchen Exec Test') {
         steps {
             sh "docker-compose exec chefdk kitchen verify"
         }
      }
      stage('Kitchen clean up') {
         steps {
             sh "docker-compose exec chefdk kitchen destroy"
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
