#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k
sed -e 's|^ZSH_THEME=".*$|ZSH_THEME="powerlevel10k\/powerlevel10k"|' \
    -e "/ZSH_THEME=\"/i\POWERLEVEL9K_MODE='nerdfont-complete'" \
    -e 's|^plugins=(.*$|plugins=( \
        \tgit \
        \tzsh-autosuggestions \
        \tzsh-syntax-highlighting \
        \tzsh-history-substring-search \
        )|' \
    -i /root/.zshrc
source /root/.zshrc
p10k configure