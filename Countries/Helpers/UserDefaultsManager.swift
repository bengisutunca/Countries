//
//  UserDefaultsManager.swift
//  Countries
//
//  Created by Bengi Tunca on 11.10.2022.
//

import Foundation

final class UserDefaultsManager {
    
    public func deleteUserDefaultsItem(countryCode: String, countryName: String) {
        let deleteID = GlobalVariables.savedCountriesCodeList.firstIndex(where: {$0 == countryCode})!
        let deleteName = GlobalVariables.savedCountriesNameList.firstIndex(where: {$0 == countryName})!
        GlobalVariables.savedCountriesCodeList.remove(at: deleteID)
        GlobalVariables.savedCountriesNameList.remove(at: deleteName)
        UserDefaults.standard.setValue(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
        UserDefaults.standard.setValue(GlobalVariables.savedCountriesNameList, forKey: UserDefaultsKey.countryNamesKey.rawValue)
    }
    
    public func addItemToUserDefaults(countryCode: String, countryName: String) {
        GlobalVariables.savedCountriesCodeList.append(countryCode)
        GlobalVariables.savedCountriesNameList.append(countryName)
        
        UserDefaults.standard.set(GlobalVariables.savedCountriesNameList, forKey: UserDefaultsKey.countryNamesKey.rawValue)
        UserDefaults.standard.set(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
    }
    
    public func removeUserDefaultItemsAtIndexPath(indexPath: Int) {
        GlobalVariables.savedCountriesNameList.remove(at: indexPath)
        GlobalVariables.savedCountriesCodeList.remove(at: indexPath)
    }
  
}
