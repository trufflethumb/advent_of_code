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

@Suite("Day03") struct Day03 {
    let input = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

    let input2 = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    func indices(_ input: String) -> [(Int, Int)] {
        let x = input.matches(of: /mul\((\d+),(\d+)\)/)
        var result = [(Int, Int)]()
        for i in x {
            guard let l = Int(i.1), let r = Int(i.2) else { continue }
            result.append((l, r))
        }
        return result
    }

    func indicesConditional(_ input: String) -> [(Int, Int)] {
        let input = "do()" + input + "don't()"
        let x = input.matches(of: /do\(\)((.|\n)*?)don't\(\)/)
        var result = [(Int, Int)]()
        for i in x {
            let found = String(i.1)
            print(found)
            result.append(contentsOf: indices(found))
        }
        return result
    }

    @Test(.disabled()) func part1() throws {
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
