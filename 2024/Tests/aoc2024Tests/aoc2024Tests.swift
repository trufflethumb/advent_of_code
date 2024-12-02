import Testing

@testable import aoc2024

@Suite("Day01", .disabled()) struct Day01 {

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
        #expect(sum(input: try parse(1)) == 2_742_123)
    }

    @Test func part2() throws {
        #expect(simScore(input: input) == 31)
        #expect(simScore(input: try parse(1)) == 21_328_497)
    }
}

@Suite("Day02") struct Day02 {
    let input = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """

    @Test() func part1() throws {
        #expect(rows(input).count { row in
            isSafe(row)
        } == 2)

        print(rows(try parse(2)).count { row in
            isSafe(row)
        })
    }

    @Test(.disabled()) func part2() throws {
        #expect(isSafeWithDamper(rows(input)[3]) == true)
        #expect(isSafeWithDamper(rows(input)[1]) == false)
    }
}
