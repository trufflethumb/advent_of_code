//
//  TriesTests.swift
//  
//
//  Created by Kevin Peng on 2024-01-16.
//

import Day01
import XCTest

final class TriesTests: XCTestCase {

    func test_add_shouldAddOneCharacter() {
        let sut = TrieNode(value: Character("a"))
        sut.add(string: "b")
        XCTAssertEqual(sut.children.count, 1)
        XCTAssertEqual(sut.description, "ab")
    }

    func test_contains_shouldContainTwoWords() {
        let sut = TrieNode(value: Character("a"))
        sut.add(string: "bc")
        sut.add(string: "cd")
        XCTAssertEqual(sut.children.count, 2)
        XCTAssert(sut.contains(string: "abc"))
        XCTAssert(sut.contains(string: "acd"))
    }

    func test_contains_shouldContainSubstring() {
        let sut = TrieNode(string: "abcde")
        XCTAssertEqual(sut.children.count, 1)
        XCTAssert(sut.contains(string: "abc"))
    }

    func test_contains_shouldNotContainNonSubstring() {
        let sut = TrieNode(string: "abcde")
        XCTAssertFalse(sut.contains(string: "abce"))
    }

    func test_contains_containsOneValue() {
        let sut = TrieNode(value: Character("a"))
        XCTAssertEqual(sut.description, "a")
        XCTAssert(sut.contains(string: "a"))
    }
}
