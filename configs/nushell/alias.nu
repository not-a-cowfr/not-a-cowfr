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
alias "cargo install" = cargo binstall -y

# misc
alias fuck = sudo !!
alias "zig clean" = rm -rf .zig-cache zig-out
alias "pnpm clean" = rm -rf node_modules pnpm-lock.yaml

# cd into a dir in `~/documents/github` cus i do it often and im lazy
export def --env gh [dir: string = ""]: nothing -> nothing {
    cd $"~/Documents/GitHub/($dir)"
}


let vscodium_root_flags = $"--no-sandbox --user-data-dir=/home/(whoami)/.config/VSCodium";

const config_dirs = {
    "starship": "~/.config/starship.toml",
    "nix": { dir: $"/etc/nixos", sudo: true },
    "nixos": { dir: $"/etc/nixos", sudo: true },
    "fastfetch": "~/.config/fastfetch",
}

# new config command to open predermined directories instead of only working for nushell
export def "config" [
    app: string, # name of the app you want to open the config for
]: nothing -> nothing {
    let editor = $env.config.buffer_editor;

    mut dir = $config_dirs | get $app;

    mut flags = "";
    mut sudo = ""

    if (($dir | describe) != "string") {
        let obj = $dir;
        $dir = $obj | get dir;
        if ($obj | get sudo) {
            $flags = $vscodium_root_flags;
            $sudo = "sudo "
        }
    }

    nu -c $"($sudo)($editor) ($dir) ($flags)"
}

# open the nu config dir instead of just config.nu
# has to be done like this because config nu clashes with the builtin
export def "config nu" []: nothing -> nothing {
    let editor = $env.config.buffer_editor;

    nu -c $"($editor) ~/.config/nushell"
}
