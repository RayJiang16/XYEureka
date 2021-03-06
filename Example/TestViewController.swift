//
//  TestViewController.swift
//  Example
//
//  Created by 蒋惠 on 2019/8/26.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit
import Eureka
import XYEureka

class TestViewController: XYFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }

    private func setupForm() {
        form +++
            Section() {
                $0.tag = "S1"
            }
            <<< XYNormalRow("r1").cellSetup({ (cell, row) in
                row.title = "Test"
            }).onCellSelection({ (cell, row) in
                guard let dateRow = self.form.rowBy(tag: "r2") as? XYDatePickerRow else { return }
                dateRow.cell.minDate = Date(timeIntervalSince1970: 1199116800)
                dateRow.cell.initDate = Date(timeIntervalSince1970: 1230739200)
                dateRow.cell.maxDate = Date()
//                dateRow.value = nil
            })
            <<< XYDatePickerRow("r2").cellSetup({ (cell, row) in
                row.title = "时间"
                row.format = "yyyy年MM月"
                row.hasMustAndArrow = true
                cell.style = .month
            })
            <<< XYPickerRow<PickerModel>("r3").cellSetup({ (cell, row) in
                row.title = "选择"
                row.options = [PickerModel(name: "1"), PickerModel(name: "2")]
                row.hasMustAndArrow = true
            })
            <<< XYIntTextRow("r4").cellSetup({ (cell, row) in
                row.title = "请输入内容"
            })
    }
}
