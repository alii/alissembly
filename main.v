import os

const op_codes = [
	'ADR',
	'ADD',
	'SUB',
	'MUL',
	'DIV',
	'SET',
	'DEL',
	'DEBUG_MEM',
	'DEBUG_ADR',
	'GET',
	'JNZ',
	'PNT'
	// Fake opcode
	'loop',
]

struct ProgramLine {
	line        string
	line_number i16
}

struct ProgramLabel {
	name        string
	line_number i16
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
	mut loop_markers := map[string]i64{}

	mut i := i64(0)
	for i < lines.len {
		program_line := lines[i]

		split := program_line.line.split(' ')
		opcode := split[0]
		args := split[1..].map(it.i64())

		i++

		if !is_valid_opcode(opcode) {
			panic('Invalid opcode: ' + opcode + ' on line ' + program_line.line_number.str())
			return
		}

		match opcode {
			'loop' {
				loop_markers[split[1..].join(' ')] = i
			}
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
			'PNT' {
				println(mem[curr_addr])
			}
			'DEL' {
				mem.delete(args[0])
			}
			'DEBUG_ADR' {
				println(curr_addr.str() + ': ' + mem[curr_addr].str())
			}
			'DEBUG_MEM' {
				println(mem)
			}
			'GET' {
				mem[curr_addr] = mem[args[0]]
			}
			'JNZ' {
				if mem[args[0]] != 0 {
					loop_name := split[2..].join(' ')
					new_line := loop_markers[loop_name]
					i = new_line
				}
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

		if line.starts_with('.') {
			label := line[1..]

			result << ProgramLine{
				line: label
				line_number: i + 1
			}
		} else {
			result << ProgramLine{
				line: line
				line_number: i + 1
			}
		}
	}

	return result
}
