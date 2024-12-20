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

    static let input = """
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
        #expect(try walkAll(Day06.input) == 41)
        #expect(try walkAll(try parse(6)) == 5551)

        let edgeCase = """
        .#.
        .^#
        ...
        """
        #expect(try walkAll(edgeCase) == 2)
    }

    @Suite("Day06Part2") struct Day06Part2 {

        @Test() func testDetectLoop() throws {
            let loop = """
            ....#.....
            ......#..#
            ..........
            ..#.......
            .......#..
            ..........
            .#.#^.....
            .....#..#.
            #.........
            ......#...
            """

            let (field, (row, col)) = try parseField(loop)
            #expect(detectLoop(field, row, col, startDir: 0))
        }

        @Test() func detectFalseLoop() throws {
            let (field, (row, col)) = try parseField(Day06.input)
            #expect(detectLoop(field, row, col, startDir: 0) == false)
        }

        @Test() func countLoopsInExample() throws {
            let (field, (row, col)) = try parseField(Day06.input)
            #expect(countAllLoops(field, row, col) == 6)
        }

        @Test() func part2() throws {
            let (aField, (aRow, aCol)) = try parseField(try parse(6))
            let loops = countAllLoops(aField, aRow, aCol)
            #expect(loops > 856)
            #expect(loops < 2171)
        }
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

@Suite("Day09", .disabled()) struct Day09 {

    @Suite("Day09Part1", .disabled()) struct Day09Part1 {
        @Test func testExpandBlocks() {
            let input = "12345"
            let exp = "0..111....22222"
            #expect(expandBlocks(parseDisk(input)) == parseExpanded(exp))
        }

        @Test func testExpandBlocks2() {
            let input = "2333133121414131402"
            let exp = "00...111...2...333.44.5555.6666.777.888899"
            #expect(expandBlocks(parseDisk(input)) == parseExpanded(exp))
        }

        @Test func testDefrag() {
            let input = "0..111....22222"
            let exp = "022111222......"
            #expect(defrag(parseExpanded(input)) == parseExpanded(exp))
        }

        @Test func testDefrag2() {
            let input = "00...111...2...333.44.5555.6666.777.888899"
            let exp = "0099811188827773336446555566.............."
            #expect(defrag(parseExpanded(input)) == parseExpanded(exp))
        }

        @Test func testChecksum() {
            let input = "0099811188827773336446555566.............."
            let exp = 1928
            #expect(checksum(parseExpanded(input)) == exp)
        }

        @Test func testChecksum2() {
            let input = "00992111777.44.333....5555.6666.....8888.."
            let exp = 2858
            #expect(checksum(parseExpanded(input)) == exp)
        }

        @Test func part1() throws {
            // expand blocks
            let expandedBlocks = expandBlocks(parseDisk(try parse(9)))

            // defrag
            let defraged = defrag(expandedBlocks)

            // checksum
            #expect(checksum(defraged) == 6242766523059)
        }
    }

    @Suite("Day09Part2") struct Day09Part2 {
        let input = "2333133121414131402"

        @Test func part2Example1() {
            let disk = parseDisk("123324212")
            let expandedBlocks = expandBlocks(disk)
            // 0..111...22....33.44
            let expected = "04411133.22........."
            let result = moveWholeFile(disk, expandedBlocks)
            let comment = Comment(stringLiteral: "\n" + debugInfo(result) + "\n" + expected)
            if result != parseExpanded(expected) {
                Issue.record(comment)
            }
        }

        @Test() func part2Example2() {
            let disk = parseDisk(input)
            let expandedBlocks = expandBlocks(disk)
            let result = moveWholeFile(disk, expandedBlocks)
            let expected = "00992111777.44.333....5555.6666.....8888.."
            let comment = Comment(stringLiteral: "\n" + debugInfo(result) + "\n" + expected)
            if result != parseExpanded(expected) {
                Issue.record(comment)
            }
            #expect(checksum(result) == 2858)
        }

        @Test() func part2Example3() {
            let disk = parseDisk("233242302020101")
            let expandedBlocks = expandBlocks(disk)
            let result = moveWholeFile(disk, expandedBlocks)
            let expected = "0076.11155222244333......"
            let comment = Comment(stringLiteral: "\n" + debugInfo(result) + "\n" + expected)
            if result != parseExpanded(expected) {
                Issue.record(comment)
            }
        }

        @Test() func part2Example4() {
            let disk = parseDisk("23311010101")
            let expandedBlocks = expandBlocks(disk)
            let result = moveWholeFile(disk, expandedBlocks)
            let expected = "005431112...."
            let comment = Comment(stringLiteral: "\n" + debugInfo(result) + "\n" + expected)
            if result != parseExpanded(expected) {
                Issue.record(comment)
            }
        }

        @Test(.disabled("This test runs for 6.4 seconds on an M2 Pro")) func part2() throws {
            let disk = parseDisk(try parse(9))
            let expandedBlocks = expandBlocks(disk)
            let result = moveWholeFile(disk, expandedBlocks)
            let checksum = checksum(result)
            #expect(checksum == 6272188244509)
        }

        // This is for a function that didn't make it to the final solution
        @Test func testMakeConversionTable() {
            let input = "123456"
            // "0..111....22222......"
            let exp = [0, 1, 3, 6, 10, 15]
            #expect(makeConversionTable(parseDisk(input)) == exp)
        }
    }
}

@Suite("Day19") struct Day19 {

    class Node: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
        static func == (lhs: Day19.Node, rhs: Day19.Node) -> Bool {
            lhs.value == rhs.value
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }

        var value: Character
        var children: Set<Node> = []

        init(value: Character) {
            self.value = value
        }

        func child(_ value: Character) -> Node? {
            children.first { node in
                node.value == value
            }
        }

        var description: String {
            String(value)
        }

        var debugDescription: String {
            description
        }
    }

    func treeString(_ node: Node, prefix: String = "") -> String {
        // Start with the current node's description
        var result = "\(prefix)\(node.description)\n"

        // Recur for each child, adding to the result
        for child in node.children {
            result += treeString(child, prefix: prefix + "   ")
        }
        return result
    }

    func makeDict(_ towels: [[Character]]) -> [Character: Node] {
        var result = [Character: Node]()

        for towel in towels {
            let head: Node? = result[towel[0], default: Node(value: towel[0])]
            var node = head
            for i in 1 ..< towel.count {
                node?.children.insert(Node(value: towel[i]))
                node = node?.child(towel[i])
            }
            node?.children.insert(Node(value: "."))
            result[towel[0]] = head
        }

        return result
    }

    func parseTowels(_ input: String) -> (towels: [[Character]], designs: [[Character]]) {
        let lines = input.components(separatedBy: .newlines)
        let towels = lines[0].components(separatedBy: ", ").map(Array.init)
        let designs = lines.dropFirst(2).map(Array.init)
        return (towels, designs)
    }

    func processLine(_ line: [Character], _ towels: [Character: Node]) -> Bool {
        var i = 0
        while i < line.count - 1 {
            if let char = towels[line[i]] {
                var j = i + 1
                var child: Node? = char

                while j < line.count {
                    if let nextChild = child?.child(line[j]) {
                        child = nextChild
                    } else if child?.child(".") != nil {
                        break
                    } else {
                        return false
                    }
                    j += 1
                }
                i = j
            } else {
                return false
            }
        }

        return true
    }

    let input = """
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

    @Test func testParse() {
        let (towels, _) = parseTowels(input)
        let joined = String(towels.joined(separator: ", "))
        #expect(joined == "r, wr, b, g, bwu, rb, gb, br")
    }

    @Test func testMakeDict() {
        let (towels, _) = parseTowels(input)
        let towelDict = makeDict(towels)
        for (_, v) in towelDict {
            print(treeString(v))
        }
    }

    @Test func testProcessLine() throws {
        let (towels, designs) = parseTowels(input)
        let towelDict = makeDict(towels)
        #expect(processLine(designs[5], towelDict))
        #expect(processLine(designs[7], towelDict) == false)
        #expect(processLine(designs[0], towelDict))
        #expect(processLine(designs[1], towelDict))
        #expect(processLine(designs[2], towelDict))
        #expect(processLine(designs[3], towelDict))
        #expect(processLine(designs[4], towelDict) == false)
        #expect(processLine(designs[6], towelDict))
    }
}
