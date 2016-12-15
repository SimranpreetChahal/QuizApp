//
//  QuizDetailViewController.swift
//  QuizApp
//
//  Created by Simranpreet Kaur Chahal on 2016-12-13.
//  Copyright © 2016 APrivacy. All rights reserved.
//

import Foundation
import UIKit

class QuizDetailViewController:UIViewController,UITableViewDelegate,RadioCellDelegate {
    
    @IBOutlet weak var detailTableView: UITableView!
    var questions:[Question]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(showNextQuestion(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButton
        self.detailTableView.reloadData()

    }
    
    func initWithQuestion(_ question:Question) {
        
    }
    
   /* func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return Radio Cell here after instantiation
    
    }*/

    func showNextQuestion(sender: UIBarButtonItem) {
        //Instantiate same instance of QuizDetailViewController with a different questions
    }

    func didSelectRadioButton(_ checkedCell: RadioCell) {
        
    }
}
