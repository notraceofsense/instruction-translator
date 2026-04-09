// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

let OP_SHIFT: Int32 = 26
let R1_SHIFT: Int32 = 21
let R2_SHIFT: Int32 = 16
let R3_SHIFT: Int32 = 11

let OP_MASK: Int32 = 0x3F
let REG_MASK: Int32 = 0x1F
let FUNC_MASK: Int32 = 0x7FF
let IMM_MASK: Int32 = 0xFFFF

let LW_OP: Int32 = 0x23
let SW_OP: Int32 = 0x2B
let ADDI_OP: Int32 = 0x8
let REG_REG_OP: Int32 = 0x0
let BEQZ_OP: Int32 = 0x4
let HALT_OP: Int32 = 0x3F

let ADD_FUNC: Int32 = 0x20
let SLL_FUNC: Int32 = 0x4
let SRL_FUNC: Int32 = 0x6
let SUB_FUNC: Int32 = 0x22
let AND_FUNC: Int32 = 0x24
let OR_FUNC: Int32 = 0x25

func opcode(_ instr: Int32) -> Int32 {
    (instr >> OP_SHIFT) & OP_MASK
}

func function(_ instr: Int32) -> Int32 {
    instr & FUNC_MASK
}

func fieldR1(_ instr: Int32) -> Int32 {
    (instr >> R1_SHIFT) & REG_MASK
}

func fieldR2(_ instr: Int32) -> Int32 {
    (instr >> R2_SHIFT) & REG_MASK
}

func fieldR3(_ instr: Int32) -> Int32 {
    (instr >> R3_SHIFT) & REG_MASK
}

func fieldImm(_ instr: Int32) -> Int32 {
    instr & IMM_MASK
}

func convertNum(_ n: Int32) -> Int32 {
    (n & 0x8000) != 0 ? n - 65536 : n
}

func offset(_ instr: Int32) -> Int32 {
    convertNum(fieldImm(instr))
}

@main
struct instruction_translator: ParsableCommand {
    @Argument(help: "The instruction to translate, as an integer")
    var instr: Int32
    
    mutating func run() throws {
        switch opcode(instr) {
        case REG_REG_OP:
            switch function(instr) {
            case ADD_FUNC:
                print("add \(fieldR3(instr)), \(fieldR1(instr)), \(fieldR2(instr))\n"
                + "literal value: \(instr)\noffset: \(offset(instr))\n")
            default:
                print("Haven't done that yet ¯\\_(ツ)_/¯\n")
            }
        default:
            print("Haven't done that yet ¯\\_(ツ)_/¯\n")
        }
    }
}
