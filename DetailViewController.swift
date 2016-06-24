//
//  DetailViewController.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/24/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    //models
    var detailCaptionSegue: String = ""
    var detailImageSegue: String = ""
    var detailDateSegue: String = ""
    internal var file: PFFile?
    var particularPost: PFObject?
    
    @IBOutlet weak var detailUserLabel: UILabel!
    @IBOutlet weak var detailImageView: PFImageView!
    @IBOutlet weak var detailCaptionLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCaptionLabel.text = detailCaptionSegue
        
        detailImageView.file = file
        detailImageView.loadInBackground()

        detailDateLabel.text = detailDateSegue

        
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
    
}
