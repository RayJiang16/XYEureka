//
//  XYConstant.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit

public class XYConstant {
    
    private static let shared = XYConstant()
    
    private init() { }
    
    
    private var mainText: UIColor?
    private var subText: UIColor?
    private var redText: UIColor?
    private var lineColor: UIColor?
    private var hiddenMustDotWhenDisabled: Bool = true
    
    
    public static var mainText: UIColor {
        get {
            if let color = shared.mainText { return color }
            return UIColor.mainText
        } set {
            shared.mainText = newValue
        }
    }
    public static var subText: UIColor {
        get {
            if let color = shared.subText { return color }
            return UIColor.subText
        } set {
            shared.subText = newValue
        }
    }
    public static var redText: UIColor {
        get {
            if let color = shared.redText { return color }
            return UIColor.redText
        } set {
            shared.redText = newValue
        }
    }
    public static var lineColor: UIColor {
        get {
            if let color = shared.lineColor { return color }
            return UIColor.lineColor
        } set {
            shared.lineColor = newValue
        }
    }
    public static var hiddenMustDotWhenDisabled: Bool {
        get {
            return shared.hiddenMustDotWhenDisabled
        } set {
            shared.hiddenMustDotWhenDisabled = newValue
        }
    }
    
    
}
