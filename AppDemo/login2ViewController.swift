//
//  login2ViewController.swift
//  AppDemo
//
//  Created by AdminUTM on 07/12/16.
//  Copyright © 2016 AdminUTM. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class login2ViewController: UIViewController, FBSDKLoginButtonDelegate{

    @IBOutlet weak var btnlogin: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnlogin.readPermissions = ["email", "public_profile", "user_friends","user_photos"]
        btnlogin.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
        if result.isCancelled{
            print("Cancelar flujo")
        } else{
            print("Token: \(result.token.tokenString)")
            performSegue(withIdentifier: "Login segue", sender: self)
        }
    }

    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
    }



}
