//
//  ViewController.swift
//  HelloLayout
//
//  Created by Hafiz on 04/06/2017.
//  Copyright © 2017 Hafiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris tempus metus ac molestie ornare. Sed venenatis facilisis bibendum. Nulla pulvinar ultricies feugiat. Nam commodo sollicitudin lacus. Maecenas scelerisque felis nec orci convallis, et fringilla velit posuere. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus eget velit efficitur enim sollicitudin lacinia et et lectus. Etiam lectus tortor, semper vitae felis quis, consequat sollicitudin augue. Praesent diam velit, tristique eu cursus vitae, egestas non mauris. Vivamus turpis dui, dignissim vitae euismod quis, tincidunt et augue. Mauris dapibus ipsum a iaculis feugiat."
        
        
        let preference = UserDefaults.standard
        preference.set("Hafiz", forKey: "UserName") // write value by key
        
        print(preference.value(forKey: "UserName") ?? "no value") // read value
        
        preference.removeObject(forKey: "UserName")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

