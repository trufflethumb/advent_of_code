import Day02
import XCTest

func minimumSet(_ input: String) -> (red: Int, green: Int, blue: Int) {
    let game = parseGame(input)
    return (game.reds, game.greens, game.blues)
}

final class MinimumSetTests: XCTestCase {
    func test_examplePartTwo_line1() {
        let input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
        XCTAssertEqual(minimumSet(input).red, 4)
        XCTAssertEqual(minimumSet(input).green, 2)
        XCTAssertEqual(minimumSet(input).blue, 6)
    }

    func test_examplePartTwo_line2() {
        let input = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
        XCTAssertEqual(minimumSet(input).red, 1)
        XCTAssertEqual(minimumSet(input).green, 3)
        XCTAssertEqual(minimumSet(input).blue, 4)
    }
    
    func test_examplePartTwo_line3() {
        let input = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
        XCTAssertEqual(minimumSet(input).red, 20)
        XCTAssertEqual(minimumSet(input).green, 13)
        XCTAssertEqual(minimumSet(input).blue, 6)
    }

    func test_examplePartTwo_line4() {
        let input = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
        XCTAssertEqual(minimumSet(input).red, 14)
        XCTAssertEqual(minimumSet(input).green, 3)
        XCTAssertEqual(minimumSet(input).blue, 15)
    }

    func test_examplePartTwo_line5() {
        let input = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
        XCTAssertEqual(minimumSet(input).red, 6)
        XCTAssertEqual(minimumSet(input).green, 3)
        XCTAssertEqual(minimumSet(input).blue, 2)
    }
}
