//
//  File.swift
//  aoc2024
//
//  Created by Kevin Peng on 2024-12-02.
//

import Foundation

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
