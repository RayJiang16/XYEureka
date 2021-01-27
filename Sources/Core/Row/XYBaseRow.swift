//
//  XYBaseRow.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka

open class _XYBaseCell<T>: Cell<T>, CellType, XYBaseProtocol where T: Equatable {
    
    public var hasMustAndArrow: Bool {
        set {
            hasMust = newValue
            hasArrow = newValue
        } get {
            return hasMust && hasArrow
        }
    }
    public var hasMust: Bool = false {
        didSet {
            mustDot.isHidden = !hasMust
            layoutSubviews()
        }
    }
    public var hasArrow: Bool = false {
        didSet {
            arrowImageView.isHidden = !hasArrow
            layoutSubviews()
        }
    }
    
    public private(set) lazy var mustDot: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.text = "*"
        view.textColor = XYEurekaConstant.redText
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    public private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.textColor = XYEurekaConstant.mainText
        view.font = XYEurekaConstant.titleFont
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    }()
    public private(set) lazy var subLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = XYEurekaConstant.subText
        view.font = XYEurekaConstant.subFont
        return view
    }()
    public private(set) lazy var arrowImageView: UIImageView = {
        let bundle = Bundle(for: _XYBaseCell.self)
        let view = UIImageView(image: UIImage(named: "Arrow", in: bundle, compatibleWith: nil))
        view.isHidden = true
        return view
    }()
    public private(set) lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = XYEurekaConstant.lineColor
        return view
    }()
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        hasMust = false
        hasArrow = false
        subLabel.text = ""
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        layoutView()
    }
    
    override open func setup() {
        height = { 44 }
        setupView()
    }
    
    override open func update() {
        // super.update() 执行的内容
        selectionStyle = row.isDisabled ? .none : .default
        if row.isDisabled && XYEurekaConstant.hiddenMustDotWhenDisabled {
            hasMust = false
        }
        titleLabel.text = row.title
        
        if let displayText = row.displayValueFor?(row.value), !displayText.isEmpty {
            subLabel.text = displayText
        } else {
            subLabel.text = (row as? NoValueDisplayTextConformance)?.noValueDisplayText
        }
        
        layoutView()
    }
    
    open override func didSelect() {
        super.didSelect()
        row.deselect()
    }
    
    override open var inputAccessoryView: UIView? {
        let view = XYFormInputAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        view.titleLabel.text = row.title
        view.doneClosure = { [weak self] in
            self?.endEditing(true)
        }
        return view
    }
    
    private func setupView() {
        contentView.addSubview(mustDot)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(lineView)
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(mustDot.snp.right).offset(2)
        }
        subLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.left.equalTo(titleLabel.snp.right).offset(10)
            maker.right.equalTo(arrowImageView.snp.left).offset(-5)
        }
        lineView.snp.makeConstraints { (maker) in
            let edges = XYEurekaConstant.lineEdges
            maker.left.equalToSuperview().offset(edges.left)
            maker.right.equalToSuperview().offset(-edges.right)
            maker.bottom.equalToSuperview().offset(-edges.bottom)
            maker.height.equalTo(0.5)
        }
    }
    
    private func layoutView() {
        mustDot.snp.remakeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(hasMust ? 8 : 0)
        }
        arrowImageView.snp.remakeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(hasArrow ? 8 : 0)
        }
    }
}

public class XYBaseCell: _XYBaseCell<String> {
    
}

// MARK: - Row

public final class XYNormalRow: Row<XYBaseCell>, RowType, NoValueDisplayTextConformance {
    
    public var noValueDisplayText: String? = nil
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

