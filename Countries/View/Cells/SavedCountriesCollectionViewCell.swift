//
//  SavedCountriesCollectionViewCell.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

final class SavedCountriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet private weak var btnFavorited: UIButton!
    
    var deleteCell: (() -> Void)?
    
    override func awakeFromNib() {
        makeRoundedCell()
        super.awakeFromNib()
    }
    
    var country: Country? {
        didSet {
            guard let country = country else {
                return
            }
            if country.name == nil {
                self.lblCountryName.text = GlobalVariables.noDataPlaceHolder
            } else {
                self.lblCountryName.text = country.name
            }
        }
    }
    
    @IBAction func savedButtonTapped(_ sender: UIButton) {
        deleteCell?()
    }
    
    override func prepareForReuse() {
        lblCountryName.text = nil
        super.prepareForReuse()
    }
}
