//
//  Day03Tests.swift
//
//
//  Created by Kevin Peng on 2024-01-19.
//

import Day03
import XCTest

func findParts(_ input: String) -> [Int] {
    let input = if let last = input.last, last != "\n" {
        Array(input) + ["\n"]
    } else {
        Array(input)
    }

    // find the width
    let width = input.firstIndex(of: "\n")!

    // find the *
    if let index = input.firstIndex(of: "*") {
        // go left by width
        var upDirectionIndex = input.index(index, offsetBy: -(width + 1))
        // go left until \n
        var result: [Character] = []
        while upDirectionIndex >= 0 {
            if input[upDirectionIndex].isNumber {
                result.insert(input[upDirectionIndex], at: 0)
            }
            upDirectionIndex -= 1
        }
        return [Int(String(result))!]
    }
    return []
}

final class Day03Tests: XCTestCase {
    func test_example_line1() {
        let input = "467..114.."
        XCTAssertEqual(findParts(input), [])
    }
    
    func test_example_line2() {
        let input = """
        467..114..
        ...*......
        """
        XCTAssertEqual(findParts(input), [467])
    }
}
