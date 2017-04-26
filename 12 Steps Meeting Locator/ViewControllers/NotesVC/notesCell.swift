//
//  notesCell.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 10/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreData
//protocol notesDelegate {
//    func funcCall()
//}

class notesCell: UITableViewCell {

    @IBOutlet weak var rightsepButton: UIButton!
    @IBOutlet weak var leftsepButton: UIButton!
    @IBOutlet weak var editButton1: UIButton!
    @IBOutlet weak var deleteButton1: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var nodescellView: UIView!
    //@IBOutlet weak var nodescellView: UIButton!
    @IBOutlet weak var deleteLabelOutlate: UIButton!
    @IBOutlet weak var editButtonOutlate: UIButton!
    @IBOutlet weak var meetingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //var hdelegate: notesDelegate?
        meetingLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        dateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        nodescellView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        if ScreenSize.width == 320 {
            
            colorButton.backgroundColor = UIColor.white
            rightsepButton.isHidden = true
            editButton1.isHidden = true
            deleteButton1.isHidden = true
            
            var editImage = UIImage(named: "edit_icon")
            editButtonOutlate.setBackgroundImage(editImage, for: UIControlState())
            
            var deleteImage = UIImage(named: "delet_icon")
            deleteLabelOutlate.setBackgroundImage(deleteImage, for: UIControlState())
            
        } else {
            colorButton.isHidden = true
            leftsepButton.isHidden = true
            deleteLabelOutlate.isHidden = true
            editButtonOutlate.isHidden = true
            
            var editImage = UIImage(named: "edit_icon")
            editButton1.setBackgroundImage(editImage, for: UIControlState())
            
            var deleteImage = UIImage(named: "delet_icon")
            deleteButton1.setBackgroundImage(deleteImage, for: UIControlState())
            
        }
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButtonClicked(_ sender: AnyObject) {
        
        
              
      
    }
    
//    @IBAction func editButtonClicked(sender: AnyObject) {
//       
//        
//    }
}
