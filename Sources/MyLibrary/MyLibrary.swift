import Foundation
import UIKit

extension UIView {
    ///設置圓角
    public func CRAddRoundedCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

extension String {
    ///將第一個字元改成大寫，其餘後面全部小寫
    func CRCapitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    ///回傳這筆字串在UILabel裡需要多少高
    func CRCalculateLabelHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
}

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

