//
//  ViewController.swift
//  TimberiOS
//
//  Created by charvoa on 09/28/2017.
//  Copyright (c) 2017 charvoa. All rights reserved.
//

import UIKit
import TimberiOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TimberLogger.shared.log(type: .frame, level: .emergency, severity:2, tags:["flavien", "bastien"],
                                message: "frame/alert emergency test")
        TimberLogger.shared.log(type: .frame, level: .error, severity:2, tags:["flavien", "bastien"],
                                message: "frame/alert emergency test")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

