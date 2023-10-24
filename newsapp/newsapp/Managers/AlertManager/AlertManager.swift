//
//  AlertManager.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation
import UIKit

// MARK: - AlertShowable
protocol AlertShowable {
    func showAlert(with error: ApiError)
}

// MARK: - AlertManager
final class AlertManager: AlertShowable {
    // MARK: Properties
    static let shared: AlertManager = .init()
    
    func showAlert(with error: ApiError) {
        if let currentViewController = UIApplication.shared.windows.first?.rootViewController {
            let alert = UIAlertController(
                title: "Error",
                message: error.description,
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            currentViewController.present(alert, animated: true, completion: nil)
        }
    }
}
