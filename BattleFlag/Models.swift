import SwiftUI

// Tile types for game elements
enum TileType: Int {
    case empty = 0
    case box = 1
    case flag = 2
    case target = 3
}

// Movement directions
enum MoveDirection: CaseIterable{
    case up, left, down, right
}

// Level data structure
struct Level {
    let id: Int
    let name: String
    let grid: [[Int]] // Initial board state
    let startPos: (row: Int, col: Int)
    let targetPos: (row: Int, col: Int)
    var minSteps: Int
    let checkOptimal: Bool
    let generateEasy: Bool         // true → easy random generation
    let generateMedium: Bool   // true → medium random generation
}

// Preset level data (approximately reconstructed from the original images)
// Note: coordinates (row, col) are 0-indexed, with (0,0) at the top-left
let levels: [Level] = [
    //Easy
    Level(
        id: 1,
        name: "Level 1 (Easy)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 2, 0, 0, 3, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (1, 1),
        targetPos: (1, 4),
        minSteps: 1,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 2,
        name: "Level 2 (Easy)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 2, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 3, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (1, 1),
        targetPos: (4, 4),
        minSteps: 2,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 3,
        name: "Level 3 (Easy)",
        grid: [
            [0, 0, 0, 0, 0, 1, 0, 0],
            [1, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 2, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 3, 1],
            [0, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (2, 2),
        targetPos: (4, 6),
        minSteps: 5,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 4,
        name: "Level 4 (Easy, Random)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (-1, -1),
        targetPos: (-1, -1),
        minSteps: -1,
        checkOptimal: false,
        generateEasy: true,
        generateMedium: false
    ),
    // Medium
    Level(
        id: 5,
        name: "Level 5 (Medium)",
        grid: [
            [0, 0, 0, 0, 0, 1, 0, 0],
            [0, 2, 0, 0, 0, 0, 0, 1],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 3, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 1],
            [0, 1, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (1, 1),
        targetPos: (4, 4),
        minSteps: 4,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 6,
        name: "Level 6 (Medium)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 2, 0, 0],
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 3, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0, 0, 0, 1]
        ],
        startPos: (1, 5),
        targetPos: (5, 1),
        minSteps: 6,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 7,
        name: "Level 7 (Medium)",
        grid: [
            [0, 1, 1, 0, 0, 0, 0, 1],
            [0, 0, 3, 0, 0, 0, 0, 0],
            [2, 0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 1, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (2, 0),
        targetPos: (1, 2),
        minSteps: 7,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 8,
        name: "Level 8 (Hard)",
        grid: [
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 3, 1, 0, 1, 0],
            [0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 2, 0, 0, 1, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 1, 0]
        ],
        startPos: (6, 1),
        targetPos: (1, 3),
        minSteps: 8,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 9,
        name: "Level 9 (Hard)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 1, 0, 0, 0, 2, 0, 0],
            [0, 0, 0, 3, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 1, 1, 0, 0, 0, 1, 0],
            [0, 0, 1, 0, 0, 0, 0, 0]
        ],
        startPos: (3, 5),
        targetPos: (4, 3),
        minSteps: 9,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 10,
        name: "Level 10 (Hard)",
        grid: [
            [0, 0, 0, 0, 0, 0, 1, 0],
            [0, 2, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 3, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 1, 0]
        ],
        startPos: (1, 1),
        targetPos: (5, 2),
        minSteps: 10,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: false
    ),
    Level(
        id: 11,
        name: "Level 11 (Hard, Random)",
        grid: [
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0]
        ],
        startPos: (-1, -1),
        targetPos: (-1, -1),
        minSteps: -1,
        checkOptimal: false,
        generateEasy: false,
        generateMedium: true
    )
]
