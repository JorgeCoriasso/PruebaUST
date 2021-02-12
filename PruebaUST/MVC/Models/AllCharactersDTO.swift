//
//  AllCharactersDTO.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import Foundation

class CharactersDTO {
    
    var name:String?
    var id:Int?
    var imageUrl: String?
    var detailUrl:String?
    
    convenience init(allCharactersEntity entity: AllCharactersEntity) {
        self.init()
        self.name = entity.name
        self.id = entity.id
        self.imageUrl = entity.thumbnail?.getFullPath()
        self.detailUrl = entity.detailUrl
    }
    
}
