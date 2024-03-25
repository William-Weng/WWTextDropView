//
//  WWTextDropViewDelegate.swift
//  WWTextDropView
//
//  Created by William-Weng on 2024/3/25.
//  Copyright © 2024年 William-Weng. All rights reserved.
//

import Foundation

// MARK: - WWTextDropViewDelegate
public protocol WWTextDropViewDelegate: AnyObject {
    
    /// 文字數量
    /// - Parameters:
    ///   - view: WWTextDropView
    ///   - currentRange: 原本文字的數量
    ///   - maxRange: 畫面能容納的文字數量
    func textRange(_ view: WWTextDropView, currentRange: Int, maxRange: Int)
}
