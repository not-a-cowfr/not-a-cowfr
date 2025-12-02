# Ever so slightly modified version of a script made by melmass on discord
# List binaries and examples in the current cargo workspace
export def "cargo targets" []: nothing -> table {
  let meta = (cargo metadata --no-deps --format-version 1 | from json)
  if ($meta | is-empty) {
    return []
  }
  let targets = ($meta | get packages.targets | flatten -a)

  let bins = ($targets | where ("bin" in $it.kind) | upsert kind "bin")
  let examples = ($targets | where ("example" in $it.kind) | upsert kind "example")

  $bins |
  | append $examples
  | select kind name src_path
  | rename kind name path
  | upsert path {|i| $i.path | path relative-to $meta.workspace_root }
}
