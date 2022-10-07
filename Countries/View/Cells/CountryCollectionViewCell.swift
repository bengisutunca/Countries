//
//  CountryCollectionViewCell.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblCountryName: UILabel!
    @IBOutlet private weak var btnAddFavorited: UIButton!
    
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
                self.lblCountryName.text = ""
            } else {
                self.lblCountryName.text = country.name
            }
        }
    }
    
    override func prepareForReuse() {
        lblCountryName.text = nil
        super.prepareForReuse()
    }
}
