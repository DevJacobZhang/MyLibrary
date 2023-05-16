//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/16.
//

import Foundation
import UIKit

extension MyLibrary {
    //UIApplication+
    public struct Application {
        //回傳是否有安裝chrome
        static func isChromeInstalled() -> Bool {
            guard let chromeURL = URL(string: "googlechromes://www.tmrt.com.tw") else { return false }
            return UIApplication.shared.canOpenURL(chromeURL)
        }
        
        //打開瀏覽器，有chrome則使用，無則使用safari
        static func openUrl(urlStr: String) {
            var url = URL(string: urlStr)
            if isChromeInstalled() {
                var chromeStr = ""
                if urlStr.contains("https") {
                    chromeStr = urlStr.replacingOccurrences(of: "https", with: "googlechromes")
                } else if urlStr.contains("http") {
                    chromeStr = urlStr.replacingOccurrences(of: "http", with: "googlechrome")
                }
                url = URL(string: chromeStr)
            }
            
            if let url = url {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}

