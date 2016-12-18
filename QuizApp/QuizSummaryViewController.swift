//
//  QuizSummaryViewController.swift
//  QuizApp
//
//  Created by Simranpreet Kaur Chahal on 2016-12-13.
//  Copyright © 2016 APrivacy. All rights reserved.
//

import Foundation
import UIKit

class QuizSummaryViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var answeres:[String:String] = [:]
    
    @IBOutlet weak var sumaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftButton = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backToTests(sender:))
        )
        self.navigationItem.leftBarButtonItem = leftButton

    }
    
    func backToTests(sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindToTests", sender: self)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answeres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell") as! RadioCell
        cell.checked = false
        cell.radioButton.setImage(UIImage(named: "radio"),for: UIControlState.normal)
        return cell
    }

}
