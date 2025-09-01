# git stuff
alias gp = git push
alias ga = git add
alias gaa = git add --all

# alias for `git commit -m "<message>"`
export def gcm [
    message: string, # git commit message
]: string -> nothing {
    git commit -m $"($message)"
}

# typo fixes
alias cd.. = cd ..
alias "cd ." = cd ..

# use better stuff
alias neofetch = fastfetch
alias npx = pnpm dlx
alias npm = pnpm
alias cat = bat
alias code = codium

# misc
alias fuck = sudo !!
alias "zig clean" = rm -rf .zig-cache zig-out
alias "pnpm clean" = rm -rf node_modules pnpm-lock.yaml

# cd into a dir in `~/documents/github` cus i do it often and im lazy
export def --env gh [dir: string = ""]: nothing -> nothing {
    cd $"~/Documents/GitHub/($dir)"
}



const vscodium_root_flags = "--no-sandbox --user-data-dir=\"~/.vscodium-root\"";

const config_dirs = {
    "nu": "~/.config/nushell",
    "starship": "~/.config/starship.toml",
    "nix": $"/etc/nixos ($vscodium_root_flags)",
}

# new config command to open predermined directories instead of only working for nushell
export def "config" [
    app: string, # name of the app you want to open the config for
]: nothing -> nothing {
    let editor = $env.config.buffer_editor;

    let dir = $config_dirs | get $app | expand;

    nu -c $"($editor) ($dir)"
}

# open the nu config dir instead of just config.nu
# has to be done like this because config nu clashes with the builtin
export def "config nu" []: nothing -> nothing {
    let editor = $env.config.buffer_editor;

    nu -c $"($editor) ~/.config/nushell"
}
