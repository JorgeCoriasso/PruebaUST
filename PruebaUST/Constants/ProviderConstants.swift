//
//  ProviderConstants.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import Foundation

class ProviderConstants {
    
    static let privateKey:String = "11d0e590cbe13eca785ff17e3aa42b1c931fee3e"
    static let publicKey:String = "ce46636736b9254baacdff672d304c7e"
    static let baseUrl:String = "https://gateway.marvel.com:443/"
    static let apiKey:String = "?ts=1565045589&apikey=ce46636736b9254baacdff672d304c7e&hash=654aa06f5d432dd47297faf1d260b7ea"
    
    
    enum urlPaths:String {
        case allCharacters = "v1/public/characters"
        case characterDetail = "v1/public/characters/{id}"
    }
    
}
