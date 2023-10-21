//
//  FavoritesBuilder.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 21.10.2023.
//

import Foundation

final class FavoritesBuilder {
    static func build() -> FavoritesViewController {
        let controller = FavoritesViewController.instantiateFromNibOrSelfIntance()
        
        return controller
    }
}
