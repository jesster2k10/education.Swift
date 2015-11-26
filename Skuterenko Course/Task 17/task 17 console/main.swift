import Foundation

let cell = "⬜️"
let xPoint = "❌"
let oPoint = "⭕️"

class Field {
    var size : Int
    
    var fieldArray : [[String]]
    
    func draw() {
        
        print(" ", terminator: "")
        for i in 1...size {
            if (i == size){
                print(" \(i)")
            } else {
                print(" \(i)", terminator: "")
            }
        }
        
        for i in 0..<fieldArray.count-1 {
            for j in 0..<fieldArray[i].count {
                print(fieldArray[i][j], terminator:"")
            }
        }
        
    }
    
    init (size : Int) {
        self.size = size
        fieldArray = Array(count: size+1, repeatedValue: Array(count: size+2, repeatedValue: cell))
        
        print(" ", terminator: "")
        for i in 1...size {
            if (i == size){
             print(" \(i)")
            } else {
            print(" \(i)", terminator: "")
            }
        }
        
        for i in 0..<fieldArray.count-1 {
            //print(i+1, terminator:"")
            for j in 0..<fieldArray[i].count {
                switch(i, j) {
                case(_,0):fieldArray[i][j] = String(i+1)
                case(_,size+1):fieldArray[i][j] = "\n"
                default:fieldArray[i][j] = cell
                }
                print(fieldArray[i][j], terminator:"")
            }
        }
        
    }
    
    subscript(x : Int, y : Int) -> String {
        get {
            return fieldArray[y-1][x]
        }
        set {
            if ((x > 0 && x <= size && y > 0 && y <= size) && (fieldArray[y-1][x] != xPoint) && (fieldArray[y-1][x] != oPoint)) {
                switch(newValue) {
                case(xPoint): fieldArray[y-1][x] = xPoint
                default: fieldArray[y-1][x] = oPoint
                }
                draw()
            }
            else {
                print("Point error")
            }
        }
    }
}
//Input from console func:
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
//----------------------------
func starting(game : Field) {
    var stopGame = true
    var figureCheck = true
    print("Start game, 'X' first!")
    while stopGame == true {
    print("Enter column:")
    let y = Int(input())!
    print("Enter line")
    let x = Int(input())!
    print("Enter figure:")
        switch(figureCheck) {
        case(true): game[y,x] = xPoint
                    figureCheck = false
        case(false): game[y,x] = oPoint
                    figureCheck = true
        }
        
        
        for i in 1...game.size {
            for j in 1...game.size {
                if (game[j,i] == xPoint && (game[j+1,i] == xPoint && game[j+2,i] == xPoint ||
                                            game[j,i+1] == xPoint && game[j,i+2] == xPoint ||
                                            game[j+1,i+1] == xPoint && game[j+2,i+2] == xPoint ||
                                            game[j-1,i+1] == xPoint && game[j-2,i+2] == xPoint)) {
                        print(xPoint + " wins!")
                        stopGame = false
                } else if (game[j,i] == oPoint && (game[j+1,i] == oPoint && game[j+2,i] == oPoint ||
                                                   game[j,i+1] == oPoint && game[j,i+2] == oPoint ||
                                                   game[j+1,i+1] == oPoint && game[j+2,i+2] == oPoint ||
                                                   game[j-1,i+1] == oPoint && game[j-2,i+2] == oPoint)) {
                        print(oPoint + " wins!")
                        stopGame = false
                }
    
            }
        }
    
    }
}

var game = Field(size: 3)
starting(game)

