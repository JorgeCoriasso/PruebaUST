//
//  CharactersProtocols.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

protocol CharactersListViewToPresenterProtocol: Any{
    
    var view: CharactersListPresenterToViewProtocol? {get set}
    var interactor: CharactersListPresenterToInteractorProtocol? {get set}
    var router: CharactersListPresenterToRouter? {get set}
    var isLoading:Bool? {get set}
    var charactersList:[CharacterDTO] {get set}
    func getImage(ofCharacter character: CharacterDTO)
    func fetchCharacters(withOffet offset:String)
    func userTapCharacter(_ character:CharacterDTO, navigationController: UINavigationController)

}

protocol CharactersListPresenterToViewProtocol: Any {
    func reloadTable()
    func showErrorMessage(withMessage message: String)
}

protocol CharactersListPresenterToInteractorProtocol: Any {
    var presenter: CharactersListInteractorToPresenter? {get set}
    func fetchCharactersList(withOffet offset:String)
    func getImage(ofCharacter character:CharacterDTO)
}

protocol CharactersListInteractorToPresenter: Any {
    func appendCharacter(_ character: CharacterDTO)
    func updateLoading(with: Bool)
    func reloadCharacterTable()
    func removePlaceholders()
    func showError(withMessage message: String)
}

protocol CharactersListPresenterToRouter: Any {
    func goToDetail(ofCharacter character: CharacterDTO, navigationController: UINavigationController)
}

