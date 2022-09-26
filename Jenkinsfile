pipeline{
 agent any
  tools{
    maven 'Maven'
  }
	
    environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "65.1.1.242:8081"
        NEXUS_REPOSITORY = "maven-central-repository"
        NEXUS_CREDENTIAL_ID = "NEXUS_CRED"
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
	  
     stage ('Source Composition Analysis') {
       steps {
         sh 'rm owasp* || true'
         sh 'wget "https://raw.githubusercontent.com/yaswanth650/webapp/master/owasp-dependency-check.sh" '
         sh 'chmod +x owasp-dependency-check.sh'
         sh 'bash owasp-dependency-check.sh'
         sh 'cat /var/lib/jenkins/OWASP-Dependency-Check/reports/dependency-check-report.xml'
        
      }
    } 

    stage('snyk') {
      steps {
        echo 'Testing...'
        snykSecurity(
          snykInstallation: 'snyk',
          snykTokenId: 'snyk-api',
          failOnIssues:'false'
          )
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
	  
   stage("Publish to Nexus Repository Manager") {
            steps {
               nexusArtifactUploader artifacts: [
		       [
			       artifactId: 'WebApp', 
			       classifier: '', 
			       file: 'target/webapp-1.0 war', 
			       type: 'war'
		       ]
	       ], 
		       credentialsId: 'NEXUS _CRED',
		       groupId: 'lu.amazon.aws.demo',
		       nexusUrl: '65.0.184.198:8081', 
		       nexusVersion: 'nexus3', 
		       protocol: 'http', 
		       repository: 'maven-central-repository', 
		       version: '1.0'
	    }
   }
   
    stage ('Deploy-To-Tomcat') {
            steps {
               sshagent(['tomcat']) {
                sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@13.233.212.217:/prod/apache-tomcat-9.0.65/webapps/webapp.war'
              }      
           }
        }
   
    stage ('Port Scan') {
		    steps {
		       	sh 'rm nmap* || true'
		       	sh 'docker run --rm -v "$(pwd)":/data uzyexe/nmap -sS -sV -oX nmap 13.233.212.217'
			       sh 'cat nmap'
		    }
	        }
	
     stage ('DAST') {
       steps {
          sshagent(['zap']) {
            sh 'ssh -o  StrictHostKeyChecking=no ubuntu@15.206.72.217 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://13.233.212.217:8080/webapp/" || true'
        }
      }
    }
	  
     stage('Probely') {
            steps {
                probelyScan targetId: '2owcXbqFUMUh', credentialsId: 'probely', waitForScan: true, stopIfFailed: true, failThreshold: 'high'
            }
         }
	  
	  stage ('Nikto Scan') {
		    steps {
			sh 'rm nikto-output.xml || true'
			sh 'docker run --user $(id -u):$(id -g) --rm -v $(pwd):/report -i secfigo/nikto:latest -h 13.233.212.217 -p 8080 -output /report/nikto-output.xml'
			sh 'cat nikto-output.xml'   
		    }
	    }
	
	stage ('SSL Checks') {
		    steps {
		        sh 'docker run --rm -i nablac0d3/sslyze:5.0.0  13.233.212.217:8443 --json_out results.json || true'
		    }
	       }
        }
  }
	    

