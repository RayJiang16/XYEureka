//
//  Ex+Section.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Eureka

extension Section {
    
    public func updateAllCell() {
        for row in allRows {
            row.updateCell()
        }
    }
    
    public func setEnabled(_ enabled: Bool) {
        for row in allRows {
            row.disabled = Condition(booleanLiteral: !enabled)
            row.evaluateDisabled()
        }
    }
    
    public func setHidden(_ hidden: Bool) {
        for row in allRows {
            row.hidden = Condition(booleanLiteral: hidden)
            row.evaluateHidden()
        }
    }
    
}
