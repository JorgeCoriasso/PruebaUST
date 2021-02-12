//
//  CharacterDetailDTO.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

class CharacterDetailDTO {
    
    var name:String?
    var imageUrl: String?
    var detailUrl:String?
    var image:UIImage?
    var description: String?
    
    convenience init(characterDetailEntity entity: CharacterDetailEntity) {
        self.init()
        self.name = entity.name
        self.imageUrl = entity.thumbnail?.getFullPath()
        self.description = entity.description
    }
    
}
