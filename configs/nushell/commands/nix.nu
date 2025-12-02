# opens a select menu to reuild and switch nixos and/or home-manager
def "nix rebuild" [] {
    let choices = ["nixos", "home-manager", "config flake"]
    let selected = ($choices | str join "\n" | fzf --multi | lines)

    let user = (whoami | str trim)
    let host = (hostname | str trim)
    
    if ($selected | any {|x| $x == "nixos"}) {
        sudo nixos-rebuild switch --flake $"/etc/nixos#($host)"
    }

    if ($selected | any {|x| $x == "config flake"}) {
        sudo nix flake update --flake /etc/nixos
    }

    if ($selected | any {|x| $x == "home-manager"}) {
        home-manager switch --flake $"/etc/nixos#($user)@($host)"
    }
}

# opens a select menu of nixos generations to remove
def "nix remove-generations" [] {
    let generations = nix list-generations | where not Current;
    
    let selected = $generations | get Generation | str join "\n" | fzf --multi | lines | into int;

    if ($selected != null) {
        sudo nix-env -p /nix/var/nix/profiles/system --delete-generations ...$selected
    }
}

def "nix list-generations" []: nothing -> table {
    nixos-rebuild list-generations
        | detect columns --guess
        | into datetime Build-date 
        | into int Generation 
        | into bool Current
        | update Specialisation {from json}

}
