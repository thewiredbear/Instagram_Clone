//
//  HomeViewController.swift
//  Instagram_Clone
//
//  Created by Parth Bhardwaj on 3/14/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var instaPosts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getPosts()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts()
    {
        let query = PFQuery(className: "UserMediaInsta")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                //print(self.instaPosts)
                self.instaPosts = results
                self.tableView.reloadData()
                
            } else {
                print(error)
            }
        }
        
    }
    
    
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        
        self.getPosts()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if instaPosts != nil {
            return instaPosts!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HRC", forIndexPath: indexPath) as! InstaPostCellTableViewCell
        
        cell.getPhotoandCaption = instaPosts[indexPath.row]
        
        return cell
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogout", object: nil)
    }
    // MARK: - Navigation
    
    /*3override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    }*/
    
    
}
