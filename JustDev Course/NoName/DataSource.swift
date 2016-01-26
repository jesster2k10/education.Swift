//
//  DataSource.swift
//  TableView lesson
//
//  Created by Родыгин Дмитрий on 20.01.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation

class DataSource {
    var name = ""
    var type = ""
    var location = ""
    var isVisited = false
    
    init(name : String, type : String, location : String, isVisited : Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.isVisited = isVisited
    }
}