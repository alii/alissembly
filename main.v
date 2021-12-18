import os

const op_codes = ['ADR', 'ADD', 'SUB', 'MUL', 'DIV', 'SET', 'RET']

struct ProgramLine {
	line   string
	number i16
}

fn main() {
	data := os.read_file('./program.aa') or {
		println("Couldn't open file idk why lol")
		return
	}

	raw_lines := data.split('\n')
	lines := get_valid_lines(raw_lines)

	mut curr_addr := i64(0)
	mut mem := map[i64]i64{}

	for program_line in lines {
		split := program_line.line.split(' ')
		opcode := split[0]
		args := split[1..].map(it.i64())

		if !is_valid_opcode(opcode) {
			panic('Invalid opcode: ' + opcode + ' on line ' + program_line.number.str())
			return
		}

		match opcode {
			'ADR' {
				curr_addr = args[0]
			}
			'SET' {
				mem[curr_addr] = args[0]
			}
			'ADD' {
				mem[curr_addr] = mem[args[0]] + mem[args[1]]
			}
			'SUB' {
				mem[curr_addr] = mem[args[0]] - mem[args[1]]
			}
			'MUL' {
				mem[curr_addr] = mem[args[0]] * mem[args[1]]
			}
			'DIV' {
				mem[curr_addr] = mem[args[0]] / mem[args[1]]
			}
			'RET' {
				println(mem[args[0]])
			}
			else {
				println('UNHANDLED OPCODE: ' + opcode)
			}
		}
	}
}

fn is_valid_opcode(code string) bool {
	return code in op_codes
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
