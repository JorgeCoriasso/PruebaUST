//
//  CharactersListInteractor.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation

class CharacterListInteractor: CharactersListPresenterToInteractorProtocol {

    var presenter: CharactersListInteractorToPresenter?

    lazy var provider = Provider()
    
    //MARK: - public implementation
    func fetchCharactersList(withOffet offset: String) {
        //While the first group of data is loading we will show a placeholder
        if offset == "0" {
            loadingPlaceHolder()
        }
        
        let params = ["offset" : offset,
                      "limit" : "25"]
        
        provider.request(from: ProviderConstants.urlPaths.allCharacters.rawValue, params: params, success: {[weak self] data in
            defer { self?.presenter?.updateLoading(with: false) }
            
            guard let characterArray = data["results"] as? NSArray else {
                
                return
            }
            
            for character in characterArray {
                let characterJson = character as! [String:Any]
                guard let characterEntity = CharacterEntity(JSON: characterJson) else {
                    
                    //TODO: Mensaje de error
                    return
                }
                let characterTmp = CharacterDTO(allCharactersEntity: characterEntity)
                
                self?.presenter?.appendCharacter(characterTmp)
            }
            self?.presenter?.removePlaceholders()
            self?.presenter?.reloadCharacterTable()
            
        }, failure: {error in
            self.presenter?.updateLoading(with: false)
            self.presenter?.showError(withMessage: error.domain)
        })
    }
    
    func getImage(ofCharacter character: CharacterDTO) {
        guard let imageUrl = character.imageUrl else { return }
        
        if !imageUrl.isEmpty {
            provider.getImage(fromUrl: imageUrl, success: {[weak self] image in
                character.image = image
                self?.presenter?.reloadCharacterTable()
            })
        }
    }
    
    
    //MARK: - Private implementation
    private func loadingPlaceHolder(){
        
        for _ in 0...19 {
            let placeHolder:CharacterDTO = CharacterDTO()
            placeHolder.name = "placeholder"
            presenter?.appendCharacter(placeHolder)
        }
        presenter?.reloadCharacterTable()
    }

}
