import Foundation


struct Student {
    var firstName : String {
        
        willSet(newFistName){
            print(newFistName + firstName)
        }
        didSet {
            print(firstName + oldValue)
            firstName = firstName.capitalizedString
        }
    }
    
    var lastName : String {
        didSet {
            lastName = lastName.capitalizedString
        }
    }
    
    var fullName : String {
        get {
        return firstName + " " + lastName
        }
        set {
            let words = newValue.componentsSeparatedByString(" ")
            if words.count > 0 {
                firstName = words[0]
            }
            if words.count > 1 {
                lastName = words[1]
            }
        }
    }
    
    var ageOf : age
    
    struct age {
        var day : Int {
            didSet {
                if (day > 31) {
                    day = 0
                }
            }
        }
        var mounth : Int
        var year : Int
        
        var yearsOld : Int {
            let calendar = NSCalendar.currentCalendar()
            let yearNow = calendar.component(.Year,fromDate: NSDate())
            
            return yearNow - year
        }
        
        var yearsLearn : Int {
            if ( yearsOld < 6 ) { return 0 }
            else { return yearsOld - 6 }
        }
    }
}

var student = Student(firstName: "zlobo", lastName: "Dmitriy", ageOf: Student.age(day: 31, mounth: 07, year: 1990))

student.firstName = "MAX"
student.firstName
student.lastName

student.fullName = "Dmitriy Rodygin"
student.firstName
student.lastName

student.ageOf.yearsOld
student.ageOf.yearsLearn
student.ageOf.day = 31
student.ageOf.day



struct Segment {
    struct Point {
        var x : Int
        var y : Int
    }
    
    var pointA : Point
    var pointB : Point
    
    var midPoint : Point {
        get {
            return Point(x: (pointA.x + pointB.x) / 2 , y: (pointA.y + pointB.y) / 2)
        }
        set {
            
        }
    }
}

