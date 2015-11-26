import Foundation

extension Int {
    var isNegative : Bool {
        return !(self >= 0)
    }
    
    var isPositive : Bool {
        return !isNegative
    }
    
    var symbolCount : Int {
        if self.isPositive {
        return String(self).characters.count
        } else {
            return String(self).characters.count-1
        }
    }
}

extension String {
    subscript (range : Range<Int>) -> String {
        let tempRange = Range(range)
        return self[tempRange]
    }
}

var i = 422
i.isNegative
i.isPositive
i.symbolCount

var t = "Hello"
let r = t[0...3]
r

