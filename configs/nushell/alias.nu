# git stuff
alias gp = git push
alias ga = git add
alias gaa = git add --all

def gcm [
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

def --env gh [dir: string = ""] {
    cd $"~/documents/github/($dir)"
}
