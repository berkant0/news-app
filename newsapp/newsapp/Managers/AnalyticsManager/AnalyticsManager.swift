//
//  AnalyticsManager.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 23.10.2023.
//

import UIKit
import Firebase

// MARK: - AnalyticsTrackable
protocol AnalyticsTrackable {
    func trackEvent(_ event: String, parameters: [String: Any]?)
}

// MARK: - AnalyticsManager
final class AnalyticsManager: AnalyticsTrackable {
    // MARK: Properties
    static let shared: AnalyticsManager = .init()

    func trackEvent(_ event: String, parameters: [String: Any]?) {
        Analytics.logEvent(event, parameters: parameters)
    }
}
