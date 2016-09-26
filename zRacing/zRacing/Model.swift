//
//  Model.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 26.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation

class Model {
    
    static let sharedInstance = Model() //Singlton
    
    var score = 0
    var highScore = UserDefaults.standard.object(forKey: "highScore") as! Int
    
    func setHighScore() {
        UserDefaults.standard.set(self.highScore, forKey: "highScore")
    }
}
