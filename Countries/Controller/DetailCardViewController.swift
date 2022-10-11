//
//  DetailCardViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

final class DetailCardViewController: UIViewController {
    
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
    
    private func getCountryDetails() {
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
            UserDefaultsManager().deleteUserDefaultsItem(countryCode: countryCode ?? "", countryName: countryName ?? "")
            saveButton?.image = UIImage(systemName: GlobalVariables.unsaved)
            return
        }
        UserDefaultsManager().addItemToUserDefaults(countryCode: self.countryCode ?? "", countryName: self.countryName ?? "")
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
            showAlert(alertText: GlobalVariables.noDataPlaceHolder, alertMessage: "")
        }
    }
}
