//
//  Place.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 10/29/22.
//

import Foundation

enum ActivityType {
   case alert
    case event
    case health
}

struct Place {
    let title : String
    let description : String
    var thumbnail : String
    var time : String 
    var date : String
    var icon : String
    var type : ActivityType
    var latitiude: Double = 0
    var longitude: Double = 0
    var information : String = ""
}


