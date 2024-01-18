//
//  Day02Tests.swift
//  
//
//  Created by Kevin Peng on 2024-01-18.
//

import Day02
import XCTest

final class Day02Tests: XCTestCase {
    func test_example_line1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        XCTAssertEqual(determinePossibility(input).id, 1)
        XCTAssertTrue(determinePossibility(input).isPossible)
    }
    
    func test_example_line2() {
        let input = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
        XCTAssertEqual(determinePossibility(input).id, 2)
        XCTAssertTrue(determinePossibility(input).isPossible)
    }
    
    func test_example_line3() {
        let input = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
        XCTAssertEqual(determinePossibility(input).id, 3)
        XCTAssertFalse(determinePossibility(input).isPossible)
    }
    
    func test_example_line4() {
        let input = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
        XCTAssertEqual(determinePossibility(input).id, 4)
        XCTAssertFalse(determinePossibility(input).isPossible)
    }
    
    func test_example_line5() {
        let input = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
        XCTAssertEqual(determinePossibility(input).id, 5)
        XCTAssertTrue(determinePossibility(input).isPossible)
    }
}
