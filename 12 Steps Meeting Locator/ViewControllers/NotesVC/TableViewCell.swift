//
//  TableViewCell.swift
//  mainView
//
//  Created by iApp on 03/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var placeHolderImg: UIImageView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var program_name: UILabel!
    @IBOutlet weak var toplabel: UILabel!
    @IBOutlet weak var nextButtomlabel: UILabel!
    @IBOutlet weak var secondLastLabel: UILabel!
    @IBOutlet weak var leftsmallImage: UIImageView!
    @IBOutlet weak var lastLable: UILabel!
    @IBOutlet weak var moneyImage: UIImageView!
    @IBOutlet weak var rightTopLabel: UILabel!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var rightsecondLabel: UILabel!
    
    var leftimg: UIImageView = UIImageView()
    var lbl: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
updateFonts()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateFonts()
    {
        //toplabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        toplabel.textColor = UIColor(red: 153.0 / 255, green: 163.0 / 255, blue: 193.0 / 255, alpha: 1)
        nextButtomlabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2)
    }

    
}
