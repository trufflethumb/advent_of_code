import Day07
import XCTest

extension Int: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard value.count == 1 else {
            fatalError("Invalid input")
        }

        switch value {
        case "A":
            self = 14
        case "K":
            self = 13
        case "Q":
            self = 12
        case "J":
            self = 11
        case "T":
            self = 10
        default:
            if let parsed = Int(value) {
                self = parsed
                return
            }
            fatalError("Invalid input")
        }
    }
}

struct Row {
    let hand: [Int]
    let bid: Int
}

struct PartOneInput {
    let rows: [Row]
}

func parsePartOne(_ input: String) -> PartOneInput {
    let components = input.components(separatedBy: .newlines)
    let rows = components
        .map { line in
            let parts = line.components(separatedBy: .whitespaces)
            let hands: [Int] = parts[0].map(String.init).map(Int.init)
            let bid = Int(parts[1])!
            return (hands, bid)
        }
        .map(Row.init)

    return PartOneInput(rows: rows)
}

final class Day07PartOneTest: XCTestCase {
    func test_examplePartOne_line1() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[0].hand, [3, 2, 10, 3, 13])
        XCTAssertEqual(sut.rows[0].bid, 765)
    }

    func test_examplePartOne_line2() {
        let sut = parsePartOne(example)
        XCTAssertEqual(sut.rows[1].hand, [10, 5, 5, "J", 5])
        XCTAssertEqual(sut.rows[1].bid, 684)
    }
}
