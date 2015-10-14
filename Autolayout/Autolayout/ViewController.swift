//
//  ViewController.swift
//  Autolayout
//
//  Created by WangHao on 15/10/13.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var logo: UIImageView!
    
    var secure: Bool = false { didSet { updateUI() } }
    var loggedInUser: User? { didSet{ updateUI() } }
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existContraint = aspectRatioConstraint {
                view.removeConstraint(existContraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    var image: UIImage? {
        get {
            return logo.image
        }
        set {
            logo.image = newValue
            if let constrainedView = logo {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                }else{
                    aspectRatioConstraint = nil
                }

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    
    private func updateUI(){
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        image = loggedInUser?.image
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text!, password: passwordField.text!)
    }
    
}

extension User {
    var image: UIImage {
        if let image = UIImage(named: login) {
            return image
        } else {
            return UIImage(named: "unknown_user")!
        }
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
