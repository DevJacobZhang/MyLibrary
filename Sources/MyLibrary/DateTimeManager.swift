//
//  DateTimeManager.swift
//  WhiskeyLibrary
//
//  Created by 張家豪 on 2023/9/18.
//

import Foundation

extension MyLibrary {
    public class DateTimeManager {
        private init() {}
        
        static func getDate_Now(formatter: DateTimeFormatter) -> String {
            let dateFormatter = DateFormatter()
            
            switch formatter {
            case .formatter1:
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
            case .formatter2:
                dateFormatter.dateFormat = "yyyy/MM/dd"
                
            case .formatter3:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            }
            
            let date = Date()
            let formattedDate = dateFormatter.string(from: date)
            
            return formattedDate
        }
    }
}
enum DateTimeFormatter {
    ///yyyy-MM-dd
    case formatter1
    ///yyyy/MM/dd
    case formatter2
    ///yyyy-MM-dd HH:mm:ss
    case formatter3
}


