//
//  File.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-07.
//

import Foundation

func searchOne(_ board: [[Character]], _ word: [Character], _ index: Int, _ row: Int, _ col: Int) -> Bool {
    guard row >= 0, col >= 0, row < board.count, col < board[0].count else { return false }
    return board[row][col] == word[index]
}

func search(_ board: [[Character]], _ word: [Character], _ row: Int, _ col: Int) -> Int {
    guard searchOne(board, word, 0, row, col) else {
        return 0
    }

    var total = 0
    var found = true
    // check right
    for i in 1 ..< word.count {
        if !searchOne(board, word, i, row, col + i) {
            found = false
            break
        }
    }

    if found {
        total += 1
    }

    found = true
    // check down
    for i in 1 ..< word.count {
        if !searchOne(board, word, i, row + i, col) {
            found = false
            break
        }
    }

    if found {
        total += 1
    }

    found = true
    // check upper right
    for i in 1 ..< word.count {
        if !searchOne(board, word, i, row - i, col + i) {
            found = false
            break
        }
    }

    if found {
        total += 1
    }

    found = true
    // check lower right
    for i in 1 ..< word.count {
        if !searchOne(board, word, i, row + i, col + i) {
            found = false
            break
        }
    }

    if found {
        total += 1
    }

    return total
}

func searchAllDirections(_ board: [[Character]]) -> Int {
    var foundCount = 0
    let toFindForwards = Array("XMAS")
    let toFindBackwards = Array("SAMX")
    for row in 0 ..< board.count {
        for col in 0 ..< board[0].count {
            foundCount += search(board, toFindForwards, row, col)
            foundCount += search(board, toFindBackwards, row, col)
        }
    }
    return foundCount
}
