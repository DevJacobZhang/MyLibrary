import Foundation
import UIKit

public struct MyLibrary {
    
    ///取得UIWindow
    static public func getKeyWindow() -> UIWindow? {
        
        let keyWindow: UIWindow = {
            var window: UIWindow = UIApplication.shared.keyWindow!
            if #available(iOS 13.0, *) {
                window = (UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .map({ $0 as? UIWindowScene })
                    .compactMap({ $0 })
                    .last?.windows
                    .filter({ $0.isKeyWindow })
                    .last)!
            }
            return window
        }()
        
        return keyWindow
    }
}

