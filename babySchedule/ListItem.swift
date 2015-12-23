//
//  ListItem.swift
//  babySchedule
//
//  Created by carlstand on 12/14/15.
//  Copyright © 2015 carlstand. All rights reserved.
//

import UIKit

class ListItem: NSObject {
    var amount: Int
    var type: String
    var date: NSDate

    init(amount:Int, type: String, date: NSDate){
        self.amount = amount
        self.type = type
        self.date = date
    }
}
