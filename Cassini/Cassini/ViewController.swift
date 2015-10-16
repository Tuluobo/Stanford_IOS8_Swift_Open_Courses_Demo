//
//  ViewController.swift
//  Cassini
//
//  Created by WangHao on 15/10/15.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if let ivc = segue.destinationViewController as? ImageViewController {
                switch identifier {
                case "earth":
                    ivc.title = "Earth"
                    ivc.imageURL = DemoURL.NASA.Earth
                case "cassini":
                    ivc.title = "Cassini"
                    ivc.imageURL = DemoURL.NASA.Cassini
                case "saturn":
                    ivc.title = "Saturn"
                    ivc.imageURL = DemoURL.NASA.Saturn
                default:break
                }
            }
        }
    }
    
}