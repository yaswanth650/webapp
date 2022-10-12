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
	
	stage ('fod static assessment'){
		steps{
			fodStaticAssessment applicationName: '', applicationType: '', assessmentType: '', attributes: '', auditPreference: '2', bsiToken: '', businessCriticality: '', entitlementId: '', entitlementPreference: '', frequencyId: '', inProgressBuildResultType: 'FailBuild', inProgressScanActionType: 'Queue', isMicroservice: false, languageLevel: '20', microserviceName: '', openSourceScan: 'false', overrideGlobalConfig: true, personalAccessToken: 'FOD', releaseId: '191513', releaseName: '', remediationScanPreferenceType: 'RemediationScanIfAvailable', scanCentral: 'Maven', scanCentralBuildCommand: '', scanCentralBuildFile: '', scanCentralBuildToolVersion: '', scanCentralIncludeTests: '', scanCentralRequirementFile: '', scanCentralSkipBuild: '', scanCentralVirtualEnv: '', sdlcStatus: '', srcLocation: '', technologyStack: '7', tenantId: 'cg_642503112_FMA_606025728', username: 'yaswanth61998@gmail.com'
		}
	}
}
}
	
	
	
	
	
	
	
	
	
	
     
	      
	      
	      
	      
	      
	      
	      
	      
