//
//  XYFieldsRow.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka

// MARK: - Text Cell

open class XYTextCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .sentences
        textField.keyboardType = .default
    }
}

public final class XYTextRow: XYFieldRow<XYTextCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Int Cell

open class XYIntCell: _XYFieldCell<Int> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .default
        textField.autocapitalizationType = .none
        textField.keyboardType = .numberPad
    }
}

public final class XYIntRow: XYFieldRow<XYIntCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Decimal Cell

open class XYDecimalCell: _XYFieldCell<Double> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.keyboardType = .decimalPad
    }
    
    open override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        let text = textField.text ?? ""
        if text.hasSuffix(".0") {
            textField.text = (text as NSString).substring(to: text.count-2)
        }
    }
}

public final class XYDecimalRow: XYFieldRow<XYDecimalCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class XYMoneyRow: XYFieldRow<XYDecimalCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        formatter = numberFormatter
    }
}

// MARK: - Phone Cell

open class XYPhoneCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.keyboardType = .phonePad
        if #available(iOS 10,*) {
            textField.textContentType = .telephoneNumber
        }
    }
}

public final class XYPhoneRow: XYFieldRow<XYPhoneCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Name Cell

open class XYNameCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.keyboardType = .asciiCapable
        if #available(iOS 10,*) {
            textField.textContentType = .name
        }
    }
}

public final class XYNameRow: XYFieldRow<XYNameCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Email Cell

open class XYEmailCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        if #available(iOS 10,*) {
            textField.textContentType = .emailAddress
        }
    }
}

public final class XYEmailRow: XYFieldRow<XYEmailCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Account Cell

open class XYAccountCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .asciiCapable
        if #available(iOS 11,*) {
            textField.textContentType = .username
        }
    }
}

public final class XYAccountRow: XYFieldRow<XYAccountCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Password Cell

open class XYPasswordCell: _XYFieldCell<String> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = true
        if #available(iOS 11,*) {
            textField.textContentType = .password
        }
    }
}

public final class XYPasswordRow: XYFieldRow<XYPasswordCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Url Cell

open class XYUrlCell: _XYFieldCell<URL> {
    open override func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .URL
        if #available(iOS 10,*) {
            textField.textContentType = .URL
        }
    }
}

public final class XYUrlRow: XYFieldRow<XYUrlCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

// MARK: - Zip Cell

open class XYipCodeCell: _XYFieldCell<String> {
    open override func update() {
        super.update()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .numbersAndPunctuation
        if #available(iOS 10,*) {
            textField.textContentType = .postalCode
        }
    }
}

public final class XYZipCodeRow: XYFieldRow<XYipCodeCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}
