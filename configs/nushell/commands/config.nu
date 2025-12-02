let vscodium_root_flags = $"--no-sandbox --user-data-dir=/home/(whoami)/.vscode-oss";

const config_dirs = {
    "starship": "~/.config/starship.toml",
    "alacritty": "~/.config/alacritty/alacritty.toml",
    "ghostty": "~/.config/ghostty/config",
    "nix": { dir: "/etc/nixos", sudo: true },
    "nixos": { dir: "/etc/nixos", sudo: true },
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

    nu -c $"($editor) (dirname $nu.config-path)"
}

# lists files tracked by git along with some extra git-related data
def "git ls" [] {
    mut index = 1;
    let gitlog = git log --all --format="%ai" --name-only --diff-filter=ACMRT
    | split row "\n\n"
    | each {|i|
        let lines = $i | lines

        let last = $lines | last | into datetime

        $lines
        | drop
        | each {|file| {name: $file commit-ts: $last} }
    }
    | flatten
    | uniq-by name

    git ls-files | lines | wrap name | join $gitlog name --inner
}
