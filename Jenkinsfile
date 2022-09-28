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
	
	stage('server'){
		steps{
		  rtserver(
			  id: "Artifactory",
			  url: 'http://13.233.237.249:8081/artifactory',
			  username: 'admin',
			  password: 'RAVURI6@',
			  bypassproxy: true,
			  timeout:300
			  )
		}
	}
	
	stage('upload'){
		steps{
		  rtupload(
			  serverId: "Artifactory",
			  spec: '''{
			  "files":[
			  {
			  "pattern": "*.war",
			  "target": "libs-snapshot-local"
			  }
			        ]
			      }'''
			  )
		}
	}
	stage('publish build info'){
		steps{
		   rtPublishBuildInfo(
		      serverId: "Artifactory" 
			   )
		}
	}
}
}
	
	
	
	
	
	
	
	
	
	
}
}
     
	      
	      
	      
	      
	      
	      
	      
	      
