//
//  UserViewModel.swift
//  User
//
//  Created by Krishna Vivek on 20/03/22.
//

import Foundation
import UIKit

class UserViewModel: NSObject {

    private unowned let viewController: UserViewController
    
    init(viewController: UserViewController) {
        self.viewController = viewController
    }
    
    func getUser() {
        self.serviceCallForUser { (response) in
            DispatchQueue.main.async {
                print("response = \(response)")
                if response == true {
                } else {
                    AlertPresenter().presentMessage(onVC: self.viewController, title: "", subtitle: "", mainButtonText: "OK", cancelButtonText: "Cancel")
                }
            }
        } failure: { error in
            AppConstant.sharedInstance.log(message: "error = \(String(describing: error))")
        }
    }
    
    //MARK: - ServiceCall For User
    func serviceCallForUser(success: @escaping (Bool) -> Void, failure: @escaping (APIError) -> Void)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        var environmentURL = appDelegate.baseURL
        environmentURL = "https://api.github.com/users/defunkt"
        
        if environmentURL.range(of: "https://") == nil && environmentURL.range(of: "http://") == nil {
            environmentURL = "https://" + ("\(environmentURL)")
        }
        var request = URLRequest(url: URL.init(string: environmentURL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else
            {
                AppConstant.sharedInstance.log(message: "serviceCallForUser error = \(String(describing: error))")
                let nsError = error! as NSError
                let mappedError = APIErrorMapper().map(error: nsError)
                failure(mappedError)
                return
            }
            if let jsonData = data
            {
                if jsonData.count > 0
                {
                    if let response = String(data: data!, encoding: .utf8)
                    {
                        print("response = \(response)")
                        success(true)
                    }
                }
            } else {
                success(false)
            }
        }
        task.resume()
    }
    
}
