//
//  ViewController.swift
//  PinyinLabelExtension
//
//  Created by Lost In Ireland on 01/07/2019.
//  Copyright (c) 2019 Lost In Ireland. All rights reserved.
//

import UIKit
import PinyinLabelExtension

class ViewController: UIViewController {
    @IBOutlet weak var pinyin: PinyinLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinyin.text = "hao3"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

