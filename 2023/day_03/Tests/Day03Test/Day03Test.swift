//
//  Day03Tests.swift
//
//
//  Created by Kevin Peng on 2024-01-19.
//

import Day03
import XCTest

final class Day03Tests: XCTestCase {
    func test_example_line1() {
        let input = "467..114.."
        assertEqual(input, [])
    }

    func test_example_line2() {
        let input = """
        467..114..
        ...*......
        """
        assertEqual(input, [467])
    }

    func test_example_line3() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        """
        assertEqual(input, [467, 35])
    }

    func test_example_line4() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        """
        assertEqual(input, [467, 35, 633])
    }

    func test_example_line5() {
        let input = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        """
        assertEqual(input, [467, 35, 633, 617])
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
        assertEqual(input, [467, 35, 633, 617, 592, 755, 664, 598])
        XCTAssertEqual(findParts(input).reduce(0, +), 4361)
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
        assertEqual(input, [467, 467, 35, 633, 617, 592, 755, 664, 598])
    }

    func test_long() {
        let input = """
        ........*.......................*..........................................175..........84........931..692.......................*..........
        .......860..........@..........400............235.....797.................*...............*...863................683/....778..367.79........
        ..................192.....%...........897..............*.....320*634......................32..............556...........................$...
        """

        assertEqual(input, [860, 192, 400, 797, 320, 634, 175, 84, 32, 683, 367, 79])
    }

    private func assertEqual(_ input: String, _ expectation: [Int], file: StaticString = #file, line: UInt = #line) {
        let result = findParts(input).reduce(into: [Int: Int]()) {
            $0[$1, default: 0] += 1
        }

        let expectation = expectation.reduce(into: [Int: Int]()) {
            $0[$1, default: 0] += 1
        }
        for (key, value) in expectation {
            if let found = result[key] {
                XCTAssertEqual(value, found, file: file, line: line)
            } else {
                XCTFail("Missing value: \(key) with count: \(value)", file: file, line: line)
            }
        }
    }
}
