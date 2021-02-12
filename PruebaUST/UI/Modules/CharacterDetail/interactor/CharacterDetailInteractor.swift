//
//  CharacterDetailInteractor.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailPresenterToInteractorProtocol {
    
    //MARK: - Properties
    var presenter: CharacterDetailInteractorToPresenter?
    lazy var provider: Provider = Provider()
    
    func fetchCharacterDetail(ofCharacter character: CharacterDTO){
        
        guard let id = character.id?.description else {
            //TODO
            //self.presenter.showErrorMessage
            return
        }
        
        let urlString = ProviderConstants.urlPaths.characterDetail.rawValue.replacingOccurrences(of: "{id}", with: id)
        
        provider.request(from: urlString, params: [:], success: { data in
            
            guard let characterJSON = (data["results"] as? Array<Any>)?.first as? [String:Any] else {
                //TODO: Mostrar Error de conexionn
                return
            }
            
            guard let characterEntity = CharacterDetailEntity(JSON: characterJSON) else {
                //TODO: Mostrar Error de servicio
                return
            }
            let characterDTO = CharacterDetailDTO(characterDetailEntity: characterEntity)
            
            self.presenter?.addCharacterDetail(characterDTO)
            
            
        }, failure: { error in
            self.presenter?.showError(withMessage: error.domain)
            
        })
    }
    
    func fetchCharacterImage(_ url: String) {
        provider.getImage(fromUrl: url, success: { image in
            self.presenter?.setCharacterImage(image)
            
        })
    }
    
    
}
