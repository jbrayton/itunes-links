//
//  UIViewController+LinkHandler.swift
//  Links
//
//  Created by John Brayton on 5/5/19.
//  Copyright © 2019 John Brayton. All rights reserved.
//

import SafariServices
import StoreKit
import UIKit

extension UIViewController : SKStoreProductViewControllerDelegate {
    
    // Try to open the URL as a universal link. If that fails, determine whether the URL is an iTunes URL. If it is, open it with a
    // Store Product View Controller. If not, open it with a Safari View Controller.
    func GHS_open(url: URL) {
        UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: true]) { [weak self] (success) in
            if (!success) {
                if let itunesProductParameters = url.GHS_itunesProductParameters() {
                    let storeViewController = SKStoreProductViewController()
                    storeViewController.delegate = self
                    self?.present(storeViewController, animated: true, completion: {
                        storeViewController.loadProduct(withParameters: itunesProductParameters, completionBlock: nil)
                    })
                } else {
                    let safariViewController = SFSafariViewController(url: url)
                    self?.present(safariViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: SKStoreProductViewControllerDelegate
    
    public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}


