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
        XCTAssertEqual(makeSUT(input: input).id, 1)
        XCTAssertTrue(makeSUT(input: input).isPossible)
    }
    
    func test_example_line2() {
        let input = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
        XCTAssertEqual(makeSUT(input: input).id, 2)
        XCTAssertTrue(makeSUT(input: input).isPossible)
    }
    
    func test_example_line3() {
        let input = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
        XCTAssertEqual(makeSUT(input: input).id, 3)
        XCTAssertFalse(makeSUT(input: input).isPossible)
    }
    
    func test_example_line4() {
        let input = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
        XCTAssertEqual(makeSUT(input: input).id, 4)
        XCTAssertFalse(makeSUT(input: input).isPossible)
    }
    
    func test_example_line5() {
        let input = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
        XCTAssertEqual(makeSUT(input: input).id, 5)
        XCTAssertTrue(makeSUT(input: input).isPossible)
    }

    func test_example_sumOfIDs() {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """
        XCTAssertEqual(sumIDs(input), 8)
    }

    private func makeSUT(input: String) -> Game {
        parseGame(input)
    }
}
