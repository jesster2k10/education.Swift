var playground = true

class Student {
    
    weak var teacher : Teacher?
    //unowned if type not optional
    
    deinit {
        print("goodbye student")
    }
}

class Teacher {
    
    var student : Student?
    
    deinit {
        print("goodbye teacher")
    }
}

if playground {
    
    var teacher = Teacher()
    
    if playground {
        var student = Student()
        teacher.student = student
        student.teacher = teacher
    }
    
    
    print("exit playground")
}

print("end")






var x = 10
var y = 20

class Human {
    var name = "a"
}

var h = Human()

var closure : () -> () = {
    [x] in
    print("\(x) \(y)")
}

var closure2 : (Int) -> (Int) = {[x,y,h] (a: Int) -> Int in
    print("\(x) \(y) \(h.name)")

    return a
}


closure2(1)

x = 30
y = 40
h = Human()
h.name = "b"

closure2(1)
//---------------------------------------------------------------------------------------------

class Family {
    
    deinit {
        print("Family end")
    }
}

class Father : Family {
    deinit {
        print("Father end")
    }
}

class Mother : Father {
    deinit {
        print("Mother end")
    }
}

class Children : Mother {
    
    var name : String
    
    func speak(children : Children) {
        print("\(self.name) say \(children.name): give me a toy")
    }
    func speakWithMother(mother : Mother) {
        print("Momy momy")
    }
    
    init(_ name : String) {
        self.name = name
    }
    
    deinit {
        print("childer end")
    }
}

var test = true

if test {
var f = Father()
var m = Mother()

var c1 = Children("c1")
var c2 = Children("c2")
c1.speak(c2)
c2.speakWithMother(m)
}





