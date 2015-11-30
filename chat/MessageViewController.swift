//
//  MessageViewController.swift
//  chat
//
//  Created by Stacey Gennoy on 11/24/15.
//  Copyright © 2015 Stacey Gennoy. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //initialize the array to something
        messages = []
        
        // to query the user table
        let query = PFQuery(className: "Message")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            print(objects)
            
            self.messages = objects
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "fetchMessages", userInfo: nil, repeats: true)
        fetchMessages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMessages() {
        // to query the user table
        let query = PFQuery(className: "Message")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            print(objects)
            
            self.messages = objects
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier("MessageCell") as!
        MessageCell
        
        let message = messages[indexPath.row]
        
        // ? because text could be blank
        cell.messageLabel.text = message["text"] as? String
        
        return cell
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
        let message = PFObject(className: "Message")
        
        message["text"] = messageField.text
        
        message.saveInBackgroundWithBlock { (status:Bool, error:NSError?) -> Void in
            print("message saved")
        }
    }

}
