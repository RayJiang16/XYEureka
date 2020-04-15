//
//  XYFieldCell.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka

open class _XYFieldCell<T> : _XYBaseCell<T>, UITextFieldDelegate, TextFieldCell where T: Equatable, T: InputTypeInitiable {
    
    public var textField: UITextField!
    
    public required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        textField.delegate = nil
    }
    
    open override func setup() {
        super.setup()
        height = { 44 }
        
        selectionStyle = .none
        textField = UITextField()
        textField.delegate = self
        textField.textColor = XYEurekaConstant.subText
        textField.font = XYEurekaConstant.subFont
        textField.textAlignment = .right
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addSubview(textField)
        textField.snp.remakeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(snp.centerX).offset(-100)
            maker.right.equalTo(subLabel.snp.left).offset(-3)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let width = (subLabel.text ?? "").widthWithConstrained(height: 1000, font: subLabel.font)
        subLabel.snp.remakeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(width)
        }
    }
    
    open override func update() {
        selectionStyle = row.isDisabled ? .none : .default
        if row.isDisabled {
            hasMust = false
        }
        titleLabel.text = row.title
        super.layoutSubviews()
        titleLabel.textColor = row.isHighlighted ? tintColor : XYEurekaConstant.mainText
        
        if textField.isFirstResponder { return }
        
        textField.text = row.displayValueFor?(row.value)
        textField.isEnabled = !row.isDisabled
        if let placeholder = (row as? FieldRowConformance)?.placeholder {
            if let color = (row as? FieldRowConformance)?.placeholderColor {
                textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: color, .font:XYEurekaConstant.subFont])
            } else {
                textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font:XYEurekaConstant.subFont])
            }
        }
    }
    
    open override func cellCanBecomeFirstResponder() -> Bool {
        return !row.isDisabled && textField.canBecomeFirstResponder == true
    }
    
    open override func cellBecomeFirstResponder(withDirection: Direction) -> Bool {
        return textField.becomeFirstResponder()
    }
    
    open override func cellResignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    @objc open func textFieldDidChange(_ textField: UITextField) {
        
        guard let textValue = textField.text else {
            row.value = nil
            return
        }
        guard let fieldRow = row as? FieldRowConformance, let formatter = fieldRow.formatter else {
            row.value = textValue.isEmpty ? nil : (T.init(string: textValue) ?? row.value)
            return
        }
        if fieldRow.useFormatterDuringInput {
            let unsafePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
            defer {
                unsafePointer.deallocate()
            }
            let value: AutoreleasingUnsafeMutablePointer<AnyObject?> = AutoreleasingUnsafeMutablePointer<AnyObject?>.init(unsafePointer)
            let errorDesc: AutoreleasingUnsafeMutablePointer<NSString?>? = nil
            if formatter.getObjectValue(value, for: textValue, errorDescription: errorDesc) {
                row.value = value.pointee as? T
                guard var selStartPos = textField.selectedTextRange?.start else { return }
                let oldVal = textField.text
                textField.text = row.displayValueFor?(row.value)
                selStartPos = (formatter as? FormatterProtocol)?.getNewPosition(forPosition: selStartPos, inTextInput: textField, oldValue: oldVal, newValue: textField.text) ?? selStartPos
                textField.selectedTextRange = textField.textRange(from: selStartPos, to: selStartPos)
                return
            }
        } else {
            let unsafePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
            defer {
                unsafePointer.deallocate()
            }
            let value: AutoreleasingUnsafeMutablePointer<AnyObject?> = AutoreleasingUnsafeMutablePointer<AnyObject?>.init(unsafePointer)
            let errorDesc: AutoreleasingUnsafeMutablePointer<NSString?>? = nil
            if formatter.getObjectValue(value, for: textValue, errorDescription: errorDesc) {
                row.value = value.pointee as? T
            } else {
                row.value = textValue.isEmpty ? nil : (T.init(string: textValue) ?? row.value)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func displayValue(useFormatter: Bool) -> String? {
        guard let v = row.value else { return nil }
        if let formatter = (row as? FormatterConformance)?.formatter, useFormatter {
            return textField.isFirstResponder == true ? formatter.editingString(for: v) : formatter.string(for: v)
        }
        return String(describing: v)
    }
    
    // MARK: - TextFieldDelegate
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        formViewController()?.beginEditing(of: self)
        formViewController()?.textInputDidBeginEditing(textField, cell: self)
        if let fieldRowConformance = row as? FormatterConformance, let _ = fieldRowConformance.formatter, fieldRowConformance.useFormatterOnDidBeginEditing ?? fieldRowConformance.useFormatterDuringInput {
            textField.text = displayValue(useFormatter: true)
        } else {
            textField.text = displayValue(useFormatter: false)
        }
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        formViewController()?.endEditing(of: self)
        formViewController()?.textInputDidEndEditing(textField, cell: self)
        textFieldDidChange(textField)
        textField.text = displayValue(useFormatter: (row as? FormatterConformance)?.formatter != nil)
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return formViewController()?.textInputShouldReturn(textField, cell: self) ?? true
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let limit = row as? XYTextLimit else { return true }
        if string.isEmpty || limit.textLimit == 0 { return true }
        let count = (textField.text?.count ?? 0) + string.count
        return count <= limit.textLimit
    }
    
    open func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return formViewController()?.textInputShouldBeginEditing(textField, cell: self) ?? true
    }
    
    open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return formViewController()?.textInputShouldClear(textField, cell: self) ?? true
    }
    
    open func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return formViewController()?.textInputShouldEndEditing(textField, cell: self) ?? true
    }
}

// MARK: - Field Row

open class XYFieldRow<Cell: CellType>: FieldRow<Cell>, XYTextLimit where Cell: BaseCell, Cell: TextFieldCell {
    
    /// 字数限制，0=无限制
    open var textLimit: Int = 0
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
