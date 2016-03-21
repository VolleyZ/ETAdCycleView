//
//  UIView+Frame.swift
//  Baby-Kingdom
//
//  Created by Volley on 16/3/16.
//  Copyright © 2016年 Volley. All rights reserved.
//

import UIKit

/** Frame Extends UIView

*/
extension UIView {
    
    /// origin.X值
    var originX: CGFloat {
        return self.frame.origin.x
    }
    
    /// origin.Y值
    var originY: CGFloat {
        return self.frame.origin.y
    }
    
    /// view宽度
    var size_width: CGFloat {
        return self.frame.size.width
    }
    
    /// view高度
    var size_height: CGFloat {
        return self.frame.size.height
    }
    
    /// view的大小
    var size: CGSize {
        return self.frame.size
    }
    
    /// view的当前位置
    var point: CGPoint {
        return self.frame.origin
    }
}
