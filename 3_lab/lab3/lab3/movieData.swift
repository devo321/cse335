//
//  movieData.swift
//  lab3
//
//  Created by Deven Pile on 2/11/21.
//

import Foundation

class movieRecord {
    var name:String? = nil
    var genre:String? = nil
    var ticketPrice:Float16? = nil
    
    init(n:String, g:String, t:Float16){
        self.name = n
        self.genre = g
        self.ticketPrice = t
    }
    
    func setPrice(price:Float16){
        self.ticketPrice = price;
    }
    
    func setName(name:String){
        self.name = name
    }
    
    func setGenre(g:String){
        self.genre = g
    }
}
