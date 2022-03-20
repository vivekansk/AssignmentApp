//
//  AlertPresenter.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import Foundation
import UIKit
/**
 All alert error message should be placed into this file, so that we may edit them in one place, and re-use error messages in different parts of the app (for example the invalid postcode error message).
  */
struct AlertPresenter {
    
    // MARK: - Presenting Logic
    
    typealias Action = () -> Void
    
    func presentMessage(onVC presentingVC: UIViewController, title: String, subtitle: String, mainButtonText: String? = nil, cancelButtonText: String = "OK") {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default)
           { action -> Void in
             
           })
        
        if (cancelButtonText.count>0) {
            alertController.addAction((UIAlertAction(title: "OK", style: .default)
                                         { action -> Void in
                                           
                                         }))
        }
        
        presentingVC.present(alertController, animated: true, completion: nil)
    }
    
}
