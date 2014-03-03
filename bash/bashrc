# Load .bashrc_gs
if [[ -f .bashrc_gs  ]]; then
  source .bashrc_gs
fi

# General Aliases
alias cpuinfo="sudo i7z_64bit"
alias sensors="watch -d -n 1 sensors"
alias pegasus-db="mysql -u root -ppass pegasus"
alias monad="../monad/monad --provided"
alias pgssh="ssh -i ~/.ssh/pegasus-prod.pem -l ubuntu"

# Directory Aliases
alias pegasus="cd /home/mass/development/web/pegasus"
alias mass-web="cd /home/mass/development/web/mass-web"

# Development Settings
export USE_CCACHE=1
export CCACHE_DIR=~/romdev/ccache
export PATH=${PATH}:~/development/android-sdk-linux/tools:~/development/android-sdk-linux/platform-tools
export PATH=${PATH}:~/development/web/google_appengine
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=1024m"

# Backs up all the important files in my home directory
backuphome() {
  T="$(date +%s)"
  echo "Starting backup of files\n\n"
  cd /home/mass
  mkdir $(date +%F)
  cd ./$(date +%F)
  cp -rv ~/development ~/.bfgminer ~/.ssh ~/.bashrc ~/.boto ~/.git-completion.bash ~/.git-prompt.sh ~/.nvidia-settings-rc ~/.vimrc ~/.gitconfig ~/.profile ~/.vim /etc/udev/51-android.rules ./ 
  cd ../
  tar cvzf "Compressed-Archive-"$(date +%F).tar.gz ./$(date +%F)/
  rm -rf ./$(date +%F)
  mv "Compressed-Archive-"$(date +%F).tar.gz /home/mass/Dropbox/backups/ubuntu
  T="$(($(date +%s)-T))"
  echo "\n\nBackup completed, time elapsed: ${T}"
}

# Clean and refresh the local pegasus database
refresh-pegasus-db() {
  OLD_DIR=$(pwd)
  cd ~/development/web/pegasus/tools
  cat create_tables.sql create_testdata.sql | mysql -u root -ppass
  cd $OLD_DIR
}
