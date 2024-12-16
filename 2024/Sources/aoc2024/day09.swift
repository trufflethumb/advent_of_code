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

// MARK: from this to the next marker was an incorrect attempt

func moveWholeFile2(_ disk: [Int], _ expandedDisk: [Int?]) -> [Int?] {
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

// MARK: code that worked for part 2
// note: there's got to be a more efficient way to do it

func spaceNeeded(_ rhs: Int, _ disk: [Int?]) -> (index: Int, count: Int)? {
    var rhs = rhs
    while rhs >= 0, disk[rhs] == nil {
        rhs -= 1
    }

    if rhs < 0 {
        return nil
    }

    var indicesToRemove = 0
    var prevNumber = disk[rhs - indicesToRemove]
    while prevNumber != nil, disk[rhs] == prevNumber {
        indicesToRemove += 1
        if rhs == indicesToRemove {
            return nil
        }
        prevNumber = disk[rhs - indicesToRemove]
    }
    return (rhs, indicesToRemove)
}

func findSpace(count: Int, _ disk: [Int?]) -> Int? {
    var lhs = 0
    while lhs < disk.count {
        while lhs < disk.count, disk[lhs] != nil {
            lhs += 1
        }

        if lhs == disk.count {
            return nil
        }

        var indicesToFill = 0
        while lhs + indicesToFill < disk.count, disk[lhs + indicesToFill] == nil {
            indicesToFill += 1
        }

        if indicesToFill < count {
            lhs += 1
        } else {
            return lhs
        }
    }
    return lhs
}

func moveWholeFile(_ disk: [Int], _ expandedDisk: [Int?]) -> [Int?] {
    var expandedDisk = expandedDisk
    var rhs = expandedDisk.count - 1

    while rhs > 0 {
        guard let (sourceIndex, spaces) = spaceNeeded(rhs, expandedDisk) else {
            // searched all numbers and we are done
            return expandedDisk
        }

        guard let destIndex = findSpace(count: spaces, expandedDisk) else {
            // Didn't find \(spaces) spaces at lhs = \(lhs) for rhs = \(rhs) having number \(expandedDisk[rhs]?.description ?? "."), looking left")
            rhs -= spaces
            continue
        }

        guard sourceIndex > destIndex else {
            rhs = sourceIndex - spaces
            continue
        }

        for i in 0 ..< spaces {
            expandedDisk.swapAt(sourceIndex - i, destIndex + i)
            rhs -= 1
        }
    }
    return expandedDisk
}
