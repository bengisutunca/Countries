//
//  UIViewController+Alert.swift
//  Countries
//
//  Created by Bengi Tunca on 11.10.2022.
//

import UIKit

extension UIViewController {
    func showAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: GlobalVariables.alertButtonString, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        alert.view.tintColor = UIColor(named: "colorForTint")
        self.present(alert, animated: true, completion: nil)
    }
}

