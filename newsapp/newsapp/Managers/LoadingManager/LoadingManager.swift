//
//  LoadingManager.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit
import SnapKit

// MARK: - Loading
protocol Loading {
    func show()
    func hide()
}

// MARK: - LoadingManager
final class LoadingManager: Loading {
    
    // MARK: Properties
    static let shared: LoadingManager = .init()
    
    enum Constants {
        static let cornerRadius = 8.0
        static let loadingViewWidth = 74.0
        static let loadingViewHeight = 74.0
        static let activtyIndicatorWidth = 66.0
        static let activtyIndicatorHeight = 66.0
    }
    
    // MARK: Views
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .black
        return activityIndicator
    }()
}

// MARK: - Functions
extension LoadingManager {
    /// Show loading view
    func show() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    self.setupLoadingView(on: window)
                }
            }
        }
    }
    
    /// Hide loading view
    func hide() {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else { return }
                    
                    self.loadingView.removeFromSuperview()
                    window.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func setupLoadingView(on window: UIWindow) {
        window.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        window.bringSubviewToFront(loadingView)
        window.isUserInteractionEnabled = false
        
        loadingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.loadingViewWidth)
            make.height.equalTo(Constants.loadingViewHeight)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(loadingView.snp.centerX)
            make.centerY.equalTo(loadingView.snp.centerY)
            make.width.equalTo(Constants.activtyIndicatorWidth)
            make.height.equalTo(Constants.activtyIndicatorHeight)
        }
    }
}
