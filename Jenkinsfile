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
    
   stage ('Build') {
      steps {
      sh 'mvn clean package'
      }
   }
	
    stage('Artifact File exist'){
        steps{
            
            echo ' checking file in workspace'
            
            fileExists '/var/lib/jenkins/workspace/webapp/target/WebApp.war'
            
            echo 'file exist'
        }
    }
	
   stage('Artifact file upload to Nexus'){
        steps{
            
            echo ' Artifact uploading start-----'
            
            nexusArtifactUploader artifacts: [[artifactId: 'WebApp', classifier: '', file: '/var/lib/jenkins/workspace/webapp/target/WebApp.war', type: 'war']], credentialsId: 'NEXUS _CRED', groupId: 'lu.amazon.aws.demo', nexusUrl: '13.235.0.159:8081/repository/maven-central-repository/', nexusVersion: 'nexus2', protocol: 'http', repository: 'maven-central-repository', version: '1.0-SNAPSHOT'
		
             echo 'Artifact uploaded'
        }
    }
}
}
     
	      
	      
	      
	      
	      
	      
	      
	      
