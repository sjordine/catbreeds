//
//  CatBreedTableViewCell.swift
//  CatBreeds
//
//  Created by Sergio Ordine on 04/05/24.
//

import UIKit

class CatBreedTableViewCell: UITableViewCell {

    @IBOutlet weak var coatIcon: UIImageView!
    
    @IBOutlet weak var breedName: UILabel!
    
    @IBOutlet weak var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
