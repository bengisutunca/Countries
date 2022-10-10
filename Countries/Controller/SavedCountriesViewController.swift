//
//  SavedCountriesViewController.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

final class SavedCountriesViewController: UIViewController {
    
    @IBOutlet private weak var savedCountriesCollectionView: UICollectionView!
    
    private var savedCountryNameList: [String?] = []
    private var savedCountryCodeList: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.updateArraysAndUI()
        }
    }
    
    private func updateArraysAndUI(){
        self.savedCountryNameList = GlobalVariables.savedCountriesNameList
        self.savedCountryCodeList = GlobalVariables.savedCountriesCodeList
        self.savedCountriesCollectionView.reloadData()
    }
}

extension SavedCountriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCountryNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedCountriesCollectionViewCell", for: indexPath) as! SavedCountriesCollectionViewCell
        cell.lblCountryName?.text = savedCountryNameList[indexPath.row]
        cell.deleteCell = { [weak self] in
            // MARK: For deleting cells in UICollectionView
                DispatchQueue.main.async {
                    self?.savedCountriesCollectionView.reloadData()
                    UserDefaultsManager().removeUserDefaultItemsAtIndexPath(indexPath: indexPath.item)
                    self?.updateArraysAndUI()
                }
            do {
                self?.savedCountriesCollectionView.performBatchUpdates({
                    self?.savedCountriesCollectionView.deleteItems(at: [indexPath])
                }, completion: nil)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let countryDetailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailCardViewController {
            self.navigationController?.pushViewController(countryDetailsVC, animated: true)
            countryDetailsVC.countryCode = savedCountryCodeList[indexPath.row]
            countryDetailsVC.countryName = savedCountryNameList[indexPath.row]
            
        }
    }
}

extension SavedCountriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.9, height: height * 0.1)
    }
}
