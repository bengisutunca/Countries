//
//  ViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var countryCollectionView: UICollectionView!
    
    private var countries: [Country] = []
    private var countryCode: String?
    private var countryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // MARK: For Updating Saved Button Image
        DispatchQueue.main.async {
            self.countryCollectionView.reloadData()
        }
    }
    
    
    private func getCountries() {
        Networking().countryList(limit: GlobalVariables.limit, completion: { result in
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
        countryCode = countries[indexPath.item].code
        countryName = countries[indexPath.item].name
        if (GlobalVariables.savedCountriesCodeList.firstIndex(where: {$0 == countryCode}) != nil) {
            cell.btnAddFavorited.setImage(UIImage(systemName: GlobalVariables.saved), for: .normal)
        } else {
            cell.btnAddFavorited.setImage(UIImage(systemName: GlobalVariables.unsaved), for: .normal)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let countryDetailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailCardViewController {
            self.navigationController?.pushViewController(countryDetailsVC, animated: true)
            countryDetailsVC.countryCode = countries[indexPath.row].code
            countryDetailsVC.countryName = countries[indexPath.row].name
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.9, height: height * 0.1)
    }
}

