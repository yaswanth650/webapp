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
    
     stage ('Check-Git-Secrets') {
      steps {
        sh 'rm trufflehog || true'
        sh 'docker run gesellix/trufflehog --json https://github.com/yaswanth650/webapp.git > trufflehog'
        sh 'cat trufflehog'
      }
    }
	  
     stage ('Source Composition Analysis') {
       steps {
          sh 'rm owasp* || true'
          sh 'wget "https://raw.githubusercontent.com/yaswanth650/webapp/master/owasp-dependency-check.sh" '
          sh 'chmod +x owasp-dependency-check.sh'
          sh 'bash owasp-dependency-check.sh'
          sh 'cat /var/lib/jenkins/OWASP-Dependency-Check/reports/dependency-check-report.xml'
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
                sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@15.206.128.115:/prod/apache-tomcat-9.0.65/webapps/webapp.war'
              }      
           }
     }
   
    stage ('Port Scan') {
		    steps {
		       	sh 'rm nmap* || true'
		       	sh 'docker run --rm -v "$(pwd)":/data uzyexe/nmap -sS -sV -oX nmap 15.206.128.115'
			       sh 'cat nmap'
		    }
	        }
	
     stage ('DAST') {
       steps {
          sshagent(['zap']) {
            sh 'ssh -o  StrictHostKeyChecking=no ubuntu@65.0.182.130 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://15.206.128.115:8080/webapp/" || true'
        }
      }
    }
	  
      stage ('Nikto Scan') {
		    steps {
			sh 'rm nikto-output.xml || true'
			sh 'docker run --user $(id -u):$(id -g) --rm -v $(pwd):/report -i secfigo/nikto:latest -h 15.206.128.115 -p 8080 -output /report/nikto-output.xml'
			sh 'cat nikto-output.xml'   
		    }
	    }
	  
	  stage ('SSL Checks') {
		    steps {
			sh 'docker pull nablac0d3/sslyze'
			sh 'docker run --rm  nablac0d3/sslyze  --regular 15.206.128.115:8080 '
			sh 'cat sslyze'
		    }
	      }
  }
}
	    

