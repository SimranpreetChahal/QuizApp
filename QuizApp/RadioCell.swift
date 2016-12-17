//
//  RadioCell.swift
//  QuizApp
//
//  Created by Simranpreet Kaur Chahal on 2016-12-13.
//  Copyright © 2016 APrivacy. All rights reserved.
//

import Foundation
import UIKit

protocol RadioCellDelegate :class{
    func didSelectRadioButton(_ checkedCell: RadioCell, on:Bool)
}

class RadioCell : UITableViewCell {
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var answereLabel: UILabel!
    var checked:Bool?
    
    weak var delegate:RadioCellDelegate?
    
    @IBAction func checkCell(_ sender: Any) {
        let on = !self.checked!
        self.checked = on
        self.delegate?.didSelectRadioButton(self, on: on)
        
    }
    
}
