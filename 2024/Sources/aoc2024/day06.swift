//
//  day06.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-09.
//
// 0 = north, 1 = east, 2 = south, 3 = west

func patrol(_ field: inout [[Character]], _ row: Int, _ col: Int, uniqueSteps: inout Int) {
    if field[row][col] == "." {
        field[row][col] = "X"
        uniqueSteps += 1
    }
}

func parseField(_ string: String) -> (field: [[Character]], start: [Int]) {
    var result = [[Character]]()
    var guardCoord = [Int]()
    for (row, line) in string.components(separatedBy: .newlines).enumerated() {
        for (col, character) in line.enumerated() {
            if character == "^" {
                guardCoord = [row, col]
            }
        }
        result.append(Array(line))
    }

    result[guardCoord[0]][guardCoord[1]] = "X"

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

    if field[row + dr][col + dc] == "#" {
        return ("obstacle", dr, dc)
    } else if row + dr == 0 || col + dc == 0 || row + dr == field.count - 1 || col + dc == field[0].count - 1 {
        return ("bound", dr, dc)
    } else {
        return ("free", dr, dc)
    }
}

func walkAll(_ input: String) -> Int {
    var (field, guardCoord) = parseField(input)
    var row = guardCoord[0]
    var col = guardCoord[1]
    var dir = 0
    var uniqueSteps = 1
    var stop = false
    while !stop {
        let (result, dr, dc) = checkNextStep(field, row, col, dir: dir)
        switch result {
        case "obstacle":
            dir = (dir + 1) % 4
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

        patrol(&field, row, col, uniqueSteps: &uniqueSteps)
    }

    return uniqueSteps
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
