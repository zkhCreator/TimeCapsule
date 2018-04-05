//
//  UIExtension.swift
//  TimeCapsule
//
//  Created by 章凯华 on 2018/4/5.
//  Copyright © 2018 zkhCreator. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 获得渐变色的图片，从左上角到右下角
    ///
    /// - Parameters:
    ///   - startColor: 开始的时候的点的颜色，默认为 deepColor
    ///   - endColor: 结束的时候的点的颜色， 默认为 lightColor
    ///   - size: 需要设置的图片的尺寸
    /// - Returns: 渐变的 view
    convenience init(startColor:UIColor = deepColor, endColor:UIColor = lightColor, size:CGSize, fromPoint:CGPoint = CGPoint.zero, endPoint:CGPoint = CGPoint.init(x: 1, y: 1)) {
        self.init(size: size)
        let gradientLayer = CAGradientLayer.init(startColor: startColor, endColor: endColor, size: size, fromPoint: fromPoint, endPoint: endPoint)
        self.layer.addSublayer(gradientLayer)
    }
}

extension UIImage {
    func tintImage(tintColor:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        tintColor.setFill()
        let bounds = CGRect.init(origin: CGPoint.zero, size: self.size)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let tintImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintImage!
    }
}

extension UIButton {
    // 完成，关闭按钮，默认为 28 个点
    convenience init(image:UIImage) {
        self.init(type: .custom)
        self.frame = CGRect.init(x: 0, y: 0, width: 28.0, height: 28.0)
        self.setImage(image, for: .normal)
    }
}

extension CAGradientLayer {
    
    /// 圆形渐变图层
    ///
    /// - Parameters:
    ///   - startColor: 开始的颜色
    ///   - endColor: 结束的颜色
    ///   - size: 尺寸
    ///   - fromPoint: 开始的位置，百分比
    ///   - endPoint: 结束的位置，百分比
    convenience init(startColor:UIColor = deepColor, endColor:UIColor = lightColor, size:CGSize, fromPoint:CGPoint = CGPoint.zero, endPoint:CGPoint = CGPoint.init(x: 1, y: 1)) {
        self.init()
        self.frame = CGRect.init(origin: CGPoint.zero, size: size)
        self.startPoint = fromPoint
        self.endPoint = endPoint
        self.colors = [startColor.cgColor, endColor.cgColor]
    }
}

extension CALayer {
    func setupShadow(color: UIColor = .black, alpha: Float = 0.15, x: CGFloat = 0, y: CGFloat = 0, blur: CGFloat = 0, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath.init(roundedRect: rect, cornerRadius: rect.width / 2.0).cgPath
        }
    }
}

extension UIColor {
    convenience init(redHexColor:CGFloat, greenHexColor:CGFloat, blueHexColor:CGFloat) {
        assert(redHexColor >= 0 && redHexColor <= 255, "Invalid red component")
        assert(greenHexColor >= 0 && greenHexColor <= 255, "Invalid green component")
        assert(blueHexColor >= 0 && blueHexColor <= 255, "Invalid blue component")
        self.init(red: redHexColor / 255.0 , green: greenHexColor / 255.0, blue: blueHexColor / 255.0, alpha: 1)
    }
    
    convenience init(hexColor:Int) {
        self.init(redHexColor: CGFloat((hexColor >> 16) & 0xff),
                  greenHexColor: CGFloat((hexColor >> 8) & 0xff),
                  blueHexColor:CGFloat(hexColor & 0xff))
    }
}
