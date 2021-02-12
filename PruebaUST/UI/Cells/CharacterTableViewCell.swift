//
//  CharacterTableViewCell.swift
//  PruebaUST
//
//  Created by Jorge Sanchez on 10/02/2021.
//

import UIKit
import SkeletonView
class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var characterName: UILabel!        


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        characterImage.layer.cornerRadius = characterImage.frame.height / 2
        characterImage.layer.borderColor = UIColor.init(hex: UIColor.CustomColors.marvelRed.rawValue)?.cgColor
        characterImage.layer.borderWidth = 2.5
        
        characterName.isSkeletonable = true
        characterImage.isSkeletonable = true
        characterDescription.isSkeletonable = true
    }
    
    func activateSkelleton(_ activate: Bool) {
        if activate {
            characterImage.showAnimatedGradientSkeleton()
            characterName.showAnimatedGradientSkeleton()
            characterDescription.showAnimatedGradientSkeleton()
        } else {
            characterImage.hideSkeleton()
            characterName.hideSkeleton()
            characterDescription.hideSkeleton() 
        }
    }
    
}
