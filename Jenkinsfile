pipeline {
    agent any
    stages {
        stage('Delete the workspace') {
            steps {
                sh "sudo rm -rf $WORKSPACE/*"
            }
        }
        stage('Installing Chef Workstation') {
            steps{
                script {
                    def exists = fileExists '/usr/bin/chef-client'
                    if (exists) {
                        echo "Saltandose la instalación de Chef Workstation, ya esta instalado"
                    } else {
                        sh 'sudo apt-get install -y wget unzip tree'
                        sh 'wget https://packages.chef.io/files/stable/chef-workstation/0.10.41/ubuntu/16.04/chef-workstation_0.10.41-1_amd64.deb'
                        sh 'sudo dpkg -i chef-workstation_0.10.41-1_amd64.deb'
                        sh 'sudo chef env --chef-license accept'
                    }
                }
            }
        }
        stage('Download Apache Cookbook') {
            steps{
		git credentialsId: 'git-repo-creds', url: 'git@github.com:jcastrejona/webserver-cookbook.git'
            }
        }
        stage('Install Kitchen Docker Gem') {
            steps {
                script {
                    def exists2 = fileExists '/usr/bin/kitchen'
                    if (exists2) {
                        echo "Ya se ha intalado kitchen, omitiendo la instalacion"
                    } else {
                        sh 'sudo chef gem install kitchen-docker'
                    }
                }
            }
        }
        /*stage('Test Kitchen') {
            steps {
                sh 'sudo kitchen test'
            }
        }*/
       /* stage('Upload to Chef Infra Server, Converge Nodes') {
            steps {
                withCredentials([zip(credentialsId: 'chef-starter-zip', variable: 'CHEFREPO')]) {
                    sh "chef install $WORKSPACE/Policyfile.rb -c $CHEFREPO/chef-repo/.chef/knife.rb"
                    sh "sudo chef push prod $WORKSPACE/Policyfile.lock.json -c $CHEFREPO/chef-repo/.chef/knife.rb"
                    withCredentials([sshUserPrivateKey(credentialsId: 'agent-key', keyFileVariable: 'agentKey', passphraseVariable: '', usernameVariable: '')]) {
                        sh "knife ssh 'policy_name:apache' -x vagrant -i $agentKey 'sudo chef-client' -c $CHEFREPO/chef-repo/.chef/knife.rb"
                    }
                    }       
                }
            }*/
        }
    }

