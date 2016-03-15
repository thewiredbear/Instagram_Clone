//
//  LogInViewController.swift
//  Instagram_Clone
//
//  Created by Parth Bhardwaj on 3/14/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passWordField.text!) { (user: PFUser?, error: NSError?) ->
            Void in
            if user != nil {
                print("You're logged in!")
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
    }
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        let newUser = PFUser()
        
        if userNameField.text == "" || passWordField.text == "" {
            print("no input")
        }
        else {
            newUser.username = userNameField.text
            
            newUser.password = passWordField.text
        }
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                
                print("Yay, created a user!")
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                print(error?.localizedDescription)
                
                
            }
            
        }
    }
    @IBAction func onTapInorPass(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    /*let newUser = PFUser()
    
    let homeView = segue.destinationViewController as! HomeViewController*/
    
    }*/
    
}
