//
//  UsersTableViewCell.swift
//  TestWork
//
//  Created by Viktor Miroshnychenko on 6/16/18.
//  Copyright © 2018 FoxHound. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userProfileLinkTextView: UITextView!

    override func prepareForReuse() {
        userAvatarImageView.image = nil
        userLoginLabel.text = nil
        userProfileLinkTextView.text = nil
    }
}
