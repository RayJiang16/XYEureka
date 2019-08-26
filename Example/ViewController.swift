//
//  ViewController.swift
//  Example
//
//  Created by 蒋惠 on 2019/8/26.
//  Copyright © 2019 RayJiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = TestViewController()
        navigationController?.pushViewController(controller, animated: true)
    }

}

