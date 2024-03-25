//
//  Extension.swift
//  WWTextDropView
//
//  Created by William-Weng on 2024/3/25.
//  Copyright © 2024年 William-Weng. All rights reserved.
//

import UIKit

// MARK: - CATextLayer (function)
extension CATextLayer {
    
    /// 產生CATextLayer
    /// - Parameters:
    ///   - range: NSRange
    ///   - textStorage: NSTextStorage
    ///   - textLayout: NSLayoutManager
    ///   - textContainer: NSTextContainer
    /// - Returns: CATextLayer
    static func _build(withRange range: NSRange, textStorage: NSTextStorage, textLayout: NSLayoutManager, textContainer: NSTextContainer) -> CATextLayer {
        
        let textLayer = CATextLayer()
        let attributedString = textStorage.attributedSubstring(from: range)
        let glyphRect = textLayout.boundingRect(forGlyphRange: range, in: textContainer)
        
        textLayer.string = attributedString
        textLayer.frame = glyphRect
        textLayer.contentsScale = UIScreen.main.scale

        return textLayer
    }
}

// MARK: - CAAnimation (static function)
extension CAAnimation {
    
    /// [Layer動畫產生器 (CABasicAnimation)](https://jjeremy-xue.medium.com/swift-說說-cabasicanimation-9be31ee3eae0)
    /// - Parameters:
    ///   - keyPath: [要產生的動畫key值](https://blog.csdn.net/iosevanhuang/article/details/14488239)
    ///   - fromValue: 開始的值
    ///   - toValue: 結束的值
    ///   - duration: 動畫時間
    ///   - repeatCount: 播放次數
    ///   - fillMode: [CAMediaTimingFillMode](https://juejin.cn/post/6991371790245183496)
    ///   - isRemovedOnCompletion: [動畫完成後是否要回到原樣？](https://ken-60401.medium.com/swift-animation-初解析-1dfc7d62c312)
    static func _basicAnimation(keyPath: String, fromValue: Any?, toValue: Any?, duration: CFTimeInterval = 5.0, repeatCount: Float = 1.0, fillMode: CAMediaTimingFillMode = .forwards, isRemovedOnCompletion: Bool = false) -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: keyPath)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.fillMode = fillMode
        animation.isRemovedOnCompletion = isRemovedOnCompletion
        
        return animation
    }
}
