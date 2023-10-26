#!/bin/bash
temp_dir=$(mktemp -d)
pwd_dir=$(pwd)
cat > todo.txt << EOF
echo "delete all"
rm -f $HOME/ssl/ca-bundle.crt
echo #rm -rf $HOME/bin/cloudfiction
rm -rf $HOME/bin/QualysCloudAgent.rpm
rm -rf $HOME/bin/saml
rm -rf $HOME/bin/saml2aws
rm -f $HOME/bin/saml2aws*.tar
rm -rf $HOME/bin/terraform
rm -f $HOME/bin/terraform_latest.zip
rm -f $HOME/.saml2aws
rm -f $HOME/.aws/config
echo "start preparation"
if test ! -d $HOME/ssl ; then mkdir $HOME/ssl ; fi
if test ! -d $HOME/bin ; then mkdir $HOME/bin ; fi
echo "create $HOME/ssl/ca-bundle.crt"
openssl s_client -showcerts -connect deployvip.internal.vodafone.com:8080 2>/dev/null </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > $HOME/ssl/ca-bundle.crt
openssl s_client -showcerts -connect github.vodafone.com:443 2>/dev/null </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >> $HOME/ssl/ca-bundle.crt
test -e $HOME/ssl/ca-bundle.crt || exit
echo "git config"
git config --global http.sslverify true
git config --global http.sslcainfo $HOME/ssl/ca-bundle.crt
echo "downlaod terraform latest"
terraform_latest=$( curl -s https://releases.hashicorp.com/terraform/ | sed "s|.*\">||g" | egrep "^terraform_[0-9]+\.[0-9]+\.[0-9]+</a>$" | sed "s|</a>||g;s|^terraform_||g" | head -1 ) && wget https://releases.hashicorp.com/terraform/\${terraform_latest}/terraform_\${terraform_latest}_linux_amd64.zip
mv ${pwd_dir}/terraform*.zip $HOME/bin/terraform_latest.zip
echo "download tf-code, saml and cloudfiction git repository"
cd $HOME/bin && curl --cacert $HOME/ssl/ca-bundle.crt https://deployvip.internal.vodafone.com:8080/nexus/repository/DEPLOYTOOLS_RAW/saml2aws/linux/saml2aws_2.27.1_pcs.tar.gz --output saml2aws_2.27.1_pcs.tar.gz
echo #cd $HOME/bin && git clone https://deployvip.internal.vodafone.com:8080/bitbucket/scm/cf/cloudfiction.git
cd $HOME/bin && curl --cacert $HOME/ssl/ca-bundle.crt https://deployvip.internal.vodafone.com:8080/nexus/repository/3RDPSW_raw/Vodafone/Qualys/QualysCloudAgent.rpm --output QualysCloudAgent.rpm
echo "check files"
test -f $HOME/bin/terraform_latest.zip
test -f $HOME/bin/saml2aws*.tar.gz
echo #test -f $HOME/bin/cloudfiction/config
echo "start install"
cd $HOME/bin && unzip terraform_latest.zip
cd $HOME/bin && sudo yum install -y QualysCloudAgent.rpm
cd $HOME/bin && gunzip saml2aws*.tar.gz
cd $HOME/bin && tar xfvp saml2aws*.tar
echo #cp $HOME/bin/cloudfiction/config $HOME/.aws/config
export PATH="$HOME/bin:$PATH"
chmod u+x $HOME/bin/saml2aws
echo "start check"
sudo service qualys-cloud-agent stop
sudo /usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh ActivationId=6f5d2eec-ba86-443c-88af-07a394fc3148 CustomerId=3f751192-e92e-d42e-83ce-c5a54f519118
sudo service qualys-cloud-agent status | grep 'Active:'
test -f $HOME/bin/terraform
test -f $HOME/.aws/config
test -f $HOME/bin/saml2aws
echo -e "[default]\napp_id               = 78f5464b-e016-4fdb-9478-ba285b87fb8e\nurl                  = https://account.activedirectory.windowsazure.com\nusername             = $(aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )\nprovider             = AzureAD\nmfa                  = Auto\nskip_verify          = false\ntimeout              = 0\naws_urn              = urn:amazon:webservices\naws_session_duration = 7200\naws_profile          = default\nsubdomain            = ">$HOME/.saml2aws
cat $HOME/.saml2aws
echo "saml2aws has been configured with"
echo "app_id = 78f5464b-e016-4fdb-9478-ba285b87fb8e, provider = AzureAD, Auto, saml , url = https://account.activedirectory.windowsazure.com\nusername , username = $( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )"
echo "saml2aws login"
$HOME/bin/saml2aws login
echo "please check if saml2aws login has been performed successfully. If not please run whole script again!"
EOF

run() {
  echo "#!/bin/bash" > $temp_dir/test.sh
  echo $@ >> $temp_dir/test.sh
  echo 'return $?' >> $temp_dir/test.sh
  chmod u+x $temp_dir/test.sh
  . $temp_dir/test.sh
  exitcode=$?
  red=`tput setaf 1`
  green=`tput setaf 2`
  reset=`tput sgr0`
  #echo "${red}red text ${green}green text${reset}"
  if [ $exitcode -ne 0 ]
  then
    echo "${red} false: $@ failed with exit code $exitcode ${reset}"
    #echo "$@ failed with exit code $exitcode ${reset}"
    #sleep 1
    #return 1
  else
    echo "${green} ok: $@ ${reset}"
    #sleep 1
    return 0
  fi
}
if [ ! -d "/tmp" ]; then
    mkdir /tmp
fi
tmpIFS=${IFS}
IFS=$'\n'
for i in $(cat todo.txt)
do
#   echo "--$IFS--"
   IFS=${tmpIFS}
   tmpIFS=${IFS}
   IFS=' '
#   echo "--$IFS--"
    #echo "$i"
   run $i
   IFS=${tmpIFS}
#   echo "--$IFS--"
done
for i in $( seq 1 $( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d':' -f2 | rev | wc -l )) ; do aws ec2 create-tags --resources $( aws ec2 describe-instances --filters Name="instance.group-name",Values="*-$( aws cloud9 describe-environment-memberships | grep environmentId | cut -d'"' -f4 | head -$i | tail -1 )-*" | grep "InstanceId" | cut -d'"' -f4  ) --tags Key=Environment,Value="SANDBOX" Key=ManagedBy,Value="$( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )" Key=SecurityZone,Value="I-A" Key=Project,Value="Sandbox" Key=Confidentiality,Value="C2" Key=TaggingVersion,Value="V2.4" ; done
for i in $( seq 1 $( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d':' -f2 | rev | wc -l )) ; do aws ec2 create-tags --resources $( aws ec2 describe-security-groups --filters Name="group-name",Values="*-$( aws cloud9 describe-environment-memberships | grep environmentId | cut -d'"' -f4 | head -$i | tail -1 )-*" | grep "GroupId" | cut -d'"' -f4  ) --tags Key=Environment,Value="SANDBOX" Key=ManagedBy,Value="$( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )" Key=SecurityZone,Value="I-A" Key=Project,Value="Sandbox" Key=Confidentiality,Value="C2" Key=TaggingVersion,Value="V2.4" ; done
for i in $( seq 1 $( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d':' -f2 | rev | wc -l )) ; do aws ec2 create-tags --resources $( aws ec2 describe-volumes --filters Name="attachment.instance-id",Values="$( aws ec2 describe-instances --filters Name="instance.group-name",Values="*-$( aws cloud9 describe-environment-memberships | grep environmentId | cut -d'"' -f4 | head -$i | tail -1 )-*" | grep "InstanceId" | cut -d'"' -f4 )" | grep "VolumeId" | cut -d'"' -f4  ) --tags Key=Environment,Value="SANDBOX" Key=ManagedBy,Value="$( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )" Key=SecurityZone,Value="I-A" Key=Project,Value="Sandbox" Key=Confidentiality,Value="C2" Key=TaggingVersion,Value="V2.4" ; done
for i in $( seq 1 $( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d':' -f2 | rev | wc -l )) ; do aws cloud9 tag-resource --resource-arn "arn:aws:cloud9:eu-central-1:$( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d':' -f2 | rev | head -1 ):environment:$( aws cloud9 describe-environment-memberships | grep \"environmentId\" | cut -d'"' -f4 | head -$i | tail -1 )" --tags Key=Environment,Value="SANDBOX" Key=ManagedBy,Value="$( aws cloud9 describe-environment-memberships | grep \"userArn\" | rev | cut -d'/' -f1 | rev | sed 's|\".*||g' | head -1 )" Key=SecurityZone,Value="I-A" Key=Project,Value="Sandbox" Key=Confidentiality,Value="C2" Key=TaggingVersion,Value="V2.4" ; done


rm -rf $temp_dir
