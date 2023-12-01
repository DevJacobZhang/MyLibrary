//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/17.
//

import Foundation
import UIKit

enum RegexType {
    case Phone
    case Email
    case Password
    case Name
}

extension MyLibrary {
    public struct CRString {
        ///將第一個字元改成大寫，其餘後面全部小寫
        internal static func CRCapitalizeFirstLetter(string: String) -> String {
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
        
        ///將整組字串裡的電話號碼轉成超連結，使用Attribute字串做超連結時，記得用textView做，telTextView.attributedText = ....
        static func getTelAttributedString(text: String) -> NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(string:text)
                    
            let patterns = [
                "\\d{10}",                          // 0800123456, //0425212345, //0980123456
                "\\d{2}-\\d{7,8}",                  //  02-25212345
                "\\(\\d{2}\\)\\d{7,8}",             // (02)25212345
                "\\(\\d{2}\\)-\\d{7,8}",            // (02)-25212345
                "\\(\\d{2}\\)\\d{3}-\\d{5}",        // (02)252-12345
                "\\(\\d{2}\\)\\d{4}-\\d{4}",        // (02)2521-2345
                "\\(\\d{2}\\)-\\d{4}-\\d{4}",       // (02)-2521-2345
                "\\d{2}-\\d{4}-\\d{4}",             //  02-2521-2345
                "\\(\\d{2}\\) \\d{8}",              // (02) 25212345
                "\\(\\d{2}\\)\\d{3}-\\d{3}-\\d{2}", // (02)252-123-45
                "\\d{4}-\\d{6}",                    //  0800-123456, 0980-123456
                "\\d{4}-\\d{3}-\\d{3}",             //  0800-123-456, 0980-123-456
                "\\(\\d{4}\\)\\d{6}",               // (0800)123456
                "\\(\\d{4}\\)-\\d{6}",              // (0800)-123465
                "\\(\\d{4}\\)-\\d{3}-\\d{3}",       // (0800)-123-456
                
            ]
            
            //將pattern轉換成一組字串並用"|"做間隔
            var phoneNumberPatterns = ""
            for (i,pattern) in patterns.enumerated() {
                phoneNumberPatterns += "\(pattern)\( i == patterns.count - 1 ? "" : "|")"
            }
            
            if let phoneNumberRegex = try? NSRegularExpression(pattern: phoneNumberPatterns, options: []) {
                //在規則內找出整筆字串長度中符合規得的字串
                let matches = phoneNumberRegex.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
                //將每個找到的符合規則的字串前面加上tel:// 並加回到原字串裡的相同位置
                for match in matches.reversed() {
                    let phoneNumber = (text as NSString).substring(with: match.range)
                    let range = Range(match.range, in: text)!
                    let phoneNumberLink = "tel://" + phoneNumber
                    //將此筆電話字串加入連結功能
                    attributedString.addAttribute(.link, value: phoneNumberLink, range: NSRange(range, in: text))
                    let font = UIFont.systemFont(ofSize: 16)
                    //將此筆電話字串加入特定大小
                    attributedString.addAttribute(.font, value: font.withSize(16), range: NSRange(location: 0, length: attributedString.length))
                }
            }
            return attributedString
        }
        
        ///依照指定形式檢查字串是否通過驗證
        func checkRegex(str: String, type: RegexType) -> Bool {
            var pattern = ""
            
            switch type {
            case .Phone:
                pattern = "^[0-9]{10}$"
            case .Email:
                pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            case .Password:
                pattern = "^[A-Z0-9a-z]{6,}$"
            case .Name:
                pattern = "^[\\u4e00-\\u9fffa-zA-Z0-9]{1,10}$"
            }
            
            let regex = try! NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: str.utf16.count)
            let isMatch = regex.firstMatch(in: str, range: range) != nil
            
            return isMatch
        }
    }
}
