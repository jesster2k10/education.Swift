class Human {
    var name : String
    
    class var maxAge : Int {
        return 100
    }
    
    var age : Int {
        didSet {
            if age > Human.maxAge {
                age = oldValue
            }
        }
    }
    
    init (name : String, age : Int) {
        self.name = name
        self.age = age
    }
}

struct Cat {
    var name : String
    static let maxAge = 20
    static var totalCats = 0
    
    var age : Int {
        didSet {
            if age > Cat.maxAge {
                age = oldValue
            }
        }
    }
    init (name: String, age: Int) {
        self.name = name
        self.age = age
        
        Cat.totalCats++
    }
}

enum Direction {
    
    static let enumDescription = "Directions in the game"
    
    case Left
    case Right
    case Top
    case Bottom
}

Direction.enumDescription


let human = Human(name: "Peter", age: 40)
var cat = Cat(name: "Whiten", age: 10)

human.age = 1000
cat.age = 50

Cat.totalCats





