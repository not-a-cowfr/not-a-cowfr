# git stuff
alias gp = git push
alias ga = git add
alias gaa = git add --all

# alias for `git commit -m "<message>"`
export def gcm [
    message: string, # git commit message
] {
    git commit -m $"\"($message)\""
}

# typo fixes
alias cd.. = cd ..
alias "cd ." = cd ..
alias "zed update" = scoop update zed-nightly
alias "nu config" = config nu

# use better stuff
alias neofetch = fastfetch
alias npx = pnpm dlx
alias npm = pnpm

# misc
alias fuck = sudo !!

# cd into a dir in `~/documents/github` cus i do it often and im lazy
export def --env gh [dir: string = ""] {
    cd $"~/documents/github/($dir)"
}
