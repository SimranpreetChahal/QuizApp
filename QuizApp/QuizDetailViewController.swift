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
    var selectedAnswere:Int = 0
    var answereSet: [String:Bool] = [:]
    
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
        //cell.checked = false
        cell.answereLabel.text = currentQuestionOptions[indexPath.row] as String
        if(!cell.isChecked()){
            cell.radioButton.setImage(UIImage(named: "radio"),for: UIControlState.normal)
        }else {
            cell.radioButton.setImage(UIImage(named: "radio-selected"),for: UIControlState.normal)
            self.selectedAnswere = indexPath.row
            cell.setIsChecked(false)
        }
        cell.delegate = self

        return cell
    }

    func showNextQuestion(sender: UIBarButtonItem) {
        if(self.selectedAnswere == Int(self.currentQuestionCorrectAnswere)) {
            answereSet[self.questionNameLabel.text!] = true

            self.alert(message: "Correct Answere", title: "Success")
        }else {
            answereSet[self.questionNameLabel.text!] = false

            self.alert(message: "Oops! you answered it incorrect", title: "Oops!")
        }
    }

    func showSummaryScreen(sender: UIBarButtonItem) {
        performSegue(withIdentifier:"showSummary", sender: answereSet)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionSummaryVC = segue.destination as? QuizSummaryViewController {
            questionSummaryVC.answeres = sender as! [String:Bool]
        }
    }
    
    func loadQuestion(_ index:Int) {
       let currentQuestion = questionsSet[index] as! NSDictionary
        self.questionNameLabel.text = currentQuestion["questionName"] as? String
        currentQuestionOptions = currentQuestion["options"] as! [String]
        self.currentIndex += 1
        if(self.currentIndex == questionsSet.count) {
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        self.detailTableView.reloadData()
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            if(self.currentIndex < self.questionsSet.count) {
                self.loadQuestion(self.currentIndex)
            } else {
                self.performSegue(withIdentifier:"showSummary", sender:self.answereSet)
            }
            })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func didSelectRadioButton(_ checkedCell: RadioCell,on:Bool) {
        if(on) {
            checkedCell.radioButton.setImage(UIImage(named: "radio-selected"),for: UIControlState.normal)
        } else {
            checkedCell.radioButton.setImage(UIImage(named: "radio"),for: UIControlState.normal)
        }
        checkedCell.setIsChecked(on)
        self.detailTableView.reloadData()
    }
}
