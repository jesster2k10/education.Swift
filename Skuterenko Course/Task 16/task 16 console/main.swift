import Foundation

let wall  = "⬛️"
let floor = "⬜️"
let cage = "🔵"
let humanChar = "🐔"
let winChar = "⭕️"

enum Move {
    case Left
    case Right
    case Up
    case Down
}

class Room {
    let weight : Int
    let height : Int
    
    var roomArray : Array<Array<String>>
    
    func draw (human : Human, box : Box) {
        let x = self.weight - 1
        let y = self.height - 1
        
        for i in 0...y {
            for j in 0...x {
                switch (i, j) {
                case (y-2,x-1): roomArray[i][j] = winChar
                case (human.y,human.x): roomArray[i][j] = humanChar
                case (box.y, box.x): roomArray[i][j] = cage
                case (0...y, 0): roomArray[i][j] = wall
                case (0...y, x): roomArray[i][j] = wall + "\n"
                case (0, 0...x): roomArray[i][j] = wall
                case (y, 0...x): roomArray[i][j] = wall
                default: roomArray[i][j] = floor
                }
                print(roomArray[i][j], terminator: "")
            }
        }
    }
    
    init (weight : Int, height : Int) {
        self.weight = weight
        self.height = height
        roomArray = Array(count: self.height, repeatedValue: Array(count: self.weight, repeatedValue: ""))
    }
}

class Human {
    var x : Int
    var y : Int
    
    func move(turn : Move, room : Room) {
        switch (turn) {
        case(.Up) where y > 1 && (room.roomArray[y-1][x] == floor || room.roomArray[y-2][x] != wall): y -= 1
        case(.Down) where y < room.height-2 && (room.roomArray[y+1][x] == floor || room.roomArray[y+2][x] != wall): y += 1
        case(.Right) where x < room.weight-2 && (room.roomArray[y][x+1] == floor || room.roomArray[y][x+2] != wall + "\n"): x += 1
        case(.Left) where x > 1 && (room.roomArray[y][x-1] == floor || room.roomArray[y][x-2] != wall): x -= 1
        default: break
        }
    }
    
    init () {
        self.x = 1
        self.y = 1
    }
    
    init ( x : Int, y : Int) {
        if (x > 0 && y > 0) {
            self.x = x
            self.y = y
        }
        else {
            self.x = 1
            self.y = 1
        }
    }
}

struct Box {
    var x : Int
    var y : Int
    
    mutating func move(turn : Move, room : Room) {
        switch (turn) {
        case(.Up) where y > 1: y -= 1
        case(.Down) where y < room.height-2: y += 1
        case(.Right) where x < room.weight-2: x += 1
        case(.Left) where x > 1: x -= 1
        default: break
        }
    }
}

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let rawString = NSString(data: inputData, encoding:NSUTF8StringEncoding)
    if let string = rawString {
        return string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    } else {
        return "Invalid input"
    }
}

func play (level : Room, man : Human , var box : Box) {
    print("Move: w - Up, s - Down, a - Left, d - Right, e - Exit\n")
    
    var i = true
    while i == true {
        level.draw(man, box: box)
        let j = input()
    
        switch(j) {
        case("w"): man.move(.Up, room: level)
        case("a"): man.move(.Left, room: level)
        case("s"): man.move(.Down, room: level)
        case("d"): man.move(.Right, room: level)
        case("e"): i = false
        default: break
        }
        if (box.x == man.x && box.y == man.y) {
            switch(j) {
            case("w"): box.move(.Up, room: level)
            case("a"): box.move(.Left, room: level)
            case("s"): box.move(.Down, room: level)
            case("d"): box.move(.Right, room: level)
            default: break
            }
        }
        if (level.roomArray[box.y][box.x] == winChar) {
            level.draw(man, box: box)
            print("You win!")
            i = false
        }
    }
}

let level = Room(weight: 9, height: 7)
let human = Human(x: level.weight / 2, y: level.height / 2)
let box = Box(x: 2, y: 3)

play(level, man: human , box: box)







