//
//  Friend.swift
//  Birthdays
//
//  Created by Scholar on 8/8/25.
//

import Foundation
import SwiftData
@Model
class Friend { //declare class
    var name: String //property
    var birthday: Date //property
    
    
    init(name: String, birthday: Date) { //start initializer
        self.name = name
        self.birthday = birthday
    } //end initializer
} //end friend class
