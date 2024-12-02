import Foundation

func rows(_ input: String) -> [[Int]] {
    let lines = input.components(separatedBy: "\n")
    return lines.compactMap {
        if $0.isEmpty {
            return nil
        }
        return
            $0
            .components(separatedBy: " ")
            .compactMap(Int.init)
    }
}

func isSafe(_ row: [Int]) -> Bool {

    let rowTrend = trend(0, 1, row)

    for i in stride(from: 0, to: row.count - 1, by: 1) {
        if trend(i, i + 1, row) == rowTrend && isSafeByDiff(i, i + 1, row) {
            continue
        } else {
            return false
        }
    }
    return true
}

/// right - left
func diff(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Int {
    row[rhsIndex] - row[lhsIndex]
}

func trend(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> TrendDirection {
    switch (row[lhsIndex], row[rhsIndex]) {
    case let (x, y) where x < y:
        return .rising
    case let (x, y) where x > y:
        return .falling
    default:
        return .same
    }
}

func isSafeByDiff(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Bool {
    let maxDiff = 3
    let minDiff = 1
    let diff = row[lhsIndex] - row[rhsIndex]
    return (minDiff...maxDiff).contains(abs(diff))
}

enum TrendDirection {
    case rising, falling, same
}

func isSafeWithDamper(_ row: [Int]) -> Bool {
    var left = 0
    var right = 1
    var prevTrend: TrendDirection?
    var suspects = [Int]()
    var suspectIndex = -1

    while left <= right, right < row.count {
        guard right - left <= 2 else { return false }

        let currentTrend = trend(left, right, row)
        if currentTrend != .same, currentTrend == (prevTrend ?? currentTrend) {
            if isSafeByDiff(left, right, row) {
                prevTrend = currentTrend
                if suspects.isEmpty {
                    left += 1
                    right = left + 1
                } else {
                    left += 1
                    if left == suspects[suspectIndex] {
                        left += 1
                    }
                    right = left + 1
                    if right == suspects[suspectIndex] {
                        right += 1
                    }
                }
                continue
            }
        }

        if suspects.isEmpty {
            suspects = [left, right]
            if left - 1 >= 0 {
                suspects.insert(left - 1, at: 0)
            }
        }
        suspectIndex += 1

        if suspectIndex == suspects.count {
            return false
        }

        left = 0
        if left == suspects[suspectIndex] {
            left += 1
        }
        right = left + 1
        if right == suspects[suspectIndex] {
            right += 1
        }
        prevTrend = nil
    }

    return true
}
