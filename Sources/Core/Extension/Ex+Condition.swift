//
//  Ex+Condition.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/13.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Eureka

extension Condition {
    
    public init(_ block: @escaping () -> Bool) {
        self = .function([], { (_) -> Bool in
            return block()
        })
    }
    
    public init(_ block: @escaping (Form) -> Bool) {
        self = .function([], block)
    }
}
