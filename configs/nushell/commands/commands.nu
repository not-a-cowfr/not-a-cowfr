source backup.nu
source config.nu
source git.nu
source nix.nu
source rust.nu

export def "rm program" [
    program: string, # program to remove
    --no-confirm (-y), # skip confirmations
]: string -> nothing {
    let programs = which $program -a | each {|row| [$row.path $row.type] }
    if (($programs | is-empty)  ) {
        error make { msg: $"Program not found: ($program)" }
    } else {
        for program in $programs {
            if ($program.1) != "external" { continue }
            print ""

            if $no_confirm != true {
                let confirm = input $"Remove ($program.0)? \(Y/n\) "
                if $confirm == 'n' { continue }
            }

            rm $program.0
            print $"(ansi red)removed ($program.0)"
        }
    }
}
