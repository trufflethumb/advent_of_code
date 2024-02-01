import Day06
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

func getAnswer(parser: (String) -> Input) {
    let parsedInput = parser(content)
    let answer = zip(parsedInput.times, parsedInput.distances)
        .map(waysToWin)
        .reduce(1, *)
    print(answer)
}

// Part 1, answer = 74698
//getAnswer(parser: parse)

// Part 2
getAnswer(parser: parseSingleRace)
