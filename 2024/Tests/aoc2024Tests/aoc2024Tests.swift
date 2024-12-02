import Testing
@testable import aoc2024

@Suite("Day01") struct Day01 {

let input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

@Test func part1() throws {
    #expect(sum(input: input) == 11)
    #expect(sum(input: try parse(1)) == 2742123)
}

@Test func part2() throws {
    #expect(simScore(input: input) == 31)
    #expect(simScore(input: try parse()) == 21328497)
}
}