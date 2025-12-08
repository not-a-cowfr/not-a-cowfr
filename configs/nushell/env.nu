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

# adds target/debug and target/release to path for testing rust binaries
$env.config = ($env.config | upsert hooks.env_change.PWD {
	append {
		condition: {|_, after| ($after | path join 'Cargo.lock' | path exists) }
		code: {|_, after|
			$env.PATH = (
				$env.PATH
					| prepend ($after | path join 'target' 'debug')
					| prepend ($after | path join 'target' 'release')
					| uniq
			)
		}
	}
  | append {
		condition: {|before, _| ($before | default '' | path join 'Cargo.lock' | path exists) and ($before | is-not-empty)}
		code: {|before, _|
			$env.PATH = (
				$env.PATH
					| where $it != ($before | path join 'target' 'debug')
					| where $it != ($before | path join 'target' 'release')
					| uniq
			)
		}
	}
})