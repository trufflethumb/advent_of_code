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

@Suite("Day02", .disabled()) struct Day02 {
    let input = """
        7 6 4 2 1
        1 2 7 8 9
        9 7 6 2 1
        1 3 2 4 5
        8 6 4 4 1
        1 3 6 7 9
        """

    let goodOnes = """
        1 2 3 4 1
        5 1 2 3 4
        1 5 2 3 4
        1 2 5 3 4
        1 2 3 5 4
        1 2 3 4 5
        5 4 3 2 1 0
        5 4 3 2 1 1
        5 4 3 2 1 5
        1 5 4 3 2 1
        5 1 4 3 2 1
        5 4 1 3 2 1
        5 4 3 1 2 1
        5 4 3 2 1 1
        4 1 4 5 6
        """

    let badOnes = """
        4 3 3 1 2 3
        7 11 14 15 15 16 16
        20 16 13 10 5
        1 5 8 11 14 17 21
        5 3 5 3 5 3
        1 2 1 2
        5 5 1 2 3 4
        1 5 5 2 3 4
        1 2 5 5 3 4
        1 2 3 4 5 5 5
        5 5 5 5 5 5
        """

    @Test(.disabled()) func part1() throws {
        #expect(
            rows(input).count { row in
                isSafe(row)
            } == 2)

        #expect(
            rows(try parse(2)).count { row in
                isSafe(row)
            } == 356)
    }

    @Test() func part2() throws {
        #expect(
            rows(input).count { row in
                isSafeWithDamper(row)
            } == 4)

        #expect(
            rows(goodOnes).count { row in
                isSafeWithDamper(row)
            } == rows(goodOnes).count)

        #expect(
            rows(badOnes).count { row in
                isSafeWithDamper(row)
            } == 0)

        #expect(
            rows(try parse(2)).count { row in
                isSafeWithDamper(row)
            } == 413)
    }
}

@Suite("Day03", .disabled()) struct Day03 {
    let input = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

    let input2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    @Test() func part1() throws {
        #expect(indices(input)
            .reduce(0) { result, pair in
                result + pair.0 * pair.1
            } == 161)

        #expect(indices(try parse(3)).reduce(0) { result, pair in
            result + pair.0 * pair.1
        } == 168539636)
    }

    @Test func part2() throws {
        #expect(indicesConditional(input2)
            .reduce(0) { result, pair in
                result + pair.0 * pair.1
            } == 48)

        #expect(indicesConditional(try parse(3))
            .reduce(0) { result, pair in
                result + pair.0 * pair.1
            } == 97529391)
    }
}

@Suite("Day04", .disabled()) struct Day04 {
    let input = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    func parseBoard(_ input: String) -> [[Character]] {
        input
            .components(separatedBy: .newlines)
            .map { Array($0) }
    }

    @Test(.disabled()) func part1() throws {
        #expect(searchAllDirections(parseBoard(input)) == 18)
        #expect(searchAllDirections(parseBoard("XMAS")) == 1)
        #expect(searchAllDirections(parseBoard("SAMX")) == 1)
        #expect(searchAllDirections(parseBoard("SAMXMAS")) == 2)
        #expect(searchAllDirections(parseBoard("SAMXMAS\nSAMXMAS")) == 4)
        let verticalTest = """
        S
        A
        M
        X
        M
        A
        S
        """
        #expect(searchAllDirections(parseBoard(verticalTest)) == 2)
        #expect(searchAllDirections(parseBoard(try parse(4))) == 2543)
    }

    @Test(.disabled()) func part2() throws {
        #expect(searchXMASes(parseBoard(input)) == 9)
        let one = """
        M.S
        .A.
        M.S
        """
        #expect(searchXMASes(parseBoard(one)) == 1)
        #expect(searchXMASes(parseBoard(try parse(4))) == 1930)
    }
}

@Suite("Day05", .disabled()) struct Day05 {
    let input = """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """

    @Test(.disabled()) func part1() throws {
        let (dict, updates) = parseManual(input)

        #expect(isUpdateValid(updates[0], dict) == true)
        #expect(isUpdateValid(updates[1], dict) == true)
        #expect(isUpdateValid(updates[2], dict) == true)
        #expect(isUpdateValid(updates[3], dict) == false)
        #expect(isUpdateValid(updates[4], dict) == false)
        #expect(isUpdateValid(updates[5], dict) == false)

        #expect(sumOfValidMiddleNumbers(dict, updates) == 143)

        let (aDict, aUpdates) = parseManual(try parse(5))
        #expect(sumOfValidMiddleNumbers(aDict, aUpdates) == 4281)
    }

    @Test func part2() throws {
        let (dict, updates) = parseManual(input)
        #expect(fixIssues(updates[3], dict) == [97,75,47,61,53])
        #expect(fixIssues(updates[4], dict) == [61,29,13])
        #expect(fixIssues(updates[5], dict) == [97,75,47,29,13])

        #expect(isUpdateValid(fixIssues(updates[0], dict), dict) == true)
        #expect(isUpdateValid(fixIssues(updates[1], dict), dict) == true)
        #expect(isUpdateValid(fixIssues(updates[2], dict), dict) == true)
        #expect(isUpdateValid(fixIssues(updates[3], dict), dict) == true)
        #expect(isUpdateValid(fixIssues(updates[4], dict), dict) == true)
        #expect(isUpdateValid(fixIssues(updates[5], dict), dict) == true)

        #expect(sumOfFixedMiddleNumbers(dict, updates) == 123)

        let (aDict, aUpdates) = parseManual(try parse(5))
        #expect(sumOfFixedMiddleNumbers(aDict, aUpdates) == 5466)
    }
}

@Suite("Day06") struct Day06 {

    let input = """
    ....#.....
    .........#
    ..........
    ..#.......
    .......#..
    ..........
    .#..^.....
    ........#.
    #.........
    ......#...
    """

    @Test(.disabled()) func part1() throws {
        #expect(walkAll(input) == 41)
        #expect(walkAll(try parse(6)) == 5551)

        let edgeCase = """
        .#.
        .^#
        ...
        """
        #expect(walkAll(edgeCase) == 2)
    }
}

@Suite("Day10", .disabled()) struct Day10 {
    let input1 = """
    ...0...
    ...1...
    ...2...
    6543456
    7.....7
    8.....8
    9.....9
    """

    let input2 = """
    ..90..9
    ...1.98
    ...2..7
    6543456
    765.987
    876....
    987....
    """

    @Test func part1() throws {
        #expect(findScoreOfUniqueTrails(parseMountain(input1)) == 2)
        #expect(findScoreOfUniqueTrails(parseMountain(input2)) == 4)
        #expect(findScoreOfUniqueTrails(parseMountain(try parse(10))) == 593)
    }

    @Test func part2() throws {
        #expect(findScoreOfAllTrails(parseMountain(try parse(10))) == 1192)
    }
}
