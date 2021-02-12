//
//  CharacterDetailRouter.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import UIKit

class CharacterDetailRouter: CharacterDetailPresenterToRouter {
    
    func createModule(withCharacter character: CharacterDTO) -> CharacterDetailViewController {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "CharacterDetail") as! CharacterDetailViewController
        
        var presenter: CharacterDetailViewToPresenterProtocol & CharacterDetailInteractorToPresenter = CharacterDetailPresenter()
        var interactor: CharacterDetailPresenterToInteractorProtocol = CharacterDetailInteractor()
        let router: CharacterDetailPresenterToRouter = CharacterDetailRouter()
        
        view.presenter = presenter
        presenter.character = character
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func popViewController(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }

    
}
