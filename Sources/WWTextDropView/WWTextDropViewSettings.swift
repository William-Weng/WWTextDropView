//
//  WWTextDropViewSettings.swift
//  WWTextDropView
//
//  Created by William-Weng on 2024/3/25.
//  Copyright © 2024年 William-Weng. All rights reserved.
//

import UIKit

// MARK: - WWTextDropViewSettings
class WWTextDropViewSettings {
    
    let textContainer = NSTextContainer()
    let textLayout = NSLayoutManager()
    let textStorage = NSTextStorage(string: "")
    
    var textLayers = [CALayer]()
    var textLayerPostions = [CGPoint]()
    
    /// 尺寸 / NSLayoutManagerDelegate設定
    /// - Parameter delegate: UIView & NSLayoutManagerDelegate
    func configure(delegate: UIView & NSLayoutManagerDelegate) {
        
        delegate.layoutIfNeeded()
        
        textContainer.size = delegate.bounds.size
        textContainer.maximumNumberOfLines = 0
        textLayout.addTextContainer(textContainer)
        textLayout.delegate = delegate
        textStorage.addLayoutManager(textLayout)
    }
    
    /// 清除跟文字Layer相關的設定
    func clearLayer() {
        textLayers.removeAll()
        textLayerPostions.removeAll()
    }
    
    /// 文字掉落效果
    /// - Parameters:
    ///   - duration: CFTimeInterval
    ///   - positionY: CGFloat
    func textDropEffect(duration: CFTimeInterval, from positionY: CGFloat) {
        
        for (index, item) in textLayers.enumerated() {
            item.position = textLayerPostions[index]
            item.removeAllAnimations()
        }
        
        for (index,item) in textLayers.enumerated() {
            
            let position = textLayerPostions[index]
            let point = CGPoint(x: item.position.x, y: positionY)
            let animation = CAAnimation._basicAnimation(keyPath: "position", fromValue: point, toValue: position, duration: duration)
            
            animation.beginTime = CACurrentMediaTime() + Double(index) * duration
            item.position = point
            item.add(animation, forKey: "TextDropEffect-\(index)")
        }
    }
    
    /// 文字旋轉效果
    /// - Parameters:
    ///   - duration: CFTimeInterval
    ///   - radian: CGFloat
    func textRotateEffect(duration: CFTimeInterval, radian: CGFloat) {
        
        for item in textLayers {
            
            var transform = CATransform3DRotate(item.transform, radian, 0, 0, 1)
            transform.m34 = 0.1 / 400.0
                        
            let animation = CAAnimation._basicAnimation(keyPath: "transform", fromValue: transform, toValue: item.transform)
            item.add(animation, forKey: "TextRotateEffect")
        }
    }
}
