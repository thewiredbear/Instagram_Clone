//
//  InstaPostCellTableViewCell.swift
//  Instagram_Clone
//
//  Created by Parth Bhardwaj on 3/14/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit
import Parse

class InstaPostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var postedCaption: UILabel!
    
    var getPhotoandCaption: PFObject! {
        didSet {
            self.postedCaption.text = getPhotoandCaption["caption"] as? String
            
            if let userPicture = getPhotoandCaption["media"] as? PFFile {
                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                    if (error == nil) {
                        self.postedImage.image = UIImage(data:imageData!)
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
