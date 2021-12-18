# alissembly

this is a JIT interpreter and maybe a VM (idk) for a basic programming language im calling alissembly. the language supports a basic memory map of interger values and has some opcodes for printing ascii, basic math and more

you can see some program examples in `program.aa`

| opcode      | description                                                                          | arguments              |
| ----------- | ------------------------------------------------------------------------------------ | ---------------------- |
| `ADR`       | Set / go to the current address                                                      | `address`              |
| `ADD`       | Add the value at given addresses and store the result in the current address         | `address1`, `address2` |
| `SUB`       | Subtract the value at given addresses and store the result in the current address    | `address1`, `address2` |
| `MUL`       | Multiply the value at given addresses and store the result in the current address    | `address1`, `address2` |
| `DIV`       | Divide the value at given addresses and store the result in the current address      | `address1`, `address2` |
| `SET`       | Set the value at the current address to the integer value                            | `value`                |
| `DEL`       | Delete the value at given address                                                    | `address`              |
| `GET`       | Get the value at the given address and stores it in the current address (aka a copy) | `address`              |
| `JNZ`       | Jump to the given loop label if the value at given address is not zero               | `address`, `label`     |
| `PNT`       | Print the value at the current address                                               |                        |
| `PNS`       | Print the value at the current memory address as ascii text                          |                        |
| `WIPE`      | Wipe the memory map                                                                  |                        |
| `DEBUG_MEM` | Print the memory map                                                                 |                        |
| `DEBUG_ADR` | Print the current address                                                            |                        |
