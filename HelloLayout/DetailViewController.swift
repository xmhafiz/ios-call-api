//
//  DetailViewController.swift
//  HelloLayout
//
//  Created by Hafiz on 04/06/2017.
//  Copyright © 2017 Hafiz. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class DetailViewController: UIViewController {

    var username = ""
    var userData: [String: Any] = [:]
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = username
        // Do any additional setup after loading the view.
        
        fetch()
    }
    
    func updateView() {
        nameLabel.text = userData["name"] as? String
        
        let urlStr = userData["avatar_url"] as! String
        let url = URL(string: urlStr)
        userImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "octat"))
        
        let followerCount = userData["followers"] as! Int
        let followingCount = userData["following"] as! Int
        
        followersLabel.text = "Followers: \(followerCount)"
        followingLabel.text = "Following: \(followingCount)"
    }

    func fetch() {
        Alamofire.request("https://api.github.com/users/\(username)").responseJSON { response in
            
            switch response.result {
            case .success:
                
                do {
                    // json to dictionary
                    let parsedData = try JSONSerialization.jsonObject(with: response.data!) as! [String:Any]
                    
                    // set to our global array
                    self.userData = parsedData
                    
                    self.updateView()
                }
                catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }

}
