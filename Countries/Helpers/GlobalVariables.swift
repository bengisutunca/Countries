//
//  GlobalVariables.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

struct GlobalVariables {
    // MARK: UserDefaults Arrays
    static var savedCountriesCodeList = UserDefaults.standard.array(forKey: UserDefaultsKey.countryCodesKey.rawValue) as? [String] ?? []
    static var savedCountriesNameList = UserDefaults.standard.array(forKey: UserDefaultsKey.countryNamesKey.rawValue) as? [String] ?? []
    
    // MARK: Save Button Images file names
    static var saved = "star.fill"
    static var unsaved = "star"
    
    // MARK: Limit - Wiki Endpoint
    static var limit: String = "10"
    static var wiki = "https://www.wikidata.org/wiki/"
    
    // MARK: PlaceHolders
    static var countryCodePlaceHolder = "Country Code:"
    static var tabBarItemName1 = "Home"
    static var tabBarItemName2 = "Saved"
    static var noDataPlaceHolder = "There is nothing to show."
    static var alertButtonString = "OK"
}
