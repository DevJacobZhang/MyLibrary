//
//  File.swift
//  
//
//  Created by 張家豪 on 2023/5/17.
//

import Foundation
import UIKit

extension MyLibrary {
    public class CRView {
        ///設置圓角
        static public func CRAddRoundedCorners(view: UIView, corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            view.layer.mask = maskLayer
        }
    }
}

