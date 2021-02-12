//
//  CharactersListPresenter.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

class CharactersListPresenter: CharactersListViewToPresenterProtocol {
 
    //MARK: - properties
    var interactor: CharactersListPresenterToInteractorProtocol?
    var router: CharactersListPresenterToRouter?
    var view: CharactersListPresenterToViewProtocol?
    var presenter: CharactersListPresenterToInteractorProtocol?
    
    var isLoading: Bool? = false
    var charactersList: [CharacterDTO] = []
    
    //MARK: - View to presenter protocol
    
    func fetchCharacters(withOffet offset: String) {
        isLoading = true
        interactor?.fetchCharactersList(withOffet: offset)
    }
    
    func getImage(ofCharacter character: CharacterDTO) {
        interactor?.getImage(ofCharacter: character)
    }
    
    func goToCharacterDetail(withCharacter character:CharacterDTO, navigationController: UINavigationController) {
        router?.goToDetail(ofCharacter: character, navigationController: navigationController)
    }
    
}

extension CharactersListPresenter: CharactersListInteractorToPresenter {
    func removePlaceholders() {
        charactersList.removeAll(where: {$0.name == "placeholder"})
    }
    
    func reloadCharacterTable() {
        self.view?.reloadTable()
    }
    
    func updateLoading(with: Bool) {
        self.isLoading = with
    }
    
    func appendCharacter(_ character: CharacterDTO) {
        self.charactersList.append(character)
    }
    
    func userTapCharacter(_ character: CharacterDTO, navigationController:UINavigationController) {
        self.goToCharacterDetail(withCharacter: character, navigationController: navigationController)
    }

    func showError(withMessage message: String) {
        self.view?.showErrorMessage(withMessage: message)
    }
    
    
}
