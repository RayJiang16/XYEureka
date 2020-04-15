//
//  XYDatePickerRow.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka

public enum XYDatePickerStyle: Int {
    case year = 0
    case month
    case day
}

open class _XYDatePickerCell: _XYBaseCell<Date>, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public var style: XYDatePickerStyle = .day
    public var minDate: Date = Date(timeIntervalSince1970: 946656000)  // 2000-01-01
    public var maxDate: Date = Date(timeIntervalSince1970: 4102415999) // 2099-12-31
    public var initDate: Date = Date() {
        didSet {
            pickerRow?.value = initDate
        }
    }
    
    private var yearList: [Int] = []
    private var monthList: [Int] = []
    private var dayList: [Int] = []
    
    private var selectYear: Int = 0
    private var selectMonth: Int = 0
    private var selectDay: Int = 0
    
    fileprivate var pickerRow: _XYDatePickerRow? { return row as? _XYDatePickerRow }
    
    public lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
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
    
    open override func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType = .none
        picker.delegate = self
        picker.dataSource = self
        selectInitDate(initDate)
    }
    
    override open func update() {
        super.update()
        titleLabel.textColor = row.isHighlighted ? tintColor : XYEurekaConstant.mainText
        
        guard let value = pickerRow?.dateStr else { return }
        let text = value.isEmpty ? (pickerRow?.noValueDisplayText ?? "") : value
        
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
        
        if let selectDate = row.value {
            selectInitDate(selectDate)
        } else {
            selectInitDate(initDate)
        }
        if subLabel.text == "" || subLabel.text == pickerRow?.noValueDisplayText {
            row.value = getDate()
            update()
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
    
    // MARK: - Function
    
    private func selectInitDate(_ date: Date) {
        if date.timeIntervalSince1970 >= minDate.timeIntervalSince1970 && date.timeIntervalSince1970 <=
            maxDate.timeIntervalSince1970 {
            let format = DateFormatter()
            format.dateFormat = "yyyy"
            let initYear = Int(format.string(from: date)) ?? 0
            format.dateFormat = "MM"
            let initMonth = Int(format.string(from: date)) ?? 0
            format.dateFormat = "dd"
            let initDay = Int(format.string(from: date)) ?? 0
            
            yearList = getYear()
            guard yearList.count > 0 else { return }
            guard let yearIdx = yearList.firstIndex(where: { $0 == initYear }) else { return }
            selectYear = yearIdx
            monthList = getMonth()
            guard monthList.count > 0, (style == .month || style == .day) else { selectDate(); return }
            guard let monthIdx = monthList.firstIndex(where: { $0 == initMonth }) else { selectDate(); return }
            selectMonth = monthIdx
            dayList = getDay()
            guard dayList.count > 0, style == .day else { selectDate(); return }
            guard let dayIdx = dayList.firstIndex(where: { $0 == initDay }) else { selectDate(); return }
            selectDay = dayIdx
            selectDate()
        }
    }
    
    private func selectDate() {
        picker.reloadAllComponents()
        picker.selectRow(selectYear, inComponent: 0, animated: false)
        if style == .month || style == .day {
            picker.selectRow(selectMonth, inComponent: 1, animated: false)
            if style == .day {
                picker.selectRow(selectDay, inComponent: 2, animated: false)
            }
        }
    }
    
    private func getDate() -> Date {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let year = yearList[selectYear]
        if style == .year {
            return format.date(from: "\(year)") ?? Date()
        }
        guard monthList.count > 0 else { return Date() }
        format.dateFormat = "yyyyMM"
        let month = monthList[selectMonth]
        let monthStr = month < 10 ? "0\(month)" : "\(month)"
        if style == .month {
            return format.date(from: "\(year)\(monthStr)") ?? Date()
        }
        guard dayList.count > 0 else { return Date() }
        format.dateFormat = "yyyyMMdd"
        let day = dayList[selectDay]
        let dayStr = day < 10 ? "0\(day)" : "\(day)"
        return format.date(from: "\(year)\(monthStr)\(dayStr)") ?? Date()
    }
    
    private func getMinAndMax(_ dateFormat: String) -> (Int, Int) {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        guard let min = Int(format.string(from: minDate)) else { return (0, 0) }
        guard let max = Int(format.string(from: maxDate)) else { return (0, 0) }
        return (min, max)
    }
    
    private func getYear() -> [Int] {
        let minMax = getMinAndMax("yyyy")
        let minYear = minMax.0
        let maxYear = minMax.1
        
        var list: [Int] = []
        for year in minYear...maxYear {
            list.append(year)
        }
        return list
    }
    
    private func getMonth() -> [Int] {
        let minMax = getMinAndMax("MM")
        let minMonth = minMax.0
        let maxMonth = minMax.1
        
        var list: [Int] = []
        let year = yearList[selectYear]
        for month in 1...12 {
            if let minYear = yearList.first, minYear == year, month < minMonth {
                continue
            }
            if let maxYear = yearList.last, maxYear == year, month > maxMonth {
                continue
            }
            list.append(month)
        }
        return list
    }
    
    private func getDay() -> [Int] {
        let minMax = getMinAndMax("dd")
        let minDay = minMax.0
        let maxDay = minMax.1
        
        var list: [Int] = []
        let year = yearList[selectYear]
        let minYear = yearList.first ?? 2000
        let maxYear = yearList.last ?? 2019
        let minMonth = monthList.first ?? 1
        let maxMonth = monthList.last ?? 12
        let month = monthList[selectMonth]
        for day in 1...31 {
            if minYear == year, minMonth == month, day < minDay { continue }
            if maxYear == year, maxMonth == month, day > maxDay { continue }
            if day <= 28 {
                list.append(day)
                continue
            }
            
            switch month {
            case 2:
                if day == 29 {
                    if year % 400 == 0 {
                        list.append(day)
                    } else if year % 4 == 0 && year % 100 != 0 {
                        list.append(day)
                    }
                }
                continue
            case 4, 6, 9, 11:
                if day > 30 {
                    continue
                }
            default:
                break
            }
            list.append(day)
        }
        return list
    }
    
    
    // MARK: - Delegate
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let type = XYDatePickerStyle(rawValue: component) else { return }
        switch type {
        case .year:
            selectYear = row
            if style == .month || style == .day {
                monthList = getMonth()
                if selectMonth >= monthList.count {
                    selectMonth = monthList.count-1
                }
                if style == .day {
                    dayList = getDay()
                    if selectDay >= dayList.count {
                        selectDay = dayList.count-1
                    }
                }
            }
        case .month:
            selectMonth = row
            if style == .day {
                dayList = getDay()
                if selectDay >= dayList.count {
                    selectDay = dayList.count-1
                }
            }
        case .day:
            selectDay = row
        }
        pickerView.reloadAllComponents()
        
        self.row.value = getDate()
        update()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch style {
        case .year:
            return 1
        case .month:
            return 2
        case .day:
            return 3
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let type = XYDatePickerStyle(rawValue: component) else { return 0 }
        switch type {
        case .year:
            return yearList.count
        case .month:
            return monthList.count
        case .day:
            return dayList.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let type = XYDatePickerStyle(rawValue: component) else { return nil }
        var str = ""
        switch type {
        case .year:
            str = "\(yearList[row])年"
        case .month:
            str = "\(monthList[row])月"
        case .day:
            str = "\(dayList[row])日"
        }
        
        let attr = NSMutableAttributedString(string: str)
        attr.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: 0, length: attr.length))
        attr.addAttribute(.foregroundColor, value: XYEurekaConstant.mainText, range: NSRange(location: 0, length: attr.length))
        return attr
    }
    
}

public class XYDatePickerCell: _XYDatePickerCell {
    open override func update() {
        super.update()
//        if let selectedValue = pickerRow?.value, let index = pickerRow?.options.firstIndex(of: selectedValue) {
//            picker.selectRow(index, inComponent: 0, animated: true)
//        }
    }
    
}

// MARK: - XYDatePickerRow

open class _XYDatePickerRow: Row<XYDatePickerCell>, NoValueDisplayTextConformance {
    
    open var noValueDisplayText: String? = "请选择"
    
    /// 日期解析格式 默认 yyyy-MM-dd
    open var format: String = "yyyy-MM-dd" {
        didSet {
            dateFormatter.dateFormat = format
        }
    }
    
    /// 日期字符串
    public var dateStr: String {
        get {
            guard let date = value else { return "" }
            return dateFormatter.string(from: date)
        } set {
            if let date = dateFormatter.date(from: newValue), !newValue.isEmpty {
                value = date
            }
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter
    }()
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class XYDatePickerRow: _XYDatePickerRow, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
