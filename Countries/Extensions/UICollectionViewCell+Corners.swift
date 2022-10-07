//
//  UICollectionViewCell+Corners.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit

extension UICollectionViewCell {
    func makeRoundedCell() {
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 3.0
    }
}
