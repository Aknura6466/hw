//
//  Holiday.swift
//  Hw
//
//  Created by Акнур on 8/20/20.
//  Copyright © 2020 Акнур. All rights reserved.
//

import Foundation
struct HolidayResponse : Decodable {
    var response : Holidays
}

struct Holidays : Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail : Decodable{
    var name : String
    var date : DateInfo
    
}

struct DateInfo : Decodable {
    var iso : String
}
