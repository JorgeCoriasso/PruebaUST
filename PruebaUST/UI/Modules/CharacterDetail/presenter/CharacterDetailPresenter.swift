//
//  CharacterDetailPresenter.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

public class CharacterDetailPresenter: CharacterDetailViewToPresenterProtocol {
    
    //MARK: - properties
    var interactor: CharacterDetailPresenterToInteractorProtocol?
    var router: CharacterDetailPresenterToRouter?
    var view: CharacterDetailPresenterToViewProtocol?
    var presenter: CharacterDetailPresenterToInteractorProtocol?
    
    var character: CharacterDTO!
    var characterDetail: CharacterDetailDTO?
    
    func fetchCharacterDetail() {
        interactor?.fetchCharacterDetail(ofCharacter: character)
    }
    
    func popViewController(navigationController: UINavigationController) {
        router?.popViewController(navigationController: navigationController)
    }
    
}


extension CharacterDetailPresenter: CharacterDetailInteractorToPresenter {
    
    func addCharacterDetail(_ details: CharacterDetailDTO) {
        self.characterDetail = details
        
        if characterDetail?.imageUrl != nil && characterDetail?.imageUrl != "" {
            interactor?.fetchCharacterImage(characterDetail!.imageUrl!)
        }
        
        self.view?.updateFields()
    }
    
    func setCharacterImage(_ image: UIImage) {
        self.characterDetail?.image = image
        self.view?.updateImage()
    }
    
    func showError(withMessage message: String) {
        self.view?.showErrorMessage(withMessage: message)
    }
    
}
