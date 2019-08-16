//
//  Ex+String.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Foundation

extension String {
    
    internal func widthWithConstrained(height: CGFloat, font: UIFont) -> CGFloat {
        if self.count == 0 { return 0 }
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).integral.width
    }
}
