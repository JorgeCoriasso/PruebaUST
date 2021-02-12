//
//  CharacterDetailViewController.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import Foundation
import UIKit

public class CharacterDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var presenter: CharacterDetailViewToPresenterProtocol?
    
    //MARK: - Lyfe Cyrcle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchDetails()
    }

    
    //MARK: - Private implementation
    
    private func setupViews() {
        characterImage.isSkeletonable = true
        characterNameLabel.isSkeletonable = true
        characterDescriptionLabel.isSkeletonable = true
    }
    
    private func fetchDetails() {
        characterImage.showAnimatedGradientSkeleton()
        characterNameLabel.showAnimatedGradientSkeleton()
        characterDescriptionLabel.showAnimatedGradientSkeleton()
        presenter?.fetchCharacterDetail()
    }
    
    private func showError(withMessage message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let restartButton = UIAlertAction(title: "Reintentar", style: .default, handler: { _ in
            self.dismiss(animated: true)
            self.presenter?.fetchCharacterDetail()
        })
        let closeButton = UIAlertAction(title: "Cerrar", style: .cancel, handler: {_ in
            self.dismiss(animated: true)
            self.presenter?.popViewController(navigationController: self.navigationController!)
        })
        
        alertView.addAction(restartButton)
        alertView.addAction(closeButton)
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
}


extension CharacterDetailViewController: CharacterDetailPresenterToViewProtocol {
    
    
    func showErrorMessage(withMessage message: String) {
        self.showError(withMessage: message)
    }
    
    func updateFields() {
        guard let character = presenter?.characterDetail else { return }
        
        characterNameLabel.text = character.name
        
        if character.description == nil || character.description == "" {
            characterDescriptionLabel.text = "Descripción no disponible"
        } else {
            characterDescriptionLabel.text = character.description
        }
        
        characterNameLabel.hideSkeleton()
        characterDescriptionLabel.hideSkeleton()
        
    }
    
    func updateImage() {
        guard let character = presenter?.characterDetail else { return }
        
        if character.image != nil{
            characterImage.image = character.image
            characterImage.hideSkeleton()
        }
    }
    
}
