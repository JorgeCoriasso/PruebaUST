//
//  AllCharactersDTO.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import Foundation
import UIKit
class CharacterDTO {
    
    var name:String?
    var id:Int?
    var imageUrl: String?
    var detailUrl:String?
    var image:UIImage?
    var description: String?
    
    convenience init(allCharactersEntity entity: CharacterEntity) {
        self.init()
        self.name = entity.name
        self.id = entity.id
        self.imageUrl = entity.thumbnail?.getFullPath()
        self.detailUrl = entity.detailUrl
        self.description = entity.description
    }
    
}
