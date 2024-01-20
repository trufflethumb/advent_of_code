//
//  Day03Tests.swift
//
//
//  Created by Kevin Peng on 2024-01-19.
//

import Day03
import XCTest

func findParts(_ input: String) -> [Int: Int] {
    let input = Array(input)
    let width = if let lineWidth = input.firstIndex(of: "\n") {
        lineWidth + 1
    } else {
        input.count
    }
    let symbolsToSearch = Set<Character>(["*", "#", "+", "$"])
    var numbers = [Range<Int>: Int]()
    var symbols = [Int]()
    var currentNumbers = [Character]()
    var currentNumberStart: Int?
    for (index, char) in input.enumerated() {
        if char.isNumber {
            currentNumbers.append(char)
            if currentNumberStart == nil {
                currentNumberStart = index
            }
        } else {
            if let numberStart = currentNumberStart {
                numbers[numberStart..<index] = Int(String(currentNumbers))
                currentNumbers.removeAll()
                currentNumberStart = nil
            }
            if symbolsToSearch.contains(char) {
                symbols.append(index)
            }
        }
    }

    var parts = [Int: Int]()

    for symbol in symbols {
        for (range, number) in numbers {
            if findIntersection(symbolIndex: symbol, range: range, width: width, endIndex: input.endIndex) {
                parts[number, default: 0] += 1
            }
        }
    }
    return parts
}

func findIntersection(symbolIndex: Int, range: Range<Int>, width: Int, endIndex: Int) -> Bool {
    let searchIndices = [
        // top left
        symbolIndex - width - 1,
        // top mid
        symbolIndex - width,
        // top right
        symbolIndex - width + 1,
        // left
        symbolIndex - 1,
        // right
        symbolIndex + 1,
        // bot left
        symbolIndex + width - 1,
        // bot mid
        symbolIndex + width,
        // bot right
        symbolIndex + width + 1,
    ]
    for searchIndex in searchIndices {
        guard (0 ..< endIndex).contains(searchIndex) else { continue }
        if range.contains(searchIndex) { 
            return true
        }
    }
    return false
}

final class Day03Tests: XCTestCase {
    func test_example_line1() {
        let input = "467..114.."
        XCTAssertEqual(findParts(input), [:])
    }

    func test_example_line2() {
        let input = """
        467..114..
        ...*......
        """
        XCTAssertEqual(findParts(input), [467: 1])
    }

    func test_example_line3() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        """
        XCTAssertEqual(findParts(input), [467: 1, 35: 1])
    }

    func test_example_line4() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        """
        XCTAssertEqual(findParts(input), [467: 1, 35: 1, 633: 1])
    }

    func test_example_line5() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        """
        XCTAssertEqual(findParts(input), [467: 1, 35: 1, 633: 1, 617: 1])
    }

    func test_example_line6ToEnd() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
        XCTAssertEqual(findParts(input), [467: 1, 35: 1, 633: 1, 617: 1, 592: 1, 755: 1, 664: 1, 598: 1])
    }

    func test_edgeCase1() {
        let input = """
        467..114..
        ...*467...
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
        XCTAssertEqual(findParts(input), [467: 2, 35: 1, 633: 1, 617: 1, 592: 1, 755: 1, 664: 1, 598: 1])
    }
}
