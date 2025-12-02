use std/clip

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
    buffer_editor: "codium"
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
        missing_value_symbol: "undefined"
    }
    float_precision: 2
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source alias.nu
source commands/commands.nu
