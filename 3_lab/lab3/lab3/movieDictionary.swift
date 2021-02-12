//
//  movieDictionary.swift
//  lab3
//
//  Created by Deven Pile on 2/11/21.
//

import Foundation

class movieDictionary{
    
    var movieRepository = [String:movieRecord]()
    var movies:[movieRecord] = []
    
    init (){}
    
    func add( _ name:String, _ genre:String, _ price:Float16){
        let mRecord = movieRecord(n: name, g: genre, t: price)
        movieRepository[mRecord.name!] = mRecord
        movies.append(mRecord)
    }
    
    func search(s:String) -> movieRecord?{
        for(name, _) in movieRepository {
            if( name == s ){
                return movieRepository[s]
                
            }
        }
        return nil
    }
    
    func deleteRecord (s:String){
        for i in stride(from: 0, to: movies.endIndex, by: 1){
            if s == movies[i].name {
                movies.remove(at: i)
            }
        }
        movieRepository[s] = nil
        
    }
}
