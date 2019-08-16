//
//  XYFormViewController.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import Eureka
import SnapKit

public typealias XYFormCallback = () -> Void

open class XYFormViewController: FormViewController {

    private var callbackDict: [String:XYFormCallback?] = [:]
    
    open override func valueHasBeenChanged(for: BaseRow, oldValue: Any?, newValue: Any?) {
        let row = `for`
        guard let tag = row.tag, let callback = callbackDict[tag] else { return }
        callback?()
        row.updateCell()
    }
    
    public func observe(tag: String?, _ callback: XYFormCallback?) {
        guard let tag = tag else { return }
        callbackDict[tag] = callback
    }

}
