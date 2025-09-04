//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 19/05/25.
//

import UIKit

//This is our extension on UIViewController is used when you want this behavious on all the view controllers

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async { //Here we wrap this to put it on a main thread
            let alertVC = GFAlertVC(title: title, alertDesc: message, buttonTitle: buttonTitle) //create the alert VC
            alertVC.modalPresentationStyle = .overFullScreen //we are presenting it in a full screen
            alertVC.modalTransitionStyle = .crossDissolve //Gives a fade in effect which is smoother
            self.present(alertVC, animated: true)
        }
    }
}

//Now with the help of extensions every view controller can just call presentGFAlertOnMainThread and pass the params
