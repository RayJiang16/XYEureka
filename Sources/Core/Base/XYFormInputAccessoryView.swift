//
//  XYFormInputAccessoryView.swift
//  XYEureka
//
//  Created by RayJiang on 2019/8/8.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit

final class XYFormInputAccessoryView: UIToolbar {
    
    public private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.textColor = XYEurekaConstant.mainText
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .center
        return view
    }()
    public var doneButton = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(didTapDone))
    
    public var doneClosure: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.bottom.equalToSuperview()
            maker.centerX.equalToSuperview()
        }
        
        doneButton.setTitleTextAttributes([.foregroundColor:XYEurekaConstant.mainText], for: .normal)
        doneButton.setTitleTextAttributes([.foregroundColor:XYEurekaConstant.mainText], for: .highlighted)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        setItems([flexibleSpace, doneButton], animated: false)
    }
    
    @objc private func didTapDone() {
        doneClosure?()
    }
}
