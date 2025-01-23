#!/bin/bash

# Função para tratamento de erro
function exit_exception() {
    if [ $? -eq 130 ]; then
echo "Exiting.."
exit 1
fi
}

# Função para switch de branch
function switch_branch() {

    selected=$(git branch | fzf +m \
    --height 40% \
    --layout reverse \
    --border  \
    --preview \
            'git -c color.ui=always log --oneline $(echo {} | tr -d "* ")' \
    --color bg:#222222,preview-bg:#333333)

    selected=$(echo $selected | tr -d "* ")

    exit_excepiotn

    echo ">>>> $selected"

    git switch "$selected"

}

# Função de Merge
function merge() {

    selected=$(git branch | fzf +m \
    --height 100% \
    --layout reverse \
    --border  \
    --preview \
            'git -c color.ui=always diff $(git branch | grep "^*" | tr -d "* " ) $(echo {} | tr -d "* ")' \
    --color bg:#222222,preview-bg:#333333)

    selected=$(echo $selected | tr -d "* ")

    exit_exception

    echo ">>>> $selected"

    git merge "$selected"
}

# Função para deletar branch
function delete_branch() {

        selected=$(git branch | fzf +m \
    --height 40% \
    --layout reverse \
    --border  \
    --preview \
            'git -c color.ui=always log --oneline $(echo {} | tr -d "* ")' \
    --color bg:#222222,preview-bg:#333333)

    selected=$(echo $selected | tr -d "* ")

    exit_excepiotn

    echo ">>>> $selected"

    git branch -d "$selected"
}

delete_branch

