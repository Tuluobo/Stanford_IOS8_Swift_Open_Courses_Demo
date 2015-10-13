//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by WangHao on 15/10/13.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController,UIPopoverPresentationControllerDelegate {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    var diagnosticHistory: [Int] {
        set {
            defaults.setObject(newValue, forKey: History.Defaultskey)
        }
        get {
            return defaults.objectForKey(History.Defaultskey) as? [Int] ?? []
        }
    }
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let Defaultskey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default:break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
