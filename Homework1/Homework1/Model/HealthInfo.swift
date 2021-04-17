//
//  HealthInfo.swift
//  Homework1
//
//  Created by Deven Pile on 4/16/21.
//

import Foundation


class HealthInfo{
    var systolic:Int
    var diastolic:Int
    var weight:Int
    var sugarLevel:Int
    var otherSymptoms:String?
    
    init(bps:Int, bpd:Int, weight:Int, sugarLevel:Int, other:String?){
        self.systolic = bps
        self.diastolic = bpd
        self.weight = weight
        self.sugarLevel = sugarLevel
        self.otherSymptoms = other ?? ""
    }
    
    
}
