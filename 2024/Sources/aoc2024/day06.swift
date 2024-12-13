//
//  day06.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-09.
//
// 0 = north, 1 = east, 2 = south, 3 = west

import Foundation

/// returns whether the step was new
func patrol(_ field: inout [[Character]], _ row: Int, _ col: Int) -> Bool {
    if field[row][col] == "." {
        field[row][col] = "X"
        return true
    }
    return false
}

func parseField(_ string: String) throws -> (field: [[Character]], start: (Int, Int)) {
    var result = [[Character]]()
    var guardCoord: (Int, Int)?
    for (row, line) in string.components(separatedBy: .newlines).enumerated() {
        for (col, character) in line.enumerated() {
            if character == "^" {
                guardCoord = (row, col)
            }
        }
        result.append(Array(line))
    }

    guard let guardCoord else {
        throw NSError(domain: "Missing Guard", code: 0)
    }

    result[guardCoord.0][guardCoord.1] = "X"

    return (result, guardCoord)
}

func checkNextStep(_ field: [[Character]], _ row: Int, _ col: Int, dir: Int) -> (String, dr: Int, dc: Int) {
    let dr: Int
    let dc: Int
    switch dir {
    case 0:
        dr = -1
        dc = 0
    case 1:
        dr = 0
        dc = 1
    case 2:
        dr = 1
        dc = 0
    case 3:
        dr = 0
        dc = -1
    default:
        fatalError("Unsupported direction")
    }

    let char = field[row + dr][col + dc]

    if char == "#" {
        return ("obstacle", dr, dc)
    } else if row + dr == 0 || col + dc == 0 || row + dr == field.count - 1 || col + dc == field[0].count - 1 {
        return ("bound", dr, dc)
    } else {
        return ("free", dr, dc)
    }
}

func walkAll(_ input: String) throws -> Int {
    var (field, (row, col)) = try parseField(input)
    var dir = 0
    var uniqueSteps = 1
    var stop = false
    while !stop {
        let (result, dr, dc) = checkNextStep(field, row, col, dir: dir)
        switch result {
        case "obstacle":
            dir = turnRight(dir)
            continue
        case "bound":
            row += dr
            col += dc
            stop = true
        default:
            row += dr
            col += dc
            break
        }

        if patrol(&field, row, col) {
            uniqueSteps += 1
        }
    }

    return uniqueSteps
}

func detectLoop(_ field: [[Character]], _ startRow: Int, _ startCol: Int, startDir: Int) -> Bool {
    var row = startRow
    var col = startCol
    var dir = startDir
    var field = field
    var stop = false
    var pastFirst = false
    while !stop {
        let (result, dr, dc) = checkNextStep(field, row, col, dir: dir)

        if row == startRow,
           col == startCol,
           dir == startDir,
           pastFirst
        {
            return true
        }

        pastFirst = true

        switch result {
        case "obstacle":
            dir = turnRight(dir)
            continue
        case "bound":
            row += dr
            col += dc
            stop = true
        default:
            row += dr
            col += dc
        }

        _ = patrol(&field, row, col)

    }

    return false
}
func turnRight(_ dir: Int) -> Int {
    (dir + 1) % 4
}

func printField(_ field: [[Character]], _ guardRow: Int, _ guardCol: Int, _ direction: Int) {
    func p(_ text: String) {
        print(text, terminator: "")
    }
    for i in 0 ..< field.count {
        for j in 0 ..< field[0].count {
            if i == guardRow && j == guardCol {
                switch direction {
                case 0:
                    p("^")
                case 1:
                    p(">")
                case 2:
                    p("v")
                case 3:
                    p("<")
                default:
                    p("ERROR")
                }
            } else {
                p(String(field[i][j]))
            }
        }
        p("\n")
    }
    p("\n")
}
