//
//  RealmReader.swift
//  WeatherStatistics
//
//  Created by Hamzah Mugharbil on 7/21/20.
//  Copyright © 2020 Hamzah Mugharbil. All rights reserved.
//

import Foundation
import RealmSwift

class DayData: Object {
    let date = RealmOptional<Int>()
    @objc dynamic var time: String? = nil
    let AirTemp = RealmOptional<Double>()
    let BarometricPress = RealmOptional<Double>()
    let DewPoint = RealmOptional<Double>()
    let RelativeHumidity = RealmOptional<Double>()
    let WindDir = RealmOptional<Double>()
    let WindGust = RealmOptional<Int>()
    let WindSpeed = RealmOptional<Double>()
    
}


   
