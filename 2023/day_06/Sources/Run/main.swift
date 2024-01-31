import Day06
import Foundation

guard let input = Bundle.module.url(forResource: "input", withExtension: "txt") else {
    fatalError("Unable to find file")
}

let content = try String(contentsOf: input)

// Part 1
let parsedInput = parse(content)
let times = parsedInput.times.map(allDistances(timeLimit:))
let distances = parsedInput.distances
let answer = zip(times, distances)
    .map(waysToWin)
    .reduce(1, *)
print(answer)


// Part 2
