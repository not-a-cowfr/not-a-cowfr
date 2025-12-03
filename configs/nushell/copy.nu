def "nu-keybind commandline-copy" []: nothing -> nothing {
    commandline
		| nu-highlight
		| [
			'```ansi'
			$in
			'```'
		]
		| str join (char nl)
		| clip copy -a
}

$env.config.keybindings ++= [
    {
        name: copy_color_commandline
        modifier: control_alt
        keycode: char_c
        mode: [emacs vi_insert vi_normal]
        event: {
            send: executehostcommand
            cmd: 'nu-keybind commandline-copy'
        }
    }
]
