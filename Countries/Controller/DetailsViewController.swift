//
//  DetailsViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit
import Kingfisher
import SVGKit

final class DetailsViewController: UIViewController {
    
    public var countryCode: String?
    private var countryDetails: CountryDetailModel?
    private let wiki = "https://www.wikidata.org/wiki/"

    @IBOutlet private weak var imgCountryFlag: UIImageView!
    @IBOutlet private weak var lblCountryCode: UILabel!
    @IBOutlet private weak var lblCountryCodePlaceholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryDetails()
        loadDetails()
        getCountryFlag()
    }
    
    private func getCountryDetails(){
        Networking().countryDetails(code: countryCode!, completion: { result in
            switch result {
            case .success(let countryDetail):
                DispatchQueue.main.async {
                    self.countryDetails = countryDetail
                    self.getCountryFlag()
                    }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func loadDetails(){
        lblCountryCode.text = countryCode
        lblCountryCodePlaceholder.text = "Country Code:"
    }
    
    private func getCountryFlag() {
        guard let imageURL = URL(string: countryDetails?.data?.flagImageUri ?? "") else { return }
        imgCountryFlag.showImage(with: imageURL)
        title = countryDetails?.data?.name
        }
    
    @IBAction func informationButtonTapped(_ sender: Any) {
        
        if countryDetails?.data?.wikiDataID != nil {
            UIApplication.shared.open((URL(string: "\(wiki+((countryDetails?.data?.wikiDataID)!))")!) as URL, options: [:], completionHandler: nil)
        } else {
        }
    }

}
