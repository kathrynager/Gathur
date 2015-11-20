//
//  GathurDetailsViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/19/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class GathurDetailsViewController: UIViewController {

    var gathurTitleS : String = ""
    var gathurDescriptionS : String = ""
    
    @IBOutlet weak var gathurTitle: UILabel!
    @IBOutlet weak var gathurDescription: UILabel!
     override func viewDidLoad() {
        super.viewDidLoad()
        gathurTitle.text = gathurTitleS
        gathurDescription.text = gathurDescriptionS
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
