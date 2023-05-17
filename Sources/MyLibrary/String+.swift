//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/17.
//

import Foundation
import UIKit

extension MyLibrary {
    public struct CRString {
        ///將第一個字元改成大寫，其餘後面全部小寫
        static func CRCapitalizeFirstLetter(string: String) -> String {
            return string.prefix(1).uppercased() + string.lowercased().dropFirst()
        }
        
        ///回傳這筆字串在UILabel裡需要多少高
        static func CRCalculateLabelHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.font = font
            label.text = text
            label.sizeToFit()
            return label.frame.height
        }
    }
}
