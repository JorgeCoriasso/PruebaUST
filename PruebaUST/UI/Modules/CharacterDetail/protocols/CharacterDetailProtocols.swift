//
//  CharacterDetail.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

protocol CharacterDetailViewToPresenterProtocol: Any{
    
    var view: CharacterDetailPresenterToViewProtocol? {get set}
    var interactor: CharacterDetailPresenterToInteractorProtocol? {get set}
    var router: CharacterDetailPresenterToRouter? {get set}
    var character:CharacterDTO! {get set}
    var characterDetail:CharacterDetailDTO? {get set}
    
    func fetchCharacterDetail()
    func popViewController(navigationController: UINavigationController)
}

protocol CharacterDetailPresenterToViewProtocol: Any {
    func updateFields()
    func updateImage()
    func showErrorMessage(withMessage message: String)
}

protocol CharacterDetailPresenterToInteractorProtocol: Any {
    var presenter: CharacterDetailInteractorToPresenter? {get set}
    func fetchCharacterDetail(ofCharacter character: CharacterDTO)
    func fetchCharacterImage(_ url:String)
}

protocol CharacterDetailInteractorToPresenter: Any {
    func addCharacterDetail(_ details: CharacterDetailDTO)
    func setCharacterImage(_ image: UIImage)
    func showError(withMessage message: String)
}

protocol CharacterDetailPresenterToRouter: Any {
    func popViewController(navigationController: UINavigationController)
}

