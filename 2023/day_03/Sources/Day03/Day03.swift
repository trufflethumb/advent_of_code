import Foundation

public struct ParseResult {
    public let symbols: [Int]
    public let numbers: [Range<Int>: Int]
    public let width: Int
    public let endIndex: Int
}

public func parse(_ input: String) -> ParseResult {
    // Start by treating the input as a 1D array
    let input = Array(input)
    // Obtaining the width can help with going up or down without using a 2D array
    let width = if let lineWidth = input.firstIndex(of: "\n") {
        // Adding one here to account for the newline character
        lineWidth + 1
    } else {
        // if it's a one-liner, the count is the width since there is no newline character
        input.count
    }
    // A place to store the gears found, which are defined as adjacent to a symbol. The Range is the start and end indices of that number, and the value of the dictionary is the number of occurrences for that number.
    var numbers = [Range<Int>: Int]()
    // We don't count newline or periods as symbols, as per requirements
    let symbolExceptions = Set<Character>(["\n", "."])
    // Indices of the eligible symbols
    var symbols = [Int]()
    // a temp array to store the number we found, cleared when we see a non-number
    var currentNumbers = [Character]()

    // indicates where did the number start, if we found a number
    var currentNumberStart: Int?

    // walk through the input one character at a time
    for (index, char) in input.enumerated() {
        if char.isNumber {
            currentNumbers.append(char)
            // indicate the start of a number and where
            if currentNumberStart == nil {
                currentNumberStart = index
            }
        } else { // if we found a non-number
            // record the current temporary number
            if let numberStart = currentNumberStart {
                numbers[numberStart..<index] = Int(String(currentNumbers))
                // clear temps
                currentNumbers.removeAll()
                currentNumberStart = nil
            }
            // if we found an eligible symbol, record its index
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
        // check bounds
        guard (0 ..< endIndex).contains(searchIndex) else { continue }
        // check if the range of a number, aka gear, collides with the index of one of the eight adjacent positions of the symbol
        if range.contains(searchIndex) {
            // early return if it is adjacent.
            return true
        }
    }
    return false
}

// a gear ratio is defined as the multiple of two gears that are adjacent to an eligible symbol
public func findGearRatios(_ result: ParseResult) -> [Int] {
    var gearRatios = [Int]()
    symbolLoop: for symbol in result.symbols {
        // stores the number of adjacent gears for this symbol
        var intersections = 0
        // stores the current gear ratio
        var gearRatio = 1
        for (range, number) in result.numbers {
            if findIntersection(symbolIndex: symbol, range: range, width: result.width, endIndex: result.endIndex) {
                intersections += 1
                gearRatio *= number
            }
        }
        // only count it if it's exactly two gears found
        if intersections == 2 {
            gearRatios.append(gearRatio)
        }
    }
    return gearRatios
}

public func findSumOfParts(_ parts: [Int]) -> Int {
    parts.reduce(0, +)
}

public func findSumOfGearRatios(_ parts: [Int]) -> Int {
    parts.reduce(0, +)
}
