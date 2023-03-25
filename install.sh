#!/bin/bash

echo "Installing and Upgrading OS Packages ..."

sudo apt-get update -y > /dev/null \
    && sudo apt-get upgrade -y > /dev/null \
    && sudo apt-get install -y > /dev/null \
        git \
        vim \
        build-essential \
        wget \
        zsh > /dev/null

github_dir="$HOME/Codes/github"
dcorrea_dir="$HOME/Codes/dcorrea"
nerdfonts_dir="$github_dir/nerdfonts"
bundles_vim="$HOME/.vim/bundle"

mkdir $github_dir -p
mkdir $dcorrea_dir -p
mkdir $nerdfonts_dir -p

WHOAMI=$(whoami)
MY_NAME="Danilo Correa"
MY_EMAIL="danilosilva87@gmail.com"
GIT_CONFIG_CONTENT=$(cat << EOF
[alias]
    l = log --pretty=oneline -n 35 --graph --abbrev-commit
    aliases = config --get-regexp alias
    whoami = config user.email
    contributors = shortlog --summary --numbered
    tags = tag -l
    branches = branch --all
    remotes = remote --verbose
[color]
    # Use colors in Git commands that are capable of colored output when
    # outputting to the terminal. (This is the default setting in Git ≥ 1.8.4.)
    ui = auto
[color "branch"]
    current = yellow reverse
    local = yellow bold
    remote = green bold
[color "diff"]
    meta = yellow bold
    frag = magenta bold # line info
    old = red # deletions
    new = green # additions
[color "status"]
    added = green bold
    changed = red bold
    untracked = cyan bold
[user]
    email = $MY_EMAIL
    name = $MY_NAME
[core]
    editor = vim
[mergetool]
    prompt = false
EOF
)

echo "Generating your .gitconfig file."
printf "%s\n" "$GIT_CONFIG_CONTENT" > "$HOME/.gitconfig"

for value in Regular Bold
do
    printf "Baixando Ubuntu %s \n" "$value"
    printf "Baixando UbuntuMono %s \n \n" "$value"

    ubuntu_url="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Ubuntu/Regular/complete/Ubuntu%20Nerd%20Font%20Complete.ttf"
    ubuntu_mono_url="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/UbuntuMono/Regular/complete/Ubuntu%20Mono%20Nerd%20Font%20Complete.ttf"

    curl -s -fLo "$nerdfonts_dir/Ubuntu Nerd Font Complete.otf" $ubuntu_url > /dev/null
    curl -s -fLo "$nerdfonts_dir/UbuntuMono Nerd Font Complete.otf" $ubuntu_mono_url > /dev/null
done

if [ -d $bundles_vim ]; then
    rm -rf $bundles_vim
fi

rm -rf ~/.vimrc

printf "%s \n" "Installing Your Vundle Package Manager"
git clone --quiet https://github.com/VundleVim/Vundle.vim.git "$bundles_vim/Vundle.vim" > /dev/null

vim -u "$(pwd)/vimrc_plugins" -c "PluginInstall" -c "qa!"

printf "%s \n" "Configuring your vimrc file"
ln -sfn "$(pwd)/vimrc" ~/.vimrc

rm -rf ~/.oh-my-zsh
rm -rf ~/.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

printf "%s \n" "Install plugins to Oh-My-Zsh"

rm -rf ~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
rm -rf ~/.oh-my-zsh/custom}/plugins/plugins/zsh-syntax-highlighting

git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

old_text="plugins=(git)"
new_text="plugins=(git asdf docker docker-compose extract zsh-autosuggestions copyfile extract gitfast jsontools zsh-syntax-highlighting)"

sed -i "s/$old_text/$new_text/g" ~/.zshrc
