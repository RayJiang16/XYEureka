//
//  XYEurekaConstant.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit

public class XYEurekaConstant {
    
    private static let shared = XYEurekaConstant()
    
    private init() { }
    
    
    private var mainText: UIColor?
    private var subText: UIColor?
    private var redText: UIColor?
    private var pickerText: UIColor?
    private var lineColor: UIColor?
    private var lineEdges: UIEdgeInsets?
    private var titleFont: UIFont?
    private var subFont: UIFont?
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
    public static var pickerText: UIColor {
        get {
            if let color = shared.pickerText { return color }
            return UIColor.mainText
        } set {
            shared.pickerText = newValue
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
    public static var lineEdges: UIEdgeInsets {
        get {
            if let edges = shared.lineEdges { return edges }
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        } set {
            shared.lineEdges = newValue
        }
    }
    public static var titleFont: UIFont {
        get {
            if let font = shared.titleFont { return font }
            return UIFont.systemFont(ofSize: 14)
        } set {
            shared.titleFont = newValue
        }
    }
    public static var subFont: UIFont {
        get {
            if let font = shared.subFont { return font }
            return UIFont.systemFont(ofSize: 14)
        } set {
            shared.subFont = newValue
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
