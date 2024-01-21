import Foundation

public func findParts(_ input: String) -> [Int: Int] {
    let input = Array(input)
    let width = if let lineWidth = input.firstIndex(of: "\n") {
        lineWidth + 1
    } else {
        input.count
    }
    var numbers = [Range<Int>: Int]()
    let symbolExceptions = Set<Character>(["\n", "."])
    var symbols = [Int]()
    var currentNumbers = [Character]()
    var currentNumberStart: Int?
    for (index, char) in input.enumerated() {
        if char.isNumber {
            currentNumbers.append(char)
            if currentNumberStart == nil {
                currentNumberStart = index
            }
        } else {
            if let numberStart = currentNumberStart {
                numbers[numberStart..<index] = Int(String(currentNumbers))
                currentNumbers.removeAll()
                currentNumberStart = nil
            }
            if !char.isNumber && !symbolExceptions.contains(char) {
                symbols.append(index)
            }
        }
    }

    var parts = [Int: Int]()

    for symbol in symbols {
        for (range, number) in numbers {
            if findIntersection(symbolIndex: symbol, range: range, width: width, endIndex: input.endIndex) {
                parts[number, default: 0] += 1
            }
        }
    }
    return parts
}

public func findIntersection(symbolIndex: Int, range: Range<Int>, width: Int, endIndex: Int) -> Bool {
    let searchIndices = [
        // top left
        symbolIndex - width - 1,
        // top mid
        symbolIndex - width,
        // top right
        symbolIndex - width + 1,
        // left
        symbolIndex - 1,
        // right
        symbolIndex + 1,
        // bot left
        symbolIndex + width - 1,
        // bot mid
        symbolIndex + width,
        // bot right
        symbolIndex + width + 1,
    ]
    for searchIndex in searchIndices {
        guard (0 ..< endIndex).contains(searchIndex) else { continue }
        if range.contains(searchIndex) {
            return true
        }
    }
    return false
}

public func findSumOfParts(_ parts: [Int: Int]) -> Int {
    parts.reduce(0) { result, dict in
        let (key, value) = dict
        return result + key * value
    }
}
