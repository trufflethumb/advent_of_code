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
        guard let element else { continue }
        result += index * element
    }
    return result
}

// part 2

func printFirst(_ result: [Int?], _ digits: Int? = nil) {
    p(debugInfo(result, digits))
}

func debugFreeDisk(_ disk: [Int], _ first: Int? = nil) -> String {
    var result = ""
    for (i, e) in disk.enumerated() {
        if let first, i > first {
            break
        }
        if i % 2 == 0 {
            result.append("_")
        } else {
            result.append("\(e)")
        }
    }
    return result
}

func debugInfo(_ result: [Int?], _ digits: Int? = nil) -> String {
    var currentValue = ""
    for i in 0 ..< min(digits ?? result.count, result.count) {
        currentValue += result[i]?.description ?? "."
    }
    return currentValue
}


func moveWholeFile(_ disk: [Int], _ expandedDisk: [Int?]) -> [Int?] {
    var expandedDisk = expandedDisk
    var disk = disk
    var condenseDiskSourceReadIndex = disk.count - 1
    var conversion = makeConversionTable(disk)

    while condenseDiskSourceReadIndex > 0 {
        // find number of spots needed
        p("---")
        p(debugFreeDisk(disk))
        printFirst(expandedDisk)
        let numberOfSpotsNeeded = disk[condenseDiskSourceReadIndex]

        // find next empty spot
        let emptySpotIndex = findNextEmptySpotIndex(spaceNeeded: numberOfSpotsNeeded, modifiedDisk: disk)

        if emptySpotIndex == -1 {
            p("Looking at index \(condenseDiskSourceReadIndex), corresponds to number \(expandedDisk[conversion[condenseDiskSourceReadIndex]]?.description ?? "."), Skipping \(disk[condenseDiskSourceReadIndex])")
            condenseDiskSourceReadIndex -= 2
            continue
        }

        p("Looking at index \(condenseDiskSourceReadIndex), corresponds to number \(expandedDisk[conversion[condenseDiskSourceReadIndex]]?.description ?? "."), Need \(numberOfSpotsNeeded), found index \(emptySpotIndex), which corresponds to \(conversion[emptySpotIndex])")

        let convertedEmptySpotIndex = conversion[emptySpotIndex]

        let sourceIndex = conversion[condenseDiskSourceReadIndex]

        guard convertedEmptySpotIndex < sourceIndex else { break }

        for i in 0 ..< numberOfSpotsNeeded {
            expandedDisk.swapAt(convertedEmptySpotIndex + i, sourceIndex + i)
        }

        disk[emptySpotIndex] -= numberOfSpotsNeeded
        conversion[emptySpotIndex] += numberOfSpotsNeeded
        condenseDiskSourceReadIndex -= 2
    }

    return expandedDisk
}

func findNextEmptySpotIndex(spaceNeeded: Int, modifiedDisk: [Int]) -> Int {
    for i in stride(from: 1, to: modifiedDisk.count, by: 2) {
        if modifiedDisk[i] >= spaceNeeded {
            return i
        }
    }
    return -1
}

func makeConversionTable(_ disk: [Int]) -> [Int] {
    var currentIndex = 0
    var result = [Int]()
    for number in disk {
        result.append(currentIndex)
        currentIndex += number
    }
    return result
}
