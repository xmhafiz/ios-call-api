//
//  CustomListViewController.swift
//  HelloLayout
//
//  Created by Hafiz on 04/06/2017.
//  Copyright © 2017 Hafiz. All rights reserved.
//

import UIKit

import Alamofire
import SDWebImage

class CustomListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var usersData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailUser" {
            
            // get selected row
            let selectedRow = tableView.indexPathForSelectedRow?.row
            
            // pass to destination controller
            let userName = usersData[selectedRow!]["login"] as! String
            
            let destinationController = segue.destination as! DetailViewController
            destinationController.username = userName
            
        }
    }
    
    func fetch() {
        Alamofire.request("https://api.github.com/users").responseJSON { response in
            
            switch response.result {
            case .success:
                
                do {
                    // json to dictionary
                    let parsedData = try JSONSerialization.jsonObject(with: response.data!) as! [[String:Any]]
                    
                    // set to our global array
                    self.usersData = parsedData
                    
                    self.tableView.reloadData()
                }
                catch let error {
                    print(error)
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    // MARK:- this is for UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomViewCell
        
        let i = indexPath.row
        
        let user = usersData[i]
        
        cell.nameLabel.text = user["login"] as? String
        
        let urlStr = user["avatar_url"] as! String
        let url = URL(string: urlStr)
        cell.userImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "octat"))
        
        cell.descriptionLabel.text = user["repos_url"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetailUser", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
