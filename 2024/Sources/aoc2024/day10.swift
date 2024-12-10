//
//  File.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-10.
//

import Foundation

func parseMountain(_ input: String) -> [[Int]] {
    input
        .components(separatedBy: .newlines)
        .map { line in
            Array(line).map(String.init).map { string in
                if let number = Int(string) {
                    return number
                } else {
                    return -1
                }
            }
        }
}

func encode(rows: Int, cols: Int, row: Int, col: Int) -> Int {
    rows * col + row
}

func decode(encoded: Int, rows: Int, cols: Int) -> (Int, Int) {
    let row = encoded % rows
    let col = (encoded - row) / rows
    return (row, col)
}

func findUniqueTrails(_ mountain: [[Int]], row: Int, col: Int) -> Set<Int> {
    let currentElevation = mountain[row][col]
    if currentElevation == 9 {
        return [encode(rows: mountain.count, cols: mountain[0].count, row: row, col: col)]
    }

    // keep a total
    var total = Set<Int>()
    // look up
    if row - 1 >= 0, mountain[row - 1][col] == currentElevation + 1 {
        total = total.union(findUniqueTrails(mountain, row: row - 1, col: col))
    }
    // look down
    if row + 1 < mountain.count, mountain[row + 1][col] == currentElevation + 1 {
        total = total.union(findUniqueTrails(mountain, row: row + 1, col: col))
    }
    // look left
    if col - 1 >= 0, mountain[row][col - 1] == currentElevation + 1 {
        total = total.union(findUniqueTrails(mountain, row: row, col: col - 1))
    }
    // look right
    if col + 1 < mountain[row].count, mountain[row][col + 1] == currentElevation + 1 {
        total = total.union(findUniqueTrails(mountain, row: row, col: col + 1))
    }

    return total
}

func findAllTrails(_ mountain: [[Int]], row: Int, col: Int) -> Int {
    let currentElevation = mountain[row][col]
    if currentElevation == 9 {
        return 1
    }

    // keep a total
    var total = 0
    // look up
    if row - 1 >= 0, mountain[row - 1][col] == currentElevation + 1 {
        total += findAllTrails(mountain, row: row - 1, col: col)
    }
    // look down
    if row + 1 < mountain.count, mountain[row + 1][col] == currentElevation + 1 {
        total += findAllTrails(mountain, row: row + 1, col: col)
    }
    // look left
    if col - 1 >= 0, mountain[row][col - 1] == currentElevation + 1 {
        total += findAllTrails(mountain, row: row, col: col - 1)
    }
    // look right
    if col + 1 < mountain[row].count, mountain[row][col + 1] == currentElevation + 1 {
        total += findAllTrails(mountain, row: row, col: col + 1)
    }

    return total
}

func findTrailHeads(_ input: [[Int]]) -> [(Int, Int)] {
    var results = [(Int, Int)]()
    for i in 0 ..< input.count {
        for j in 0 ..< input[i].count {
            if input[i][j] == 0 {
                results.append((i, j))
            }
        }
    }
    return results
}

func findScoreOfUniqueTrails(_ input: [[Int]]) -> Int {
    // find all trailheads
    let trailheads = findTrailHeads(input)

    // keep a total
    var trails = 0

    // for each trailhead, find all possible trails to 9
    for (row, col) in trailheads {
        trails += findUniqueTrails(input, row: row, col: col).count
    }
    return trails
}

func findScoreOfAllTrails(_ input: [[Int]]) -> Int {
    // find all trailheads
    let trailheads = findTrailHeads(input)

    // keep a total
    var trails = 0

    // for each trailhead, find all possible trails to 9
    for (row, col) in trailheads {
        trails += findAllTrails(input, row: row, col: col)
    }
    return trails
}
