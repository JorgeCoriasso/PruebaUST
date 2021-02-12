//
//  AllCharactersDTO.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import Foundation
import ObjectMapper

struct CharacterEntity: Mappable {
   
    var thumbnail:Thumbnail?
    var id:Int?
    var name:String?
    var detailUrl:String?
    var description:String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        
        self.name <- map["name"]
        self.thumbnail <- map["thumbnail"]
        self.id <- map["id"]
        self.detailUrl <- map["resourceURI"]
        self.description <- map["description"]
    }
}

struct Thumbnail: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.path <- map["path"]
        self.type <- map["extension"]
    }
    
    var path: String?
    var type: String?
    
    func getFullPath() -> String {
        
        guard let path = path, let type = type else {
            return ""
        }
        
        return "\(path).\(type)"
    }
    
    
}
