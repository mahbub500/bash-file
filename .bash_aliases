#create vh from here https://github.com/RoverWire/virtualhost/blob/master/virtualhost.sh
#rename virtualhost  with vh
#fix site url issue with command "a2enmod rewrite"

#let's encrypt
alias lenc="certbot --apache -d"

#virtual host
alias vhc="vh create"
alias vhd="vh delete"

#wp-cli
alias wpcd='wp core download --allow-root'
alias wpcc='wp core config --allow-root --dbuser=root --dbpass=337338' # Set Up WP
alias wpdc='wp db create --allow-root' # Create Data Base
alias wpci='wp core install --allow-root --admin_user=admin --admin_password=337338 --admin_email=admin@local.host' # Install WP 
alias wpit='wp theme install twentytwelve astra --allow-root' # Install Theme
alias wptt='wp theme install twentytwelve --activate --allow-root' # Install Theme
alias wpip='wp plugin install query-monitor all-in-one-wp-migration wp-maximum-upload-file-size duplicator wp-reset simply-show-hooks  woocommerce --allow-root' #install Plugin
alias wpic='wp plugin install classic-editor  query-monitor --activate --allow-root' #install Plugin
alias wpup='wp plugin uninstall hello akismet --allow-root' # Uninstall Plugin 
alias wpcm='wp menu create "menu" --allow-root' # Create Menu
alias wpcl='wp menu item add-custom menu Admin http://apple.com --target="_blank" --allow-root' # Create Link
alias wpam='wp menu location assign menu primary --allow-root' # Assign menu
alias wppl="wp rewrite structure '/%postname%/' --allow-root" # Permalink Flush'
alias wpdt="wp config set WP_DEBUG true --raw --allow-root" # WpDebug On
alias wpdf="wp config set WP_DEBUG false --raw --allow-root" # WpDebug On
alias dbim="wp db import --allow-root" # Import DB
alias dbex="wp db export --allow-root" # Export DB

#misc
alias s="subl"
alias vsc="code --user-data-dir='~/.vscode-root'"
alias res="sudo systemctl restart apache2"
alias al="s ~/.bash_aliases"
alias all="s ~/.bashrc"
alias cl="clear"
alias update="sudo apt update && sudo apt upgrade"
#alias ct="gksudo nautilus /root/.local/share/" # clean trash / dangerous

alias mod="chmod 777 -R /home/mahbub/LocalSites/block/app/public/wp-content/plugins/turing"

#git
alias gi="git init"
alias gs="git status"
alias gst="git config credential.helper store" #store git cred
alias gsh="git stash"
alias ga="git add --all"
alias gp="gst && git push"
alias gpl="gst && git pull"
alias gpr="git remote prune origin"
alias gl="git log --oneline"
alias gc="ga && rm -f .git/index.lock && git commit -m "
alias gk="gitk"
alias gb="git branch"
alias gcb="git checkout " #branch checkout && git pull
alias gsw="git switch " #branch switch && git pull
alias gbd="git branch -D"
alias gcm="ga && git commit"
alias gm="git merge"
alias codeop='ga && git commit -m "code optimization"'
alias plbp="git clone https://mahbub@bitbucket.org/codexperthq/codexpert-plugin-boilerplate.git"
alias comu="composer update" # composer update
alias misc='ga && git commit -m "misc" && gp' # git add & commit & push
alias npmi="npm install"
alias npms="npm start"
alias npmrb="npm run build"
alias gro="git remote remove origin"



#dirs
alias em="s /var/mail/root"
alias lh="cd /var/www/html"
alias pld="cd wp-content/plugins"

#perm etc
alias chw="chown www-data:www-data -R /var/www/html"
alias sadekur="sudo chown mahbub -R /var/www/html"
alias fe="gksu nautilus" #file explorer
alias safari="wine ~/build/safari/safari.exe" #safari browser
alias br="rm /var/crash/* & cl" #system error notice
alias sn="br & shutdown now"
alias rb="reboot"
alias cdisk='sudo apt-get autoclean && \
sudo apt-get clean && \
sudo apt-get autoremove && \
sudo update-grub'

# sr wooffiliate wc_affiliate

#save new shortcut with command "source $file_path"

#cpb restrict-elementor-widgets restrict_elementor_widgets rew REW
    #cpb magazine-access magazine_access magazine_access MEGAZINE_ACCESS
    #cpb coschool-paid-memberships-pro CoSchool_Paid_Memberships_Pro coschool_pmp COSCHOOL_PMP
    #cpb advanced-formidable-option Advanced_Formidable_Option afo AFO
    # 1: name
    # 2: package
    # 3: prefix
    # 4: constant