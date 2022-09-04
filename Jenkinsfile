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
    
     stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    
     stage ('Deploy-To-Tomcat') {
            steps {
           sshagent(['tomcat']) {
                sh 'scp -o StrictHostKeyChecking=no target/*.war ubuntu@13.233.153.33:/prod/apache-tomcat-9.0.65/webapps/webapp.war'
              }      
           }
     }
   
    stage ('Port Scan') {
		    steps {
		       	sh 'rm nmap* || true'
		       	sh 'docker run --rm -v "$(pwd)":/data uzyexe/nmap -sS -sV -oX nmap 54.86.226.84'
			       sh 'cat nmap'
		    }
	    }
  }
}
