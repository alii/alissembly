import os

struct ProgramLine {
	line   string
	number i8
}

fn main() {
	data := os.read_file('./program.aa') or {
		println("Couldn't open file idk why lol")
		return
	}

	raw_lines := data.split('\n')
	lines := get_valid_lines(raw_lines)

	mut curr_addr := i8(0)

	for program_line in lines {
		split := program_line.line.split(' ')
		opcode := split[0]
		args := split[1..].map(it.i8())

		if !is_valid_opcode(opcode) {
			panic('Invalid opcode: ' + opcode + ' on line ' + program_line.number.str())
			return
		}

		println(opcode)
		println(args)
		println(curr_addr)
	}
}

fn is_valid_opcode(code string) bool {
	return false
}

fn get_valid_lines(lines []string) []ProgramLine {
	mut result := []ProgramLine{cap: lines.len}

	for i in 0 .. lines.len {
		line := lines[i].trim_space()

		if line.starts_with('#') || line == '' {
			continue
		}

		result << ProgramLine{
			line: line
			number: i + 1
		}
	}

	return result
}
