//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/17.
//

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

