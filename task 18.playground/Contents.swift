class Artist {
    var firstName : String = ""
    var lastName : String = ""
    
    func Speech () {
        
    }
    
    init (let firstName : String, let lastName : String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Dancer : Artist {
    override func Speech() {
        print(super.firstName + " " + super.lastName + " " + "Dancer!")
    }
}

class Acrobat : Artist {
    override func Speech() {
        print(super.firstName + " " + super.lastName + " " + "Acrobat!")
    }
}

let zlobo = Dancer(firstName: "Dmitriy", lastName: "Rodygin")
let kekswar = Acrobat(firstName: "Ivan", lastName: "Bodnar")

let artistArray = [zlobo, kekswar]

for i in artistArray {
    i.Speech()
}



class TC {
    var speed : Int
    var capacity : Int
    final var cost : Int {
        return capacity * 30
    }
    
    init (speed : Int, capacity : Int) {
        self.speed = speed
        self.capacity = capacity
    }
    
}

class Car : TC {
    override var cost : Int {
        return capacity * 50
    }
}

var bmw = Car(speed: 120, capacity: 4)
bmw.cost

