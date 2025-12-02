use std/util "path add"

$env.PNPM_HOME = "/home/andrew/.local/share/pnpm";

# fnm
load-env (fnm env --shell bash
    | lines
    | str replace 'export ' ''
    | str replace -a '"' ''
    | split column "="
    | rename name value
    | where name != "FNM_ARCH" and name != "PATH"
    | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value });

path add [
    "~/.cargo/bin",
    $"($env.FNM_MULTISHELL_PATH)/bin",
    "~/.steam/steam/steamapps/common/Proton - Experimental/",
    $env.PNPM_HOME
];
