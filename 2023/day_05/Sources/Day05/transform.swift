import Foundation

public func transform(_ initial: [Int], _ map: [Int]) -> (modified: [[Int]], unmodified: [[Int]]) {
    let left = initial[0]
    let right = initial[1]
    let newLeft = map[0]
    let newRight = map[1]
    let op = map[2]

    var modified = [[Int]]()
    var unmodified = [[Int]]()
    // existing:    ----
    // new:         ----
    let identical = left == newLeft && right == newRight
    // existing: ----------
    // new:      ???----???
    let contained = left <= newLeft && right >= newRight
    // existing: ???----???
    // new:      ----------
    let antiContained = left >= newLeft && right <= newRight
    // existing:     ------
    // new:      ----?
    let leftMiss = left >= newRight
    // existing: ----?
    // new:          ------
    let rightMiss = right <= newLeft
    // existing: -------???
    // new:         -------
    let leftIntersect = left < newLeft && right <= newRight
    // existing: ???-------
    // new:      -------
    let rightIntersect = left >= newLeft && right > newRight

    if identical {
        modified.append([left + op, right + op])
    }

    else if leftMiss || rightMiss {
        unmodified.append(initial)
    } 

    else if contained {
        // existing: ----------
        // new:         ----
        if left < newLeft && right > newRight {
            unmodified.append([left, newLeft])
            modified.append([newLeft + op, newRight + op])
            unmodified.append([newRight, right])
        }
        // existing: ----------
        // new:      -------
        else if left == newLeft && right > newRight {
            modified.append([newLeft + op, newRight + op])
            unmodified.append([newRight, right])
        }
        // existing: ----------
        // new:         -------
        else if left < newLeft && right == newRight {
            unmodified.append([left, newLeft])
            modified.append([newLeft + op, newRight + op])
        }
    } 

    else if antiContained {
        // existing: ???----???
        // new:      ----------
        modified.append([left + op, right + op])
    }

    // existing: -------???
    // new:         -------
    else if leftIntersect {
        // existing: -------
        // new:          ------
        unmodified.append([left, newLeft])
        modified.append([newLeft + op, right + op])
    }

    // existing: ???-------
    // new:      -------
    else if rightIntersect {
        // existing:    -------
        // new:      -------
        modified.append([left + op, newRight + op])
        unmodified.append([newRight, right])
    }
    return (modified, unmodified)
}
