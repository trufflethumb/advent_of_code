//
//  day05.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-09.
//


func parseManual(_ string: String) -> (dict: [Int: Set<Int>], updates: [[Int]]) {
    var dict = [Int: Set<Int>]()
    var updates = [[Int]]()
    var parsingOrders = true
    for line in string.components(separatedBy: .newlines) {
        if line.isEmpty {
            parsingOrders = false
            continue
        }
        if parsingOrders {
            let numbers = line
                .components(separatedBy: "|")
                .compactMap(Int.init)
            guard numbers.count == 2 else { fatalError("Parse Error") }
            dict[numbers[0], default: []].insert(numbers[1])
        } else {
            let numbers = line
                .components(separatedBy: ",")
                .compactMap(Int.init)

            updates.append(numbers)
        }
    }

    return (dict, updates)
}

func isPage(_ candidate: Int, before current: Int, _ dict: [Int: Set<Int>]) -> Bool {
    if let setOfBigger = dict[current] {
        if setOfBigger.contains(candidate) {
            return false
        }
    }
    return true
}

func isUpdateValid(_ update: [Int], _ dict: [Int: Set<Int>]) -> Bool {
    for i in 0 ..< update.count - 1 {
        for j in i + 1 ..< update.count {
            if !isPage(update[i], before: update[j], dict) {
                return false
            }
        }
    }
    return true
}

func fixIssues(_ update: [Int], _ dict: [Int: Set<Int>]) -> [Int] {
    var update = update
    for i in 0 ..< update.count - 1 {
        for j in i + 1 ..< update.count {
            if !isPage(update[i], before: update[j], dict) {
                update.swapAt(i, j)
            }
        }
    }
    return update
}

func middleNumber(_ update: [Int]) -> Int {
    guard update.count > 2 else { return 0 }
    return update[update.count / 2]
}

func sumOfValidMiddleNumbers(_ dict: [Int: Set<Int>], _ updates: [[Int]]) -> Int {
    updates.reduce(0) { sum, update in
        if isUpdateValid(update, dict) {
            return sum + middleNumber(update)
        } else {
            return sum
        }
    }
}

func sumOfFixedMiddleNumbers(_ dict: [Int: Set<Int>], _ updates: [[Int]]) -> Int {
    updates.reduce(0) { sum, update in
        if !isUpdateValid(update, dict) {
            let fixed = fixIssues(update, dict)
            return sum + middleNumber(fixed)
        } else {
            return sum
        }
    }
}
