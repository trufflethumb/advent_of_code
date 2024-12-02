import Foundation

func rows(_ input: String) -> [[Int]] {
    let lines = input.components(separatedBy: "\n")
    return lines.map { $0.components(separatedBy: " ").compactMap(Int.init) }
}

func isSafe(_ row: [Int]) -> Bool {

    let isIncreasing = row[0] < row[1]
    let maxDiff = 3
    let minDiff = 1

    for i in stride(from: 0, to: row.count - 1, by: 1) {
        if (minDiff...maxDiff).contains(abs(row[i] - row[i + 1])) && ((row[i] < row[i + 1]) == isIncreasing){
            continue
        } else {
            return false
        }
    }
    return true
}