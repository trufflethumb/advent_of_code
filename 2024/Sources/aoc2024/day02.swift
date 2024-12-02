import Foundation

func rows(_ input: String) -> [[Int]] {
    let lines = input.components(separatedBy: "\n")
    return lines.map { $0.components(separatedBy: " ").compactMap(Int.init) }
}

func isSafe(_ row: [Int]) -> Bool {

    let isIncreasing = row[0] < row[1]

    for i in stride(from: 0, to: row.count - 1, by: 1) {
        if isSafeByIncrement(isIncreasing, i, i + 1, row) && isSafeByDiff(i, i + 1, row) {
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

func isSafeByIncrement(_ isRowIncreasing: Bool, _ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Bool {
    isRowIncreasing == (diff(lhsIndex, rhsIndex, row) > 0)
}

func isSafeByDiff(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Bool {
    let maxDiff = 3
    let minDiff = 1
    let diff = row[lhsIndex] - row[rhsIndex]
    return (minDiff...maxDiff).contains(abs(diff))
}

func isSafeWithDamper(_ row: [Int]) -> Bool {
    var left = 0
    var right = 1
    var rowIncreasing: Bool?
    var suspects = [Int]()
    var suspectIndex = -1

    while left <= right, right < row.count {
        guard right - left <= 2 else { return false }

        let curDiff = diff(left, right, row)
        let isIncreasing = curDiff > 0
        if isSafeByIncrement(rowIncreasing ?? isIncreasing, left, right, row) {
            if isSafeByDiff(left, right, row) {
                if suspects.isEmpty {
                    left += 1
                    right = left + 1
                    rowIncreasing = isIncreasing
                } else {
                    left += 1
                    if left == suspects[suspectIndex] {
                        left += 1
                    }
                    right = left + 1
                    if right == suspects[suspectIndex] {
                        right += 1
                    }
                    rowIncreasing = isIncreasing
                }
                continue
            }
        }

        if suspects.isEmpty {
            suspects = [left, right]
        }
        suspectIndex += 1

        if suspectIndex == 2 {
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
        rowIncreasing = nil
    }

    return true
}
