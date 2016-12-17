//
//  QuizDetailViewController.swift
//  QuizApp
//
//  Created by Simranpreet Kaur Chahal on 2016-12-13.
//  Copyright © 2016 APrivacy. All rights reserved.
//

import Foundation
import UIKit

class QuizDetailViewController:UIViewController,UITableViewDataSource, UITableViewDelegate,RadioCellDelegate {
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var questionNameLabel: UILabel!
    
    var questionsSet: Array<Any>!
    var currentIndex: Int = 0
    
    var currentQuestionOptions:[String] = []
    var currentQuestionCorrectAnswere: NSNumber = 0.0
    var answereSet: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(showNextQuestion(sender:))
        )
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.loadQuestion(0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestionOptions.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell") as! RadioCell
        cell.checked = false
        cell.radioButton.setImage(UIImage(named: "radio"),for: UIControlState.normal)
        cell.delegate = self
        cell.answereLabel.text = currentQuestionOptions[indexPath.row] as String
        return cell
    }

    func showNextQuestion(sender: UIBarButtonItem) {
       // if(self.currentIndex < questionsSet.count) {
            loadQuestion(self.currentIndex)
       // }
    }

    func showSummaryScreen(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showSummary", sender: answereSet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionSummaryVC = segue.destination as? QuizSummaryViewController {
            questionSummaryVC.answeres = sender as! [String:String]
        }
    }
    
    func loadQuestion(_ index:Int) {
       let currentQuestion = questionsSet[index] as! NSDictionary
        self.questionNameLabel.text = currentQuestion["questionName"] as? String
        currentQuestionOptions = currentQuestion["options"] as! [String]
        self.detailTableView.reloadData()
        
        if(self.currentIndex < questionsSet.count - 1){
            self.currentIndex += 1
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.navigationItem.rightBarButtonItem?.action = #selector(showSummaryScreen(sender:))
        }
    }
    
    func didSelectRadioButton(_ checkedCell: RadioCell,on:Bool) {
        if(on) {
            checkedCell.radioButton.setImage(UIImage(named: "radio-selected"),for: UIControlState.normal)
        } else {
            checkedCell.radioButton.setImage(UIImage(named: "radio"),for: UIControlState.normal)
        }
        checkedCell.checked = !on
        
    }
}
