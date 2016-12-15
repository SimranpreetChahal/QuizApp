//
//  QuizListViewController.swift
//  QuizApp
//
//  Created by Simranpreet Kaur Chahal on 2016-12-13.
//  Copyright © 2016 APrivacy. All rights reserved.
//

//Assumptions:
//1.Map all tests to have same questions for now.We can extend it to use property lists or coredata and do maping correctly.


import Foundation
import UIKit

public struct Question {
    let question: String
    let answers: [String]
    let correctAnswer: Int
}

class QuizListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tests:[String:[Question]]!
    var questions: [Question] = [
        Question(
            question: "How many O's in Fortinos",
            answers: ["2", "0", "14", "9"],
            correctAnswer: 0),
        Question(
            question: "What comes down but never goes up",
            answers: ["ABC", "X", "L", "SDF"],
            correctAnswer: 2),
        Question(
            question: "What occurs once in an min...",
            answers: ["sd", "dssd", "cxc", "ccsff"],
            correctAnswer: 3)
    ]

    var keys : [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "APrivacy"
        self.tests = ["Test1":self.questions,
        "Test2":self.questions, "Test3":self.questions]
        self.keys = Array(self.tests.keys)
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
            cell.detailTextLabel?.text = self.keys[indexPath.row] as String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "questionDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "questionDetail") {
            let indexPath = self.tableView.indexPathForSelectedRow
            let row = indexPath?.row
            if let questionDetailVC = segue.destination as? QuizDetailViewController {
                //questionDetailVC.questions = self.tests[self.keys[indexPath.row] as String]
            }
        }
    }
}
