//
//  ViewController.swift
//  Psychologist
//
//  Created by WangHao on 15/10/13.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    @IBAction func nothing(sender: UIButton) {
        performSegueWithIdentifier("nothing", sender: nil)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let controller = destination as? HappinessViewController{
            if let identifier = segue.identifier {
                switch identifier {
                    case "sad":controller.happiness = 10
                    case "happy":controller.happiness = 90
                    case "nothing":controller.happiness = 40
                    default:controller.happiness = 60
                }
            }
            
        }
    }

}

