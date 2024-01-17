import Day01
import XCTest


final class Day01Tests: XCTestCase {
    func test_example_line1() {
        let input = "1abc2"
        XCTAssertEqual(getCalibration(input), 12)
    }
    
    func test_example_line2() {
        let input = "pqr3stu8vwx"
        XCTAssertEqual(getCalibration(input), 38)
    }

    func test_example_line3() {
        let input = "a1b2c3d4e5f"
        XCTAssertEqual(getCalibration(input), 15)
    }

    func test_example_line4() {
        let input = "treb7uchet"
        XCTAssertEqual(getCalibration(input), 77)
    }

    func test_exampleInput() {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """
        XCTAssertEqual(sumCalibrationDocumentValues(input), 142)
    }

    func test_examplePartTwo_line1() {
        let input = "two1nine"
        XCTAssertEqual(getCalibration(input), 29)
    }

    func test_examplePartTwo_line2() {
        let input = "eightwothree"
        XCTAssertEqual(getCalibration(input), 83)
    }
    
    func test_examplePartTwo_line3() {
        let input = "abcone2threexyz"
        XCTAssertEqual(getCalibration(input), 13)
    }

    func test_examplePartTwo_line4() {
        let input = "xtwone3four"
        XCTAssertEqual(getCalibration(input), 24)
    }

    func test_examplePartTwo_line5() {
        let input = "4nineeightseven2"
        XCTAssertEqual(getCalibration(input), 42)
    }

    func test_examplePartTwo_line6() {
        let input = "zoneight234"
        XCTAssertEqual(getCalibration(input), 14)
    }

    func test_examplePartTwo_line7() {
        let input = "7pqrstsixteen"
        XCTAssertEqual(getCalibration(input), 76)
    }

    func test_empty_shouldBe0() {
        let input = ""
        XCTAssertEqual(getCalibration(input), 0)
    }

    func test_exampleInputPartTwo() {
        let input = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """
        XCTAssertEqual(sumCalibrationDocumentValues(input), 281)
    }

    func test_randomTestCases() {
        XCTAssertEqual(getCalibration("cbcvd9"), 99)
        XCTAssertEqual(getCalibration("eight7vcmhfqznbccrvl4onehfqmjone1"), 81)
        XCTAssertEqual(getCalibration("342"), 32)
        XCTAssertEqual(getCalibration("x8"), 88)
        XCTAssertEqual(getCalibration("8x"), 88)
        XCTAssertEqual(getCalibration("ffour87fqrvqxqlqrrk"), 47)
        XCTAssertEqual(getCalibration("hfbcbhbxgzjqjspxlpnbppjsfcvqvkgxd22"), 22)
        XCTAssertEqual(getCalibration("two"), 22)
    }

    func test_randomTestCases2() {
        XCTAssertEqual(getCalibration("5eightwox"), 58)
        XCTAssertEqual(getCalibration("eightwo"), 88)
    }
}
