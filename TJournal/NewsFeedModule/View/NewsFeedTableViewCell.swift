//
//  NewsFeedTableViewCell.swift
//  TJournal
//
//  Created by Игорь Сазонов on 23.09.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var avatarSubsiteImageView: UIImageView!
    @IBOutlet var nameSubsiteLabel: UILabel!
    @IBOutlet var nameAuthorLabel: UILabel!
    @IBOutlet var dateNewsLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descreptionLabel: UILabel!
    @IBOutlet var countCommentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarSubsiteImageView.layer.cornerRadius = 10
    }
}
