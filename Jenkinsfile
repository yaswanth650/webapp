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
	
   stage('Artifact file upload to S3BUCKET'){
        steps{
            
            echo ' Artifact uploading start-----'
	    
             s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 's3-artifacts6', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: false, selectedRegion: 'ap-south-1', showDirectlyInBrowser: false, sourceFile: '**/*.war', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 's3-artifacts6', userMetadata: []
          
            echo 'Artifact uploaded'
        }
    }
   stage('ANSIBLE'){
        steps{
            
           sshPublisher(publishers: [sshPublisherDesc(configName: 'ANSIBLE', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /home/ansible/prod/playbook/playbook.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//prod', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])        }
       }
}
}
}
	
	
	
	
	
	
	
	
	
	
     
	      
	      
	      
	      
	      
	      
	      
	      
