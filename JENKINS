pipeline{
 agent any
  tools{
    maven 'Maven'
  }
  
  environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "3.110.105.140:8081"
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
     
      stage ('Build') {
      steps {
      sh 'mvn clean package'
       }
    }
    
    stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion:NEXUS_VERSION,
                            protocol:NEXUS_PROTOCOL,
                            nexusUrl:NEXUS_URL,
                            groupId:pom.groupId,
                            version:pom.version,
                            repository:NEXUS_REPOSITORY,
                            credentialsId:NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId:pom.artifactId,
                                classifier: '',
                                file:artifactPath,
                                type:pom.packaging],
                                [artifactId:pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
    }
    }
