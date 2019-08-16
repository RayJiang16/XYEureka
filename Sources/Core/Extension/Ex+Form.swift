//
//  Ex+Form.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/13.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Eureka

extension Form {
    
    public func evaluateHidden() {
        for section in allSections {
            for row in section.allRows {
                row.evaluateHidden()
            }
            section.evaluateHidden()
        }
    }
    
    public func evaluateHidden(section: String) {
        guard let section = sectionBy(tag: section) else { return }
        for row in section.allRows {
            row.evaluateHidden()
        }
    }
    
    
    public func evaluateDisabled() {
        for section in allSections {
            for row in section.allRows {
                row.evaluateDisabled()
            }
        }
    }
    
    public func evaluateDisabled(section: String) {
        guard let section = sectionBy(tag: section) else { return }
        for row in section.allRows {
            row.evaluateDisabled()
        }
    }
    
    
    public func reloadData() {
        for section in allSections {
            for row in section.allRows {
                row.updateCell()
            }
        }
    }
    
    public func reloadData(section: String) {
        guard let section = sectionBy(tag: section) else { return }
        for row in section.allRows {
            row.updateCell()
        }
    }
    
}
