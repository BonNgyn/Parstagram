//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/24/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {

    var feedPosts:[PFObject] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        getPosts()

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myProfileCollectionViewCell", forIndexPath: indexPath) as! ProfileCollectionViewCell
        
        let mediaObject = self.feedPosts[indexPath.section]
        if mediaObject.valueForKey("media") != nil {
            cell.collectionViewImage.file = mediaObject["media"] as? PFFile
            cell.collectionViewImage.loadInBackground()
        }
        
        return cell
    }
    
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser())
        query.findObjectsInBackgroundWithBlock {(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    self.feedPosts = objects
                    self.collectionView.reloadData()
                }
            } else {
                print(error?.localizedDescription)
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
