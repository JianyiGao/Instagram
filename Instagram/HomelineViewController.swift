//
//  HomelineViewController.swift
//  Instagram
//
//  Created by Jianyi Gao 高健一 on 3/4/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit
import Parse

class HomelineViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var posts:[PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 315

        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (query: [PFObject]?, error: Error?) in
            if let query = query{
                // do something with the data fetched
                print ("Data fetched!")
                self.posts = query
                print(self.posts)
                self.tableView.reloadData()
            } else {
                // handle error
                print (error?.localizedDescription)
            }
        
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print(error?.localizedDescription)
            }
            // PFUser.currentUser() will now be nil
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }

    @IBAction func onCamera(_ sender: Any) {
        self.performSegue(withIdentifier: "cameraSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.posts != nil{
            print (self.posts)
            print ("***********")
            print (self.posts.count)
            return self.posts.count
        } else {
            print ("Post is nil")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = self.posts[indexPath.row]
        let user = post["author"] as! PFObject
        print ("In cellForRowAt: \n")
        print (self.posts[indexPath.row])

        
        cell.captionLabel.text = post["caption"] as! String?
        
        cell.usernameLabel.text = user["username"] as! String?
        
        let picture = post["media"]
        
        (picture as AnyObject).getDataInBackground(block: { (imageData: Data?, error: Error?) in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.postImage.image = image
                }
            }
        })
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
//        cell?.post = self.posts![indexPath.row]
//        print ("In cellForRowAt: \n")
//        print (self.posts![indexPath.row])
//        
//        
//        
//        return cell!
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


