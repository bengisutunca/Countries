//
//  ViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var countryCollectionView: UICollectionView!
    @IBOutlet private weak var lblTitle: UILabel!
    
    private var countries: [Country] = []
    private var countryCode: String?
    private var savedCountriesCodeList : [String] = []
    private var limit: String = "10"

    override func viewDidLoad() {
        super.viewDidLoad()
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
        getCountries()
        lblTitle.text = "Countries"
    }
    
    private func getCountries(){
            Networking().countryList(limit: limit, completion: { result in
            switch result {
            case .success(let country):
                DispatchQueue.main.async {
                    self.countries.append(contentsOf: country.data)
                    self.countryCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as! CountryCollectionViewCell
        cell.country = countries[indexPath.item]
        return cell
    }
}
