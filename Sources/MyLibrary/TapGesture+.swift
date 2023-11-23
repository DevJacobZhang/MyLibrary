//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/17.
//

import Foundation
import UIKit

extension UITapGestureRecognizer {
    
    // 取得點擊時所對應的 URL
    func getURLFromTap(attributedText: NSAttributedString?, inRange targetRange: NSRange) -> URL? {
        guard let attributedText = attributedText else { return nil }
        
        // 取得點擊時所對應的連結文字
        let linkText = attributedText.attributedSubstring(from: targetRange)
        var urlComponents = URLComponents()
        
        // 將連結文字轉換為 Url(電話)
        urlComponents.scheme = "tel"
        urlComponents.path = linkText.string
        return urlComponents.url
    }
}
