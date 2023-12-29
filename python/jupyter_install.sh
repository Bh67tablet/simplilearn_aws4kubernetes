#/bin/bash!
#
# only Debian Linux (apt) !!!
#
# https://dataschool.com/data-modeling-101/running-jupyter-notebook-on-an-ec2-server/
#
sudo apt-get install bzip2
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
sudo bash Anaconda3-2019.03-Linux-x86_64.sh
jupyter notebook --generate-config
cat > $HOME/.jupyter/jupyter_notebook_config.py << EOF
conf = get_config()
conf.NotebookApp.ip = '0.0.0.0'
conf.NotebookApp.password = u'YOUR PASSWORD HASH'
conf.NotebookApp.port = 8888
EOF
git clone https://github.com/Mohdwajtech/Complete-Python-3-Bootcamp.git
# set your password
#jupyter notebook password
#
# start:
jupyter notebook
