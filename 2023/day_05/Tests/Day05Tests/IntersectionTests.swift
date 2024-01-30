import XCTest

struct Operation: Equatable {
    init(_ lower: Int, _ upper: Int, _ operation: Int) {
        self.lower = lower
        self.upper = upper
        self.operation = operation
    }
    
    let lower: Int
    let upper: Int
    let operation: Int
}

extension Operation: Comparable {
    static func < (lhs: Operation, rhs: Operation) -> Bool {
        lhs.lower < rhs.lower
    }
}

extension Operation: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Int...) {
        lower = elements[0]
        upper = elements[1]
        operation = elements[2]
    }
}

func intersect(_ initial: [Operation], _ new: Operation) -> [Operation] {
    var result: [Operation] = []
    for op in initial {
        let left = op.lower
        let right = op.upper
        let newLeft = new.lower
        let newRight = new.upper
        let initalOp = op.operation
        let newOp = new.operation
        let combined = initalOp + newOp

        // existing:    ----   
        // new:         ----
        let identical = left == newLeft && right == newRight
        // existing: ----------
        // new:         ----
        let contained = left < newLeft && right > newRight
        // existing:    ----
        // new:      ----------
        let antiContained = left > newLeft && right < newRight
        // existing: -------
        // new:         -------
        let leftIntersect = left < newLeft && right < newRight
        // existing:    -------
        // new:      -------
        let rightIntersect = left > newLeft && right > newRight

        if identical {
            result.append([left, right, combined])
        } else if contained {
            result.append([left, newLeft, initalOp])
            result.append([newLeft, newRight, newOp])
            result.append([newRight, right, initalOp])
        } else if antiContained {
            result.append([newLeft, left, newOp])
            result.append([left, right, combined])
            result.append([right, newRight, newOp])
        } else if leftIntersect {
            result.append([left, newLeft, initalOp])
            result.append([newLeft, right, combined])
            result.append([right, newRight, newOp])
        } else if rightIntersect {
            result.append([newLeft, left, newOp])
            result.append([left, newRight, combined])
            result.append([newRight, right, initalOp])
        }
    }
    return result
}

final class IntersectionTests: XCTestCase {
    func test_contained_1() {
        let initial: [Operation] = [[Int.min, Int.max, 0]]
        let sut = intersect(initial, [98, 100, -48])
        XCTAssertEqual(sut, [
            [Int.min, 98, 0],
            [98, 100, -48],
            [100, Int.max, 0]])
    }

    func test_contained_2() {
        let initial: [Operation] = [[Int.min, Int.max, 0]]
        let sut = intersect(initial, [97, 100, -48])
        XCTAssertEqual(sut, [
            [Int.min, 97, 0],
            [97, 100, -48],
            [100, Int.max, 0]])
    }

    func test_antiContained() {
        let initial: [Operation] = [[97, 100, 1]]
        let sut = intersect(initial, [Int.min, Int.max, 2])
        XCTAssertEqual(sut, [
            [Int.min, 97, 2],
            [97, 100, 3],
            [100, Int.max, 2]])
    }

    func test_leftIntersect() {
        let initial: [Operation] = [
            [Int.min, 200, 1],
        ]
        let sut = intersect(initial, [100, Int.max, 2])
        assert(sut, [
            [Int.min, 100, 1],
            [100, 200, 3],
            [200, Int.max, 2],
        ])
    }

    func test_rightIntersect() {
        let initial: [Operation] = [
            [100, Int.max, 2]
        ]
        let sut = intersect(initial, [Int.min, 200, 1])
        assert(sut, [
            [Int.min, 100, 1],
            [100, 200, 3],
            [200, Int.max, 2],
        ])
    }

    func test_identical() {
        let initial: [Operation] = [
            [100, Int.max, 2]
        ]
        let sut = intersect(initial, [100, Int.max, 1])
        assert(sut, [
            [100, Int.max, 3],
        ])
    }

    private func assert(_ sut: [Operation], _ expected: [Operation], file: StaticString = #file, line: UInt = #line) {
        let expected = expected.sorted()
        let sut = sut.sorted()
        for (index, exp) in expected.enumerated() {
            XCTAssertEqual(sut[index].lower, exp.lower, "Lowerbound for index \(index): \(sut[index].lower) != \(exp.lower)", file: file, line: line)
            XCTAssertEqual(sut[index].upper, exp.upper, "Upperbound for index \(index): \(sut[index].upper) != \(exp.upper)", file: file, line: line)
            XCTAssertEqual(sut[index].operation, exp.operation, "Operation for index \(index): \(sut[index].operation) != \(exp.operation)", file: file, line: line)
        }
        XCTAssertEqual(sut.count, expected.count, "Arrays are different sizes", file: file, line: line)
    }
}
