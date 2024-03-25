//
//  WWTextDropView.swift
//  WWTextDropView
//
//  Created by William-Weng on 2024/3/25.
//  Copyright © 2024年 William-Weng. All rights reserved.
//

import UIKit

// MARK: - WWTextDropView
open class WWTextDropView: UIView {
    
    private let settings = WWTextDropViewSettings()
    
    public var text: String? { didSet { storeText(text) }}
    
    private var attributes: [NSAttributedString.Key: Any]? = nil
    private weak var delegate: WWTextDropViewDelegate?
}

// MARK: - NSLayoutManagerDelegate
extension WWTextDropView: NSLayoutManagerDelegate {
        
    public func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool) {
        if (layoutFinishedFlag) { clean(); appendTextLayers(text) }
    }
}

// MARK: - 公開函式
public extension WWTextDropView {
    
    /// [設定初值](https://www.twblogs.net/a/5ed27ce7c01f4b18418c8754)
    /// - Parameters:
    ///   - delegate: WWTextDropViewDelegate?
    ///   - attributes: [NSAttributedString.Key : Any]?
    func configure(delegate: WWTextDropViewDelegate? = nil, attributes: [NSAttributedString.Key : Any]? = nil) {
        self.attributes = attributes
        self.delegate = delegate
        initSetting()
    }
    
    /// [文字掉落效果](https://juejin.cn/post/6844903621553831944)
    /// - Parameters:
    ///   - duration: CFTimeInterval
    ///   - positionY: CGFloat
    func textDropEffect(duration: CFTimeInterval, from positionY: CGFloat = -100) {
        settings.textDropEffect(duration: duration, from: positionY)
    }
    
    /// [文字旋轉效果](https://blog.csdn.net/GGGHub/article/details/50114853)
    /// - Parameters:
    ///   - duration: CFTimeInterval
    ///   - radian: CGFloat
    func textRotateEffect(duration: CFTimeInterval, radian: CGFloat = .pi * 0.25) {
        settings.textRotateEffect(duration: duration, radian: radian)
    }
}

// MARK: - 小工具
private extension WWTextDropView {
    
    /// 初始化NSLayoutManager相關設定
    func initSetting() {
        settings.configure(delegate: self)
    }
    
    /// 把字先存起來
    /// - Parameter text: String?
    func storeText(_ text: String?) {
        
        let string = text ?? ""
        let attributedString = NSAttributedString(string: string, attributes: attributes)
                
        clean()
        settings.textStorage.setAttributedString(attributedString)
        delegateAction(with: settings)
    }
        
    /// 把字一個個加上去
    /// - Parameter text: String?
    func appendTextLayers(_ text: String?) {
        
        guard let text = text else { return }
        
        var index = 0
        
        while (index < text.count) {
            
            let range = NSRange(location: index, length: 1)
            let characterRange = settings.textLayout.characterRange(forGlyphRange: range, actualGlyphRange: nil)
            
            appendTextLayer(range: range)
            index += characterRange.length
        }
    }
    
    /// 把範圍內的TextLayer加上去
    /// - Parameter range: NSRange
    func appendTextLayer(range: NSRange) {
        
        let textLayer = CATextLayer._build(withRange: range, textStorage: settings.textStorage, textLayout: settings.textLayout, textContainer: settings.textContainer)
        
        layer.addSublayer(textLayer)
        settings.textLayers.append(textLayer)
        settings.textLayerPostions.append(textLayer.position)
    }
    
    /// 清除文字
    func clean() {
        layer.sublayers = []
        settings.clearLayer()
    }
    
    /// 傳出文字數量 (WWTextDropViewDelegate)
    /// - Parameter settings: WWTextDropViewSettings
    func delegateAction(with settings: WWTextDropViewSettings) {
        
        let currentRange = settings.textLayout.numberOfGlyphs
        let maxRange = maxRange(with: settings)
        
        delegate?.textRange(self, currentRange: currentRange, maxRange: maxRange)
    }
    
    /// [在該View的範圍內最多能容納的字數](https://stackoverflow.com/questions/64215124/nslayoutmanager-numberofglyphs-always-showing-0-swift)
    /// - Parameter settings: WWTextDropViewSettings
    /// - Returns: Int
    func maxRange(with settings: WWTextDropViewSettings) -> Int {
        let range = NSMaxRange(settings.textLayout.glyphRange(for: settings.textContainer))
        return range
    }
}
