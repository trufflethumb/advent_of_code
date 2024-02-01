import Day07
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
func partOne() {
    let parsedInput = parsePartOne(content)
    let answer = parsedInput.rows
        .sorted()
        .enumerated()
        .reduce(0) { current, enumeration in
            let (index, row) = enumeration
            return current + (index + 1) * row.bid
        }
    print(answer)
}

// Part 2
func partTwo() {

}
