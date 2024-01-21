import Foundation

public struct ParseResult {
    public let symbols: [Int]
    public let numbers: [Range<Int>: Int]
    public let width: Int
    public let endIndex: Int
}

public func parse(_ input: String) -> ParseResult {
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
    return ParseResult(symbols: symbols, numbers: numbers, width: width, endIndex: input.endIndex)
}

public func findParts(_ input: String) -> [Int] {
    let result = parse(input)
    var parts = [Int]()

    for symbol in result.symbols {
        for (range, number) in result.numbers {
            if findIntersection(symbolIndex: symbol, range: range, width: result.width, endIndex: result.endIndex) {
                parts.append(number)
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

public func findSumOfParts(_ parts: [Int]) -> Int {
    parts.reduce(0, +)
}

public func findSumOfGearRatios(_ parts: [Int]) -> Int {
    parts.reduce(0, +)
}
