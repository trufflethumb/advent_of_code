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

func searchOneDirection(_ board: [[Character]], _ word: [Character], _ row: Int, _ col: Int, drow: Int, dcol: Int) -> Bool {
    for i in 0 ..< word.count {
        if !searchOne(board, word, i, row + drow * i, col + dcol * i) {
            return false
        }
    }
    return true
}

func search(_ board: [[Character]], _ word: [Character], _ row: Int, _ col: Int) -> Int {
    guard searchOne(board, word, 0, row, col) else {
        return 0
    }

    var total = 0
    // check right
    total += searchOneDirection(board, word, row, col, drow: 0, dcol: 1) ? 1 : 0
    // check down
    total += searchOneDirection(board, word, row, col, drow: 1, dcol: 0) ? 1 : 0
    // check upperight
    total += searchOneDirection(board, word, row, col, drow: -1, dcol: 1) ? 1 : 0
    // check lowerright
    total += searchOneDirection(board, word, row, col, drow: 1, dcol: 1) ? 1 : 0

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

func searchSingleXMAS(_ board: [[Character]], _ row: Int, _ col: Int) -> Bool {
    let word = Array("MAS")
    let wordBackwards = Array("SAM")
    return [
        searchOneDirection(board, word, row - 1, col - 1, drow: 1, dcol: 1),
        searchOneDirection(board, word, row + 1, col - 1, drow: -1, dcol: 1),
        searchOneDirection(board, wordBackwards, row - 1, col - 1, drow: 1, dcol: 1),
        searchOneDirection(board, wordBackwards, row + 1, col - 1, drow: -1, dcol: 1),
    ].filter { $0 }.count == 2
}

func searchXMASes(_ board: [[Character]]) -> Int {
    var foundCount = 0
    for row in 1 ..< board.count - 1 {
        for col in 1 ..< board[0].count - 1 {
            guard board[row][col] == "A" else { continue }
            foundCount += searchSingleXMAS(board, row, col) ? 1 : 0
        }
    }

    return foundCount
}
