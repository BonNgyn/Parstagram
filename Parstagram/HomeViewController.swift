//
//  HomeViewController.swift
//  Parstagram
//
//  Created by Bonnie Nguyen on 6/20/16.
//  Copyright © 2016 Bonnie Nguyen. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var feedPosts:[PFObject] = []
    var loadMore: Int = 20
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getPosts()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: self)
        self.navigationController?.setNavigationBarHidden(self.navigationController?.navigationBarHidden == false, animated: true)
    }
    
    @IBAction func uploadButton(sender: AnyObject) {
        self.performSegueWithIdentifier("uploadSegue", sender: self)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // ... Code to load more results ...
                self.loadMore += 20
                getPosts()
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        getPosts()
        self.tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.limit = loadMore
        query.includeKey("author")
        query.findObjectsInBackgroundWithBlock {(objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    self.feedPosts = objects
                    self.tableView.reloadData()
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    //formatting NSDate to a string
    func dateToString(nsDate: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        return "\(dateFormatter.stringFromDate(nsDate))"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return feedPosts.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myParseCell", forIndexPath: indexPath) as! parseCell
        let postObject = self.feedPosts[indexPath.section]
        
        //get caption
        if let myString = postObject.valueForKey("caption") {
            
            //assign caption into cell
            cell.feedText.text = myString as? String
            
            //assign fetched image to cell
            cell.feedImage.file = postObject["media"] as? PFFile
            cell.feedImage.loadInBackground()
            
            //getting date
            let date = postObject.createdAt
            cell.feedDate.text = dateToString(date!)
            
            
        }
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "detailViewSegue":
                    let postDetailVC = segue.destinationViewController as! DetailViewController
                    if let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell) {
                        let passedPost = self.feedPosts[indexPath.section]
                    
                        //specific post caption
                        let caption = passedPost.valueForKey("caption") as? String
                        postDetailVC.detailCaptionSegue = caption!
                        
                        //specific post image
                        let feedImage = passedPost["media"] as? PFFile
                        postDetailVC.file = feedImage
                        
                        //specific post date
                        let date = dateToString(passedPost.createdAt!)
                        postDetailVC.detailDateSegue = date
                        

                }
                default: break
            }
        }
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderViewIdentifier) as UITableViewHeaderFooterView
//        
//        header..text = self.feedPosts[section][0]
//        return header
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
