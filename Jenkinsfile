pipeline{
 agent any
  tools{
    maven 'Maven'
  }
  
  stages{
    stage('Initialize'){
      steps{
        sh '''
              
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
            '''
      }
    }
    
     stage ('Check-Git-Secrets'){
      steps{
        sh 'rm trufflehog || true'
        sh 'docker run gesellix/trufflehog --json https://github.com/yaswanth650/webapp.git > trufflehog'
        sh 'cat trufflehog'
      }
    }
	  
	 stage('JS vulnerability check') {
            agent(['docker']) {
                docker 'gruebel/retirejs:latest'
                args '--entrypoint ""'
            }
            steps {
                sh 'retire'
            }
        }
	  
     
     stage ('SAST') {
      steps {
        withSonarQubeEnv('sonarqube') {
          sh 'mvn sonar:sonar'
          sh 'cat target/sonar/report-task.txt'
        }
      }
    }
    
     stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    
     stage ('Deploy-To-Tomcat') {
            steps {
           sshagent(['tomcat']) {
                sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@13.127.91.50:/prod/apache-tomcat-9.0.65/webapps/webapp.war'
              }      
           }
        }
   
    stage ('Port Scan') {
		    steps {
		       	sh 'rm nmap* || true'
		       	sh 'docker run --rm -v "$(pwd)":/data uzyexe/nmap -sS -sV -oX nmap 13.127.91.50'
			       sh 'cat nmap'
		    }
	        }
	
     stage ('DAST') {
       steps {
          sshagent(['zap']) {
            sh 'ssh -o  StrictHostKeyChecking=no ubuntu@13.127.226.234 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://13.127.91.50:8080/webapp/" || true'
        }
      }
    }
	  
      stage ('Nikto Scan') {
		    steps {
			sh 'rm nikto-output.xml || true'
			sh 'docker run --user $(id -u):$(id -g) --rm -v $(pwd):/report -i secfigo/nikto:latest -h 13.127.91.50 -p 8080 -output /report/nikto-output.xml'
			sh 'cat nikto-output.xml'   
		    }
	    }
	
	stage ('SSL Checks') {
		    steps {
		        sh 'docker run --rm -i nablac0d3/sslyze:5.0.0  13.127.91.50:8443 --json_out results.json || true'
		    }
	       }
        }
  }
	    

