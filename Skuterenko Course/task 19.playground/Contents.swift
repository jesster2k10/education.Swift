import Foundation

class Human {
    var name : String
    
    init(let name : String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name : "-")
    }
}

class Student : Human {
    var age : Int
    
    override init(name: String) {
        self.age = 10
        super.init(name: name)
    }
    convenience init(name: String, age : Int) {
        self.init(name: name)
        self.age = age
    }
    
}

class Man : Student {
    var cock : Bool
    
    override init(name: String) {
        self.cock = false
        super.init(name: name)
    }
    
    convenience init(name : String, age : Int, cock : Bool) {
        self.init(name : name)
        self.age = age
        self.cock = cock
    }
}


var s1 = Student(name: "zlobo", age: 25)
s1.name
s1.age

var m1 = Man(name: "lol", age: 12)
m1.name
m1.age

//------------------------------------------------------------------------------------

enum Color : Int {
    case Black
    case White
    
    init?(_ value : Int) {
        switch(value) {
        case 0: self = Black
        case 1: self = White
        default: return nil
        }
    }
}

let newColor = Color(1)
newColor
newColor!.rawValue



struct Size {
    var width : Int
    var height : Int
    
    init?(width : Int, height : Int) {
        self.height = height
        if height < 0 {
            return nil
        }
        self.width = width
    }
}


class Friend {
    //! name = nil when "!"
    var name : String!
    var skin : Color = {
        return Color(Int(arc4random_uniform(2)))
    }()!
    
    init?(name : String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    required init() {
        self.name = "Lol"
    }
    
    deinit {
        print("deinit friend")
    }
}

let f = Friend(name: "d")

class BestFriend : Friend {
    
    override init(name: String) {
        super.init(name: name)!
    }

    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        print("deinit bestfriend")
    }
}

f?.skin

let f2 = Friend(name: "23")
f2?.skin

let f3 = Friend(name: "233")
f3?.skin

let f4 = Friend(name: "32")
f4?.skin

let f5 = Friend(name: "2334")
f5?.skin

let f6 = Friend(name: "23d34")
f6?.skin

let bf1 = BestFriend(name: "rer")
bf1.skin


struct Test {
    var bestFriend : BestFriend? = BestFriend(name: "ere")
}

var test : Test? = Test()

test!.bestFriend = nil

















