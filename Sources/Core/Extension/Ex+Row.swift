//
//  Ex+Row.swift
//  XYEureka
//
//  Created by Ray on 2020/3/27.
//  Copyright © 2020 RayJiang. All rights reserved.
//

import Eureka

extension Row: XYBaseProtocol {
    
    public var hasMustAndArrow: Bool {
        get {
            guard let cell = cell as? XYBaseProtocol else { return false }
            return cell.hasMust && cell.hasArrow
        } set {
            hasMust = newValue
            hasArrow = newValue
        }
    }
    public var hasMust: Bool {
        get {
            guard let cell = cell as? XYBaseProtocol else { return false }
            return cell.hasMust
        } set {
            guard var cell = cell as? XYBaseProtocol else { return }
            cell.hasMust = newValue
        }
    }
    public var hasArrow: Bool {
        get {
            guard let cell = cell as? XYBaseProtocol else { return false }
            return cell.hasArrow
        } set {
            guard var cell = cell as? XYBaseProtocol else { return }
            cell.hasArrow = newValue
        }
    }
    
}
