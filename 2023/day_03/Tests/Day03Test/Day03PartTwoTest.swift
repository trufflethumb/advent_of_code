//
//  Day03PartTwoTest.swift
//
//
//  Created by Kevin Peng on 2024-01-21.
//

import Day03
import XCTest

final class Day03PartTwoTest: XCTestCase {
    func test_partTwo() {
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
        XCTAssertEqual(
            findSumOfGearRatios(
                findGearRatios(
                    parse(
                        input
                    )
                )
            ),
            467835
        )
    }

    func test_partTwoWithThreeAdjacentNumbers_shouldNotCountThreeAdjacent() {
        let input = """
        467..114..
        ...*17....
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """
        XCTAssertEqual(
            findSumOfGearRatios(
                findGearRatios(
                    parse(
                        input
                    )
                )
            ),
            451490
        )
    }
}
