//
//  ViewController.swift
//  SplitViewSample
//
//  Created by 高橋広樹 on 2018/03/16.
//  Copyright © 2018年 HIRO's.NET. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    var imageName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //画像を設定する。
        if(imageName != nil) {
            testImageView.image = UIImage(named: "wood_pattern")
        }
    }


}

