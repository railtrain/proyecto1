//
//  loginViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 07/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class loginViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    
    @IBOutlet weak var btnlogin: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnlogin.readPermissions = ["email","public_profile","user_friends"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func loginButtomDisLogOut(_ loginButton: FBSDKLoginButton!){
        
    }
    
    
   public func loginButtom(_ loginButtom: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        performSegue(withIdentifier: "Login segue", sender: self)
    }


}
