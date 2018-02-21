pipeline {
    agent { 
        docker { 
            image 'softtekcoe/chefdk-docker'
            args '--net=host' 
        }
    }
    stages {
		stage('Linting and unit testing') {
			parallel {
				stage('Rubocop') {
					steps {
                        sh "rubocop -r cookstyle -D --format emacs --fail-level E cookbooks"
					}
				}
				stage('Foodcritic') {
					steps {
						sh "foodcritic ./cookbooks/*/"
					}
				}
				stage('ChefSpec') {
					steps {
						sh "chef exec rspec --color -fd cookbooks/**/spec/unit/recipes/*.rb"
					}
				}
			}
		}
        stage('Kitchen Create') {
            steps {
                sh "kitchen create"
            }
        }
        stage('Kitchen Converge') {
            steps {
                sh "kitchen converge"
            }
        }
        stage('Kitchen Setup') {
            steps {
                sh "kitchen setup"
            }
        }
        stage('Kitchen Exec Test') {
            steps {
                sh "kitchen verify"
            }
        }
        stage('Kitchen clean up') {
            steps {
                sh "kitchen destroy"
            }
        }
    }
    post {
        always {
            warnings canRunOnFailed: true, consoleParsers: [[parserName: 'Foodcritic'],[parserName: 'Rubocop']]
            echo "job terminated : ${currentBuild.result}"
        }
    }
}
