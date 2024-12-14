//
//  day09.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-13.
//

import Foundation

func parseDisk(_ input: String) -> [Int] {
    input.compactMap { Int(String($0)) }
}

func parseExpanded(_ input: String) -> [Int?] {
    input.map { Int(String($0)) }
}

func makeInts(_ digit: Int, repeats: Int) -> [Int] {
    [Int](repeating: digit, count: repeats)
}

func makeNilInts(repeats: Int) -> [Int?] {
    [Int?](repeating: nil, count: repeats)
}

func expandBlocks(_ input: [Int]) -> [Int?] {
    var result = [Int?]()
    for i in 0 ..< input.count {
        let repeats = input[i]
        if i % 2 == 0 {
            result.append(contentsOf: makeInts(i / 2, repeats: repeats))
        } else {
            result.append(contentsOf: makeNilInts(repeats: repeats))
        }
    }
    return result
}

func defrag(_ expandedDisk: [Int?]) -> [Int?] {
    var lhs = 0
    var rhs = expandedDisk.count - 1
    var defraged = expandedDisk
    while lhs < rhs {
        guard defraged[lhs] == nil else {
            lhs += 1
            continue
        }

        guard defraged[rhs] != nil else {
            rhs -= 1
            continue
        }

        defraged.swapAt(lhs, rhs)
    }
    return defraged
}

func checksum(_ defraged: [Int?]) -> Int {
    var result = 0
    for (index, element) in defraged.enumerated() {
        guard let element else { break }
        result += index * element
    }
    return result
}
