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
            let deleteID = GlobalVariables.savedCountriesCodeList.firstIndex(where: {$0 == self.country?.code})!
            let deleteName = GlobalVariables.savedCountriesNameList.firstIndex(where: {$0 == self.country?.name})!
            
            GlobalVariables.savedCountriesCodeList.remove(at: deleteID)
            GlobalVariables.savedCountriesNameList.remove(at: deleteName)
            
            UserDefaults.standard.setValue(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
            btnAddFavorited?.setImage(UIImage(systemName: GlobalVariables.unsaved), for: .normal)
            return
        }
        
        GlobalVariables.savedCountriesCodeList.append(self.country?.code ?? "")
        GlobalVariables.savedCountriesNameList.append(self.country?.name ?? "")
        
        UserDefaults.standard.set(GlobalVariables.savedCountriesNameList, forKey: UserDefaultsKey.countreyNamesKey.rawValue)
        UserDefaults.standard.set(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
        btnAddFavorited?.setImage(UIImage(systemName: GlobalVariables.saved), for: .normal)
    }
    
    override func prepareForReuse() {
        lblCountryName.text = nil
        super.prepareForReuse()
    }
}
