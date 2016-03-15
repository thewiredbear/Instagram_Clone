//
//  PhotosViewController.swift
//  Instagram_Clone
//
//  Created by Parth Bhardwaj on 3/14/16.
//  Copyright © 2016 Parth Bhardwaj. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func getImage() {
        
        let imageFromSource = UIImagePickerController()
        imageFromSource.delegate = self
        imageFromSource.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else {
            
            imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        
        self.presentViewController(imageFromSource, animated:true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        
        selectedImage.image = image
        
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    @IBAction func onSubmit(sender: AnyObject) {
        
        if selectedImage.image != nil || captionTextField.text != nil {
            
            UserMedia.postUserImage(selectedImage.image, withCaption: self.captionTextField.text, withCompletion: nil)
        }
            
        else {
            print("ERROR!")
        }
        
        
        self.tabBarController!.selectedIndex = 0;
        
    }
    
    
    class UserMedia: NSObject {
        
        class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
            let media = PFObject(className: "UserMediaInsta")
            
            // Add relevant fields to the object
            media["media"] = getPFFileFromImage(image) // PFFile column type
            media["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
            media["caption"] = caption
            // Save object (following function will save the object in Parse asynchronously)
            media.saveInBackgroundWithBlock(completion)
        }
        
        class func getPFFileFromImage(image: UIImage?) -> PFFile? {
            // check if image is not nil
            if let image = image {
                // get image data and check if that is not nil
                if let imageData = UIImagePNGRepresentation(image) {
                    return PFFile(name: "image.png", data: imageData)
                }
            }
            return nil
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
