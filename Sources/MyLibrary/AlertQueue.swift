//
//  AlertQueue.swift
//  WhiskeyLibrary
//
//  Created by 張家豪 on 2023/9/6.
//

import Foundation
import UIKit

class AlertQueue {
    private init() {}
    
    static let sharedQueue = AlertQueue()
    
    private var alertQueue: [UIAlertController] = []
    private var isAlertShowing = false
    
    //標準版
    func enqueueAlert(alert: UIAlertController, actionTitles: [String], withHandlers handlers: [ () -> Void]) {
        for i in 0 ..< actionTitles.count {
            let actionTitle = actionTitles[i]
            let actionHandler = handlers[i]
            let customAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
                actionHandler()
                self.isAlertShowing = false
                self.showNextAlert()
            }
            
            alert.addAction(customAction)
        }
        
        alertQueue.append(alert)
        showNextAlert()
    }
    
    //簡易版
    func enqueueAlertWithNormal(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionAlert = UIAlertAction(title: "確認", style: .default) { (action) in
            self.isAlertShowing = false
            self.showNextAlert()
        }
        alert.addAction(actionAlert)
        
        alertQueue.append(alert)
        showNextAlert()
    }
    
    private func showNextAlert() {
        if !isAlertShowing && !alertQueue.isEmpty {
            let alert = alertQueue.removeFirst()
            isAlertShowing = true
            
            if let rootViewController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
                rootViewController.present(alert, animated: true) {
                    // Alert顯示完成後調用的completion block，非點擊確認鈕後執行！
                    
                }
            }
        }
    }
}
