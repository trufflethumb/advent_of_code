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

func diff(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Int {
    row[lhsIndex] - row[rhsIndex]
}

func isSafeByIncrement(_ isRowIncreasing: Bool, _ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Bool {
    isRowIncreasing == (diff(lhsIndex, rhsIndex, row) < 0)
}

func isSafeByDiff(_ lhsIndex: Int, _ rhsIndex: Int, _ row: [Int]) -> Bool {
    let maxDiff = 3
    let minDiff = 1
    let diff = row[lhsIndex] - row[rhsIndex]
    return (minDiff...maxDiff).contains(abs(diff))
}

func isSafeWithDamper(_ row: [Int]) -> Bool { false }
