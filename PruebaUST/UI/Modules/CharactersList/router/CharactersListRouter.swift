//
//  CharactersListRouter.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

class CharactersListRouter: CharactersListPresenterToRouter {
    
    func createModule() -> CharactersListViewController {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "CharacterList") as! CharactersListViewController
        
        var presenter: CharactersListViewToPresenterProtocol & CharactersListInteractorToPresenter = CharactersListPresenter()
        var interactor: CharactersListPresenterToInteractorProtocol = CharacterListInteractor()
        let router: CharactersListPresenterToRouter = CharactersListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func goToDetail(ofCharacter character: CharacterDTO, navigationController: UINavigationController) {
        let vc = CharacterDetailRouter().createModule(withCharacter: character)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
