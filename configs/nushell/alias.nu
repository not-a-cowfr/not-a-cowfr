# git stuff
alias gp = git push
alias ga = git add
alias gaa = git add --all

# alias for `git commit -m "<message>"`
export def gcm [
    ...message: string, # git commit message
] {
    git commit -m ($message | str join " ")
}

# typo fixes
alias cd.. = cd ..
alias "cd ." = cd ..
alias "code ," = code .

# use better stuff
alias neofetch = fastfetch
alias npx = pnpm dlx
alias npm = pnpm
alias cat = bat
alias code = codium
def "cargo install" [...rest] {
    if (which cargo-binstall | is-not-empty) {
        cargo binstall -y ...$rest
    } else {
        ^cargo install ...$rest
    }
}

# misc
alias "zig clean" = rm -rf .zig-cache zig-out
alias "pnpm clean" = rm -rf node_modules pnpm-lock.yaml
alias "bun clean" = rm -rf node_modules bun.lock

export def --env project [dir: string = ""]: nothing -> nothing {
    const project_dir = "~/projects";

    try {
        cd $"($project_dir)/($dir)"
    } catch {|e|
        let url = $"https://github.com/not-a-cowfr/($dir)"
        let clone = input $"(ansi red)Project ($dir) not found, would you like to try cloning (ansi blue)($url) (ansi reset)[y/N]: "

        if (($clone | str downcase) == "y") {
            cd $project_dir;
            git clone $url;
            cd $dir;
        }
    }
}

# nix stuff
alias "nix develop" = nix develop -c $env.STARSHIP_SHELL # starts nix develop in nu
alias nix-shell = nix-shell --run $env.STARSHIP_SHELL # starts nix-shell in nu
