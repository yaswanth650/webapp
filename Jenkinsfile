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

   stage('ANSIBLE deploy to tomcat over SSH'){
        steps{
            sshPublisher(publishers: [sshPublisherDesc(configName: 'ANSIBLE', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'ansible-playbook /home/ansible/prod/playbook/playbook.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//prod', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
          }
       }

    stage('JENKINS DEPLOY TO TOMCAT DOCKER CONTAINER OVER SSH'){
        steps{
            sshPublisher(publishers: [sshPublisherDesc(configName: 'Docker', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''docker stop valaxy_demo;
            docker rm -f valaxy_demo;
            docker image rm -f valaxy_demo;
            cd /opt/docker;
            docker build -t valaxy_demo .
            docker run -d --name valaxy_demo -p 8090:8080 valaxy_demo
            ''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '//opt//docker', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
           }
      }

  stage('Anchore analyse') {
    steps {
     writeFile file: 'anchore_images', text: 'docker.io/gesellix/trufflehog'
     anchore bailOnFail: false, bailOnPluginFail: false, name: 'anchore_images'
        }
     }

  stage('dockerscan'){
        steps{
             sh '''
                     docker stop db arminc/clair-db || true
                     docker rm db arminc/clair-db || true
                     docker run -d --name db arminc/clair-db
                     sleep 15 # wait for db to come up
                     docker stop clair arminc/clair-local-scan  || true
                     docker rm clair arminc/clair-local-scan || true
                     docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan
                     sleep 1
                     DOCKER_GATEWAY=$(docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}")
                     wget -qO clair-scanner https://github.com/arminc/clair-scanner/releases/download/v8/clair-scanner_linux_amd64 && chmod +x clair-scanner
                     ./clair-scanner --ip="$DOCKER_GATEWAY" anchore/anchore-engine:v1.0.0 || exit 0
                 '''
                 }
            }

     stage('DOCKERIMAGE'){
            steps{
                sh 'docker pull gesellix/trufflehog'
            }
        }

        stage('GRYPE'){
            steps{
                sh 'grype gesellix/trufflehog'
            }
        }

        stage('SYFT'){
            steps{
                sh 'syft gesellix/trufflehog'
            }
        }

         stage ('DOCKER-BENCH') {
           steps {
               sh '''
                  docker run -i --net host --pid host --userns host --cap-add audit_control \
                  -e DOCKER_CONTENT_TRUST=$DOCKER_CONTENT_TRUST \
                  -v /var/lib:/var/lib \
                  -v /var/run/docker.sock:/var/run/docker.sock \
                  -v /usr/lib/systemd:/usr/lib/systemd \
                  -v /etc:/etc --label docker_bench_security \
                  docker/docker-bench-security
                  '''
                }
           }

          stage('INSPEC'){
            steps{
                sh 'git clone https://github.com/dev-sec/cis-docker-benchmark.git||true'
                sh 'inspec exe cis-docker-benchmark --chef-license=accept-silent ||true'
            }
        }

        stage('INSPEC CONTROLS'){
            steps{
                sh 'inspec exec /var/lib/jenkins/source/test.rb||true'
                }
            }
  }
}
