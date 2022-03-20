//
//  ViewController.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userVM:UserViewModel = UserViewModel(viewController: self)
        userVM.getUser()
    }


}

