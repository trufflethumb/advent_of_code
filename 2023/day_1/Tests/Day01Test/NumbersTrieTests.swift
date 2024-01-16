import Day01
import XCTest

final class NumbersTrieTests: XCTestCase {
    func test_shouldContainOne() {
        XCTAssertTrue(NumbersTrie.contains("one"))
    }

    func test_shouldNotContainFiftySix() {
        XCTAssertFalse(NumbersTrie.contains("fiftysix"))
    }
}
