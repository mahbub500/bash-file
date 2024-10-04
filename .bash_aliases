

# WP-CLI Aliases
alias wpcd='wp core download --allow-root'
alias wpcc='wp core config --allow-root --dbuser=root --dbpass=337338'
alias wpdc='wp db create --allow-root'
alias wpci='wp core install --allow-root --admin_user=admin --admin_password=337338 --admin_email=admin@local.host'
alias wpit='wp theme install twentytwelve astra --allow-root'
alias wptt='wp theme install twentytwelve --activate --allow-root'
alias wpip='wp plugin install query-monitor all-in-one-wp-migration wp-maximum-upload-file-size duplicator wp-reset simply-show-hooks woocommerce --allow-root'
alias wpic='wp plugin install classic-editor query-monitor --activate --allow-root'
alias wpup='wp plugin uninstall hello akismet --allow-root'
alias wpcm='wp menu create "menu" --allow-root'
alias wpcl='wp menu item add-custom menu Admin http://apple.com --target="_blank" --allow-root'
alias wpam='wp menu location assign menu primary --allow-root'
alias wppl="wp rewrite structure '/%postname%/' --allow-root"
alias wpdt="wp config set WP_DEBUG true --raw --allow-root"
alias wpdf="wp config set WP_DEBUG false --raw --allow-root"
alias dbim="wp db import --allow-root"
alias dbex="wp db export --allow-root"

# Miscellaneous Aliases
alias s="subl"
alias vsc="code --user-data-dir='~/.vscode-root'"
alias res="sudo systemctl restart apache2"
alias al="s ~/.bash_aliases"
alias all="s ~/.bashrc"
alias cl="clear"
alias update="sudo apt update && sudo apt upgrade"

# Permissions
alias mod="chmod 777 -R /home/mahbub/LocalSites/block/app/public/wp-content/plugins/turing"

# Git Aliases
alias gi="git init"
alias gs="git status"
alias gst="git config credential.helper store"
alias gsh="git stash"
alias ga="git add --all"
alias gp="gst && git push"
alias gpl="gst && git pull"
alias gpr="git remote prune origin"
alias gl="git log --oneline"
alias gc="ga && rm -f .git/index.lock && git commit -m "
alias gk="gitk"
alias gb="git branch"
alias gcb="git checkout "
alias gsw="git switch "
alias gbd="git branch -D"
alias gcm="ga && git commit"
alias gm="git merge"
alias codeop='ga && git commit -m "code optimization"'
alias plbp="git clone https://mahbub@bitbucket.org/codexperthq/codexpert-plugin-boilerplate.git"
alias comu="composer update"
alias misc='ga && git commit -m "misc" && gp'
alias npmi="npm install"
alias npms="npm start"
alias npmrb="npm run build"
alias gro="git remote remove origin"

# Directories
alias em="s /var/mail/root"
alias lh="cd /var/www/html"
alias pld="cd wp-content/plugins"

# Permissions and system utilities
alias chw="chown www-data:www-data -R /var/www/html"
alias sadekur="sudo chown mahbub -R /var/www/html"
alias fe="gksu nautilus"
alias safari="wine ~/build/safari/safari.exe"
alias br="rm /var/crash/* && cl"
alias sn="br && shutdown now"
alias rb="reboot"
alias cdisk='sudo apt-get autoclean && sudo apt-get clean && sudo apt-get autoremove && sudo update-grub'

# Git clone and composer update
clone() {
  [ -z "$1" ] && { echo "Usage: clone <repository_url> [optional_target_directory]"; return 1; }

  REPO_URL="$1"
  TARGET_DIR="${2:-$(basename "$REPO_URL" .git)}"

  echo "Cloning repository: $REPO_URL to $TARGET_DIR"
  git clone "$REPO_URL" "$TARGET_DIR" && cd "$TARGET_DIR" || { echo "Error: Failed to clone or change directory"; return 1; }

  [ -f "composer.json" ] && { echo "Running composer update..."; composer update; }
}

# cpb for creating plugin/client from boilerplate
  cpb() {
    # Prompt user for inputs using echo and read without -p
    echo 'Type (1: Plugin / 2: Client):'; read type
    echo 'Name:'; read name
    echo 'Slug:'; read slug
    echo 'Package:'; read package
    echo 'Prefix:'; read prefix
    echo 'Constant:'; read constant
    echo 'Description:'; read description

    # Clone the CX Plugin repository
    git clone "https://bitbucket.org/codexpertio/cx-plugin/src/master/" "$slug" && cd "$slug" || { echo "Failed to clone or move to directory"; return 1; }

    # If type is client (2), switch to the client branch
    [[ "$type" == 2 ]] && git checkout client

    # Rename the main plugin file
    mv "cx-plugin.php" "$slug.php"

    # Replace placeholders in all files
    [[ "$name" != "" ]] && find . -type f -exec sed -i '' "s/CX Plugin/$name/g" {} \;
    [[ "$slug" != "" ]] && find . -type f -exec sed -i '' "s/cx-plugin/$slug/g" {} \;
    [[ "$package" != "" ]] && find . -type f -exec sed -i '' "s/CX_Plugin/$package/g" {} \;
    [[ "$prefix" != "" ]] && find . -type f -exec sed -i '' "s/cx_plugin/$prefix/g" {} \;
    [[ "$constant" != "" ]] && find . -type f -exec sed -i '' "s/CXP/$constant/g" {} \;
    [[ "$description" != "" ]] && find . -type f -exec sed -i '' "s/Just another plugin by Codexpert/$description/g" {} \;

    # Run composer install, remove the .git directory, and initialize git again
    composer install && rm -rf .git && git init && git add . && git commit -m "init"
}


# String replace function
sr() { find ./ -type f -exec sed -i "s/$1/$2/g" {} \; }

# Git branch prompt
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

