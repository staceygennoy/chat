//
//  LoginViewController.swift
//  chat
//
//  Created by Stacey Gennoy on 11/24/15.
//  Copyright © 2015 Stacey Gennoy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPressSignInButton(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if error == nil {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Error: \(error)")
            }
            
        }
        
    }
    
    
    @IBAction func didPressCreateAccountButton(sender: AnyObject) {
        let user = PFUser()
        
        user.username = userNameField.text
        user.password = passwordField.text
        
        
        // at this point, come back from parse
        user.signUpInBackgroundWithBlock { (status: Bool, error: NSError?) -> Void in
            if error == nil {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Error: \(error)")
            }
            
        }
        
        
        
    }
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
