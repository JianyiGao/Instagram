//
//  PostCell.swift
//  Instagram
//
//  Created by Jianyi Gao 高健一 on 3/5/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit
import Parse

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject?{
        didSet {
                print("Post object has now been set!")
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print ("In postCell\n")
        print (post)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
