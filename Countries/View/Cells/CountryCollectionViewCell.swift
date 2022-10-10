//
//  CountryCollectionViewCell.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblCountryName: UILabel!
    @IBOutlet weak var btnAddFavorited: UIButton!
    
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
        if(GlobalVariables.savedCountriesCodeList.contains(self.country?.code ?? "")){
            UserDefaultsManager().deleteUserDefaultsItem(countryCode: self.country?.code ?? "", countryName: self.country?.name ?? "")
            return
        }
        UserDefaultsManager().addItemToUserDefaults(countryCode: self.country?.code ?? "", countryName: self.country?.name ?? "")
        btnAddFavorited?.setImage(UIImage(systemName: GlobalVariables.saved), for: .normal)
    }
    
    override func prepareForReuse() {
        lblCountryName.text = nil
        super.prepareForReuse()
    }
}
