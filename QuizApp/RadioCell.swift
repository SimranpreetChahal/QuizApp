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
    func didSelectRadioButton(_ checkedCell: RadioCell)
}

class RadioCell : UITableViewCell {
    
    weak var delegate:RadioCellDelegate?

    func unCheckRadio() {
        
    }
}
