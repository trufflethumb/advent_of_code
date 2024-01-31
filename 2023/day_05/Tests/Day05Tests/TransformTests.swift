import Day05
import XCTest

final class TransformTests: XCTestCase {
    func test_initial_seed1() {
        let initial = [79, 92]
        let map = [98, 100, -48]
        let sut = transform(initial, map)
        XCTAssertEqual(sut.unmodified, [[79, 92]])
        XCTAssertEqual(sut.modified, [])
    }

    func test_initial_seed2() {
        let initial = [55, 67]
        let map = [53, 61, -4]
        let sut = transform(initial, map)
        XCTAssertEqual(sut.unmodified, [[61, 67]])
        XCTAssertEqual(sut.modified, [[55 - 4, 61 - 4]])
    }

    func test_contained_1() {
        let initial = [0, 100]
        let sut = transform(initial, [50, 60, -1])
        XCTAssertEqual(sut.unmodified, [[0, 50], [60, 100]])
        XCTAssertEqual(sut.modified, [[50 - 1, 60 - 1]])
    }

    func test_antiContained() {
        let initial = [50, 60]
        let sut = transform(initial, [0, 100, -1])
        XCTAssertEqual(sut.unmodified, [])
        XCTAssertEqual(sut.modified, [[50 - 1, 60 - 1]])
    }

    // existing: -------
    // new:         -------
    func test_leftIntersect() {
        let initial = [0, 60]
        let sut = transform(initial, [50, 100, -1])
        XCTAssertEqual(sut.unmodified, [[0, 50]])
        XCTAssertEqual(sut.modified, [[50 - 1, 60 - 1]])
    }

    // existing:    -------
    // new:      -------
    func test_rightIntersect() {
        let initial = [50, 100]
        let sut = transform(initial, [0, 60, -1])
        XCTAssertEqual(sut.unmodified, [[60, 100]])
        XCTAssertEqual(sut.modified, [[50 - 1, 60 - 1]])
    }

    func test_identical() {
        let initial = [0, 100]
        let sut = transform(initial, [0, 100, -1])
        XCTAssertEqual(sut.unmodified, [])
        XCTAssertEqual(sut.modified, [[0 - 1, 100 - 1]])
    }

    // existing:     ------
    // new:      ----
    func test_leftMiss() {
        let initial = [0, 50]
        let sut = transform(initial, [51, 100, -1])
        XCTAssertEqual(sut.unmodified, [initial])
        XCTAssertEqual(sut.modified, [])
    }

    // existing: ----
    // new:          ------
    func test_rightMiss() {
        let initial = [0, 50]
        let sut = transform(initial, [60, 100, -1])
        XCTAssertEqual(sut.unmodified, [initial])
        XCTAssertEqual(sut.modified, [])
    }

    // existing: ----------
    // new:         -------
    func test_leftIntersectIdenticalRightBound() {
        let initial = [0, 60]
        let sut = transform(initial, [50, 60, -1])
        XCTAssertEqual(sut.unmodified, [[0, 50]])
        XCTAssertEqual(sut.modified, [[50 - 1, 60 - 1]])
    }

    // existing: ----------
    // new:      -------
    func test_rightIntersectIdenticalLeftBound() {
        let initial = [0, 60]
        let sut = transform(initial, [0, 50, -1])
        XCTAssertEqual(sut.unmodified, [[50, 60]])
        XCTAssertEqual(sut.modified, [[0 - 1, 50 - 1]])
    }

    // existing: -----
    // new:          ------
    func test_leftIntersect_identicalInnerBounds_shouldBeRightMiss() {
        let initial = [0, 50]
        let sut = transform(initial, [50, 100, -1])
        XCTAssertEqual(sut.unmodified, [[0, 50]])
        XCTAssertEqual(sut.modified, [])
    }

    // existing:     ------
    // new:      -----
    func test_rightIntersect_identicalInnerBounds_shouldBeLeftMiss() {
        let initial = [50, 100]
        let sut = transform(initial, [0, 50, -1])
        XCTAssertEqual(sut.unmodified, [[50, 100]])
        XCTAssertEqual(sut.modified, [])
    }
    
    // existing:    ------
    // new:      ---------
    func test_contains_identicalRightBounds() {
        let initial = [74, 77]
        let sut = transform(initial, [64, 77, -1])
        XCTAssertEqual(sut.unmodified, [])
        XCTAssertEqual(sut.modified, [[74 - 1, 77 - 1]])
    }

    // existing: ------   
    // new:      ---------
    func test_contains_identicalLeftBounds() {
        let initial = [74, 77]
        let sut = transform(initial, [74, 87, -1])
        XCTAssertEqual(sut.unmodified, [])
        XCTAssertEqual(sut.modified, [[74 - 1, 77 - 1]])
    }
}
