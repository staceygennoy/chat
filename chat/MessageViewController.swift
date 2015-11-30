//
//  MessageViewController.swift
//  chat
//
//  Created by Stacey Gennoy on 11/24/15.
//  Copyright © 2015 Stacey Gennoy. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didpressSendButton(sender: AnyObject) {
        let message = PFObject(className: "message")
        
        message["text"] = messageField.text
        
        message.saveInBackgroundWithBlock { (status:Bool, error:NSError?) -> Void in
            print("message saved")
        }
    }

}
