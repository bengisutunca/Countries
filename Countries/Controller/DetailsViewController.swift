//
//  DetailsViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var imgCountryFlag: UIImageView!
    @IBOutlet private weak var lblCountryCode: UILabel!
    @IBOutlet private weak var lblCountryCodePlaceholder: UILabel!
    private var saveButton: UIBarButtonItem?
    
    public var countryCode: String?
    public var countryName: String?
    private var countryDetails: CountryDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryDetails()
        loadDetails()
        setupCountryDetailData()
        
        // MARK: Setup Save Bar Button Item
        saveButton = UIBarButtonItem(image: UIImage(systemName: GlobalVariables.saved), style: .plain, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controlFavButton()
    }
    
    private func getCountryDetails(){
        Networking().countryDetails(code: countryCode ?? "", completion: { result in
            switch result {
            case .success(let countryDetail):
                DispatchQueue.main.async {
                    self.countryDetails = countryDetail
                    self.setupCountryDetailData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func loadDetails() {
        lblCountryCode.text = countryCode
        lblCountryCodePlaceholder.text = GlobalVariables.countryCodePlaceHolder
    }
    
    private func setupCountryDetailData() {
        guard let imageURL = URL(string: countryDetails?.data?.flagImageUri ?? "") else { return }
        imgCountryFlag.showImage(with: imageURL)
        title = countryDetails?.data?.name
    }
    
    @objc func saveButtonPressed() {
        if(GlobalVariables.savedCountriesCodeList.contains(self.countryCode ?? "")){
            let deleteID = GlobalVariables.savedCountriesCodeList.firstIndex(where: {$0 == countryCode})!
            let deleteName = GlobalVariables.savedCountriesNameList.firstIndex(where: {$0 == countryName})!
            
            GlobalVariables.savedCountriesCodeList.remove(at: deleteID)
            GlobalVariables.savedCountriesNameList.remove(at: deleteName)
            
            UserDefaults.standard.setValue(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
            UserDefaults.standard.setValue(GlobalVariables.savedCountriesNameList, forKey: UserDefaultsKey.countreyNamesKey.rawValue)
            
            saveButton?.image = UIImage(systemName: GlobalVariables.unsaved)
            return
        }
        
        GlobalVariables.savedCountriesCodeList.append(self.countryCode ?? "")
        GlobalVariables.savedCountriesNameList.append(self.countryName ?? "")
        
        UserDefaults.standard.set(GlobalVariables.savedCountriesNameList, forKey: UserDefaultsKey.countreyNamesKey.rawValue)
        UserDefaults.standard.set(GlobalVariables.savedCountriesCodeList, forKey: UserDefaultsKey.countryCodesKey.rawValue)
        
        saveButton?.image = UIImage(systemName: GlobalVariables.saved)
    }
    
    private func controlFavButton() {
        if (GlobalVariables.savedCountriesCodeList.firstIndex(where: {$0 == countryCode}) != nil) {
            saveButton?.image = UIImage(systemName: GlobalVariables.saved)
        } else {
            saveButton?.image = UIImage(systemName: GlobalVariables.unsaved)
        }
    }
    
    
    @objc private func saveButtonTapped() {
    }
    
    @IBAction func informationButtonTapped(_ sender: Any) {
        if countryDetails?.data?.wikiDataId != nil {
            UIApplication.shared.open((URL(string: "\(GlobalVariables.wiki+((countryDetails?.data?.wikiDataId)!))")!) as URL, options: [:], completionHandler: nil)
        } else {
            
        }
    }
}
