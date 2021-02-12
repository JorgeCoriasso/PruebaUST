//
//  CharacterDetailEntity.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import ObjectMapper

struct CharacterDetailEntity: Mappable {

    var name: String?
    var thumbnail: Thumbnail?
    var description: String?
    //var stories:[Story]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.name <- map["name"]
        self.thumbnail <- map["thumbnail"]
        self.description <- map["description"]
    }
}
