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
               sh 'git clone https://github.com/dev-sec/ssh-baseline.git||true'
               sh 'git clone https:/github.com/dev-sec/linux-baseline.git||true'
               sh 'git clone https://github.com/dev-sec/ssl-baseline.git||true'
            }
      }
      
     stage('INSPEC-EXEC'){
            steps{
                sh 'inspec exe cis-docker-benchmark --chef-license-key  free-e028f41b-157d-4ad0-a672-860f457ba8ea-9290 ||true'
                sh 'inspec exe ssh-baseline --chef-license-key  free-e028f41b-157d-4ad0-a672-860f457ba8ea-9290 ||true'
                sh 'inspec exe linux-baseline --chef-license-key  free-e028f41b-157d-4ad0-a672-860f457ba8ea-9290 ||true'
                sh 'inspec exe ssl-baseline --chef-license-key  free-e028f41b-157d-4ad0-a672-860f457ba8ea-9290 ||true'
            }
        } 
        
       stage('INSPEC CONTROLS'){
            steps{
                sh 'inspec exec /var/lib/jenkins/workspace/DOCKER/test.rb --chef-license-key  free-e028f41b-157d-4ad0-a672-860f457ba8ea-9290 ||true'
                }
       }
   }
}
