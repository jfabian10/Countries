//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by CS3714 on 10/6/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet var countryCodeLabel: UILabel?
    
    @IBOutlet var flagImageView:    UIImageView?
    
    @IBOutlet var populationLabel:  UILabel?
    
    @IBOutlet var capitalLabel:     UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
