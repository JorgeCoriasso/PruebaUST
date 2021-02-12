//
//  CharactersViewController.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 11/02/2021.
//

import UIKit
import SkeletonView

class CharactersListViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tableViewCharacters: UITableView!
    
    //MARK: - Properties
    var presenter: CharactersListViewToPresenterProtocol?
    
    //MARK: - Lyfe cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter?.fetchCharacters(withOffet: "0")
    }
    
    //MARK: - private implementation
    private func setupViews() {
        
        //NavigationBar
        
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: UIColor.CustomColors.marvelRed.rawValue)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Galería de héroes"
        
        //Character table
        tableViewCharacters.delegate = self
        tableViewCharacters.dataSource = self
        tableViewCharacters.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "characterCell")
        tableViewCharacters.isSkeletonable = true
    }
    
    private func showError(withMessage message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let restartButton = UIAlertAction(title: "Reintentar", style: .default, handler: { _ in
            self.dismiss(animated: true)
            self.presenter?.fetchCharacters(withOffet: self.presenter?.charactersList.count.description ?? "0")
        })
        let closeButton = UIAlertAction(title: "Cerrar", style: .cancel, handler: {_ in
            self.dismiss(animated: true)
        })
        
        alertView.addAction(restartButton)
        alertView.addAction(closeButton)
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
}

//MARK: - Presenter to View
extension CharactersListViewController:CharactersListPresenterToViewProtocol {

    func reloadTable() {
        self.tableViewCharacters.reloadData()
    }
    
    func showErrorMessage(withMessage message: String) {
        self.showError(withMessage: message)
    }

}

//MARK: - TableView delegate & datasource
extension CharactersListViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.charactersList.count ?? 0
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "characterCell"
    }

    func tableView(_ skelletonView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentCharacter = presenter?.charactersList[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell: CharacterTableViewCell = tableViewCharacters.dequeueReusableCell(withIdentifier: "characterCell") as! CharacterTableViewCell
        
        //Check the skelleton enable to prevent reused cell to hide actual data.
        cell.isSkeletonable = true
        if currentCharacter.name == "placeholder" {
            cell.activateSkelleton(true)
        } else {
            cell.activateSkelleton(false)
        }
        
        cell.characterImage.image = currentCharacter.image
        cell.characterName.text = currentCharacter.name
        cell.characterDescription.text = currentCharacter.description
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = self.presenter?.charactersList[indexPath.row] else {
            return
        }
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        self.presenter?.userTapCharacter(character, navigationController: navigationController!)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cellCharacter = presenter?.charactersList[indexPath.row] else {
            return
        }
        
        if cellCharacter.image == nil {
            self.presenter?.getImage(ofCharacter: cellCharacter)
        }
        
        
        ///Limit where the app will fetch another 25 characters
        if let charactersCount = presenter?.charactersList.count {
            if indexPath.row == (charactersCount - 3)  && !(presenter?.isLoading ?? true) {
                presenter?.fetchCharacters(withOffet: charactersCount.description)
            }
        }
        
    }
}
