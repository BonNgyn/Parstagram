//
//  UploadViewController.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/22/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    //        imageView.image = image
    //        self.dismissViewControllerAnimated(true, completion: nil)
    //    }
    @IBAction func cameraButton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func libraryButton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func uploadButton(sender: AnyObject) {
        let imageText = captionField.text
        
        if imageView.image == nil {
            print("Please Select and Image")
        }else {
            
            let posts = PFObject(className: "Posts")
            posts["imageText"] = imageText
            posts["uploader"] = PFUser.currentUser()
            posts.saveInBackgroundWithBlock({
                (success: Bool, error: NSError?) -> Void in
                if error == nil {
                    
                    //create an image data
                    let imageData = UIImagePNGRepresentation(self.imageView.image!)
                    //create a parse file to store in cloud
                    let parseImageFile = PFFile(name: "uploaded_image.png", data: imageData!)
                    posts["imageFile"] = parseImageFile
                    posts.saveInBackgroundWithBlock({
                        (success: Bool, error: NSError?) -> Void in
                        
                        if error == nil {
                            //take user home
                            print("data uploaded")
                            self.performSegueWithIdentifier("goHomeSegueFromUpload", sender: self)
                            
                        }else {
                            
                            print(error?.localizedDescription)
                        }
                    })
                }else {
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
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
