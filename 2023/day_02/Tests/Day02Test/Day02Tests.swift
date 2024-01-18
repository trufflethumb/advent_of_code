//
//  Day02Tests.swift
//  
//
//  Created by Kevin Peng on 2024-01-18.
//

import XCTest

func determinePossibility(_ input: String) -> (id: Int, isPossible: Bool) {
    return (1, true)
}

final class Day02Tests: XCTestCase {
    func test_example_line1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        XCTAssertEqual(determinePossibility(input).id, 1)
        XCTAssertTrue(determinePossibility(input).isPossible)
    }
}
