//
//  XYPickerRow.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka

open class _XYPickerCell<T>: _XYBaseCell<T>, UIPickerViewDataSource, UIPickerViewDelegate where T: Equatable {
    
    public lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    fileprivate var pickerRow: _XYPickerRow<T>? { return row as? _XYPickerRow<T> }
    
    public required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        picker.delegate = nil
        picker.dataSource = nil
    }
    
    override open func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType = .none
        picker.delegate = self
        picker.dataSource = self
    }
    
    override open func update() {
        super.update()
        titleLabel.textColor = row.isHighlighted ? tintColor : XYEurekaConstant.mainText
        
        guard let value = row.value as? XYPickerRowType else { return }
        let text = value.name.isEmpty ? (pickerRow?.noValueDisplayText ?? "") : value.name
        
        if row.title?.isEmpty == false {
            subLabel.text = text
        } else {
            titleLabel.text = text
            subLabel.text = nil
        }
        
        picker.reloadAllComponents()
    }
    
    open override func didSelect() {
        super.didSelect()
        
        if subLabel.text == "" || subLabel.text == pickerRow?.noValueDisplayText {
            if let picker = pickerRow {
                if picker.options.isEmpty {
                    fatalError("Options is empty, please set `row.options`")
                }
                picker.value = picker.options[0]
                update()
            }
        }
    }
    
    open override var inputView: UIView? {
        return picker
    }
    
    open override func cellCanBecomeFirstResponder() -> Bool {
        return canBecomeFirstResponder
    }
    
    override open var canBecomeFirstResponder: Bool {
        return !row.isDisabled
    }
    
    // MARK: - Delegate
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerRow?.options.count ?? 0
    }
    
    open func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str: String
        if let options = pickerRow?.options as? [XYPickerRowType] {
            str = options[row].name
        } else {
            str = pickerRow?.displayValueFor?(pickerRow?.options[row]) ?? ""
        }
        
        let attr = NSMutableAttributedString(string: str)
        attr.addAttribute(.font, value: XYEurekaConstant.subFont, range: NSRange(location: 0, length: attr.length))
        attr.addAttribute(.foregroundColor, value: XYEurekaConstant.pickerText, range: NSRange(location: 0, length: attr.length))
        return attr
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow rowNumber: Int, inComponent component: Int) {
        if let picker = pickerRow, picker.options.count > rowNumber {
            picker.value = picker.options[rowNumber]
            update()
        }
    }
}

public class XYPickerCell<T>: _XYPickerCell<T> where T: Equatable {

    open override func update() {
        super.update()
        if let selectedValue = pickerRow?.value, let index = pickerRow?.options.firstIndex(of: selectedValue) {
            picker.selectRow(index, inComponent: 0, animated: true)
        }
    }
}

// MARK: - XYPickerRow

open class _XYPickerRow<T> : Row<XYPickerCell<T>>, NoValueDisplayTextConformance where T: Equatable {
    
    open var noValueDisplayText: String? = "请选择"
    
    open var options = [T]()
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class XYPickerRow<T>: _XYPickerRow<T>, RowType where T: Equatable, T: XYPickerRowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
