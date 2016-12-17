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

class QuizListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tests = Dictionary<String, Any>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "APrivacy"
        self.readPropertyList()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        let detailText = Array(self.tests.keys.sorted())[indexPath.row] as String

        cell.textLabel?.text = detailText
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "questionDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "questionDetail") {
            let selectedCell = tableView.cellForRow(at: sender as! IndexPath)
            let selectedTest = selectedCell?.textLabel?.text
            let selectedQuestionsSet = self.tests[selectedTest!] as! NSArray
            print (selectedQuestionsSet)
            
            if let questionDetailVC = segue.destination as? QuizDetailViewController {
                questionDetailVC.questionsSet = selectedQuestionsSet as! Array<Any>
            }
        }
    }
    
    //MARK: private methods
    func readPropertyList() {
        if let path = Bundle.main.path(forResource: "tests_data", ofType: "plist") {
            let data:NSData? = NSData(contentsOfFile: path)
            self.tests = try! PropertyListSerialization.propertyList(from: data as! Data, options:[], format: nil) as! Dictionary
        }
    }
}
