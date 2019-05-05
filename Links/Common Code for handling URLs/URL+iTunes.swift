//
//  URL+iTunes.swift
//  Links
//
//  Created by John Brayton on 5/5/19.
//  Copyright © 2019 John Brayton. All rights reserved.
//

import Foundation
import StoreKit

extension URL {
    
    func GHS_itunesProductParameters() -> [String:String]? {
        guard let itunesId = self.GHS_itunesId() else {
            return nil
        }
        
        var result = [String:String]()
        result[SKStoreProductParameterITunesItemIdentifier] = itunesId
        
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems {
            for queryItem in queryItems {
                if queryItem.name == "at" {
                    result[SKStoreProductParameterAffiliateToken] = queryItem.value
                } else if queryItem.name == "ct" {
                    result[SKStoreProductParameterCampaignToken] = queryItem.value
                }
                
                // We should not try to handle action=write-review links.
                if queryItem.name == "action" && queryItem.value?.lowercased() == "write-review" {
                    return nil
                }
            }
        }
        
        return result
    }
    
    // MARK: Private Methods
    
    private func GHS_itunesId() -> String? {
        var result: String? = nil
        
        if self.GHS_isItunesLink() {
        
            if let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems {
                for queryItem in queryItems {
                    if queryItem.name == "i" {
                        result = queryItem.value
                    }
                }
            }
            
            if (result == nil) {
                if var possibleIdValue = self.path.components(separatedBy: "/").last {
                    if possibleIdValue.hasPrefix("id"), possibleIdValue.count > 2 {
                        possibleIdValue = String(possibleIdValue[lastPathComponent.index(possibleIdValue.startIndex, offsetBy: 2)..<possibleIdValue.endIndex])
                    }
                    if possibleIdValue.trimmingCharacters(in: CharacterSet.decimalDigits).count == 0 {
                        result = String(possibleIdValue)
                    }
                }
            }
            
        }
        return result
    }
    
    // Return true if this looks like an iTunes URL for which we should be able to generate a
    // Store Product View Controller.
    private func GHS_isItunesLink() -> Bool {
        guard let host = self.host?.lowercased(), host.count > 0 else {
            return false
        }
        
        // I cannot seem to make music video links with Store Product View Controllers, so this code
        // does not handle them. If you find a way please let me know.
        guard !self.path.contains("/music-video/") else {
            return false
        }
        
        guard !host.contains("widgets") else {
            return false
        }
        
        for domain in ["podcasts.apple.com", "itunes.com", "itunes.apple.com", "itun.es", "appstore.com"] {
            if host == domain || host.hasSuffix(String(format: ".%@", domain)) {
                return true
            }
        }
        
        return false
    }
    
}
