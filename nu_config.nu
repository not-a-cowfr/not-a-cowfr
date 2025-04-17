let dark_theme = {
    separator: white
    leading_trailing_space_bg: { attr: n }
    header: green_bold
    empty: blue
    bool: {|| if $in { 'light_cyan' } else { 'light_gray' } }
    int: white
    filesize: {|e|
      if $e == 0b {
        'white'
      } else if $e < 1mb {
        'cyan'
      } else { 'blue' }
    }
    duration: white
    date: {||
        let age = (date now) - $in
        if $age < 1hr {
            'red_bold'
        } else if $age < 3hr {
            { fg: '#ff4500' }
        } else if $age < 6hr {
            { fg: '#ffa500' }
        } else if $age < 12hr {
            { fg: '#ffd700' }
        } else if $age < 1day {
            { fg: '#ffff00' }
        } else if $age < 2day {
            { fg: '#adff2f' }
        } else if $age < 3day {
            { fg: '#7fff00' }
        } else if $age < 1wk {
            { fg: '#7cfc00' }
        } else if $age < 2wk {
            { fg: '#00fa9a' }
        } else if $age < 4wk {
            { fg: '#00ced1' }
        } else if $age < 12wk {
            { fg: '#4682b4' }
        } else {
            { fg: '#d3d3d3' }
        }
    }
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
}

$env.config = {
    show_banner: false
    buffer_editor: "zed"
    color_config: $dark_theme
    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
    }
    float_precision: 2
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

alias gh = cd ~/documents/github
alias cd.. = cd ..
alias "cd ." = cd ..
alias neofetch = bash neofetch
alias "zed update" = scoop update zed-nightly

# table of uncommited lines removed and added, good for egoing yourself with how much you overcomplicate things
def "git lines" [
    --no-ansi (-n), # Disable ansi coloring in the table, allowing you to pipe into other commands that rely on the cell being an number
    --total (-t), # Only show the total diff, no table of each file
]: nothing -> any {
    if (git rev-parse --is-inside-work-tree | str trim) != "true" {
        return
    }

    let diff = (^git diff HEAD --numstat -M err> nul | lines | where $it =~ '^\d+\s+\d+\s+')

    if ($diff | is-empty) {
        print $"(ansi red_bold)No changes have been made!(ansi reset)"
        return
    }

    let stats = $diff
        | split column "\t" added removed file
        | each { |row| { file: $row.file, added: ($row.added | into int), removed: ($row.removed | into int) } }

    let total_added = $stats.added | math sum
    let total_removed = $stats.removed | math sum
    let net_diff = $total_added - $total_removed

    let diff_color = if $net_diff > 0 {
        $"+(ansi green)"
    } else if $net_diff == 0 {
        $"(ansi white)"
    } else {
        $"-(ansi red)"
    }

    print $"\n(ansi white_bold)Total:\n(ansi green)($total_added)(ansi reset) added\n(ansi red)($total_removed)(ansi reset) removed\n($diff_color)($net_diff | math abs)(ansi reset) diff"

    match $total {
        true => {
            if $no_ansi {
                print $"\n(ansi red)Why would you use no ansi to mess with the table data, and then remove the table data(ansi reset)"
            }
        },
        false => {
            print
            match $no_ansi {
                true => {
                    $stats
                },
                false => {
                    $stats | each { |row|
                        { file: $row.file,
                            added: $"(ansi green)($row.added)(ansi reset)",
                            removed: $"(ansi red)($row.removed)(ansi reset)" }
                    }
                },
            }
        },
    }
}

# Total line count across all non-gitignored files in the current directory
def "git total lines" [
#     --include (-i): string, # Only include a certain file type, eg. --include .nu or -i rs
#     --exclude (-e): string, # Exclude a certain file type
#     --exclude-bloat (-eb): string, # Exclude files known to be autogenerated or bloat that shouldnt count as lines of code, eg. config files
    --total (-t), # Only show the total lines, no table of each file
]: nothing -> any {
    if (git rev-parse --is-inside-work-tree | str trim) != "true" {
        return
    }

    let lines = ^git ls-files
        | lines
        | each {|file| { file: $file, lines: (open --raw $file | lines | length) } }

    print $"\nTotal: (ansi green)($lines.lines | math sum)(ansi reset)"

    match $total {
        true => {},
        false => {
            print ""
            $lines
        }
    }
}
