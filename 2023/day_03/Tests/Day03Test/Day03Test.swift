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
        XCTAssertEqual(sumParts(findParts(input)), 4361)
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
