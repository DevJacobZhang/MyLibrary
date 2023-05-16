import Foundation
import UIKit

public struct MyLibrary {
    
    ///將第一個字元改成大寫，其餘後面全部小寫
    static public func capitalizeFirstLetter(string: String) -> String {
        return string.prefix(1).uppercased() + string.lowercased().dropFirst()
    }
    
    ///設置圓角
    static public func addRoundedCorners(view: UIView, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    ///回傳這筆字串在UILabel裡需要多少高
    static public func calculateLabelHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
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

