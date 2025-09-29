use std/util "path add"

# cargo
path add "~/.cargo/bin"

# pnpm
$env.PNPM_HOME = "/home/andrew/.local/share/pnpm"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME )

# fnm
load-env (fnm env --shell bash
    | lines
    | str replace 'export ' ''
    | str replace -a '"' ''
    | split column "="
    | rename name value
    | where name != "FNM_ARCH" and name != "PATH"
    | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value }
)

$env.PATH = ($env.PATH
    | split row (char esep)
    | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

