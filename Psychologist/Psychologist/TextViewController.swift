//
//  TextViewController.swift
//  Psychologist
//
//  Created by WangHao on 15/10/13.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class TextViewController: UIViewController,UIPopoverControllerDelegate {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.text = text
        }
    }
    
    var text: String! = "" {
        didSet {
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }
            return super.preferredContentSize
        }
        set {
            super.preferredContentSize = newValue
        }
    }
}
