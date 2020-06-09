//
//  ReusableCell.swift
//  News IN
//
//  Created by PraTeek Mishra on 04/06/20.
//  Copyright © 2020 PraTeek Mishra. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell{
    
    @IBOutlet weak var PostLabel: UILabel!
    
    @IBOutlet weak var PostImage: UIImageView!
    
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //PostImage.layer.cornerRadius = PostImage.frame.size.height/5
        //PostImage.layer.cornerRadius = PostImage.frame.size.height/5
        
    }
}
