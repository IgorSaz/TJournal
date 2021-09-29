//
//  NewsFeedTableViewCell.swift
//  TJournal
//
//  Created by Игорь Сазонов on 23.09.2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

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
    }
    
    func setupCell(news: News, indexPath: IndexPath) {
        var id = ""
        let item = news.result.items[indexPath.row]
        switch item {
            case .onboarding(_):
                
                break
            case .entry(let data):
                print(data)
                id = data.subsite.avatar.data.id
                titleLabel.text = data.title
                nameAuthorLabel.text = data.author.name
                dateNewsLabel.text = String(data.date)
        }
        
        self.loadImage(idImage: id) { [weak self] (data) in
            DispatchQueue.main.async() {
                self?.newsImageView.image = nil //UIimage(data: data)
            }
        }
        
        
        //newsImageView.image = UIImage(data: data)
    }
    
    func loadImage(idImage: String, completed: @escaping (Data) -> Void) {
        let urlString = "https://leonardo.osnova.io/\(idImage)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            if let data = data {
                completed(data)
            }
        }.resume()
    }
    
    
    
//    func returnIdImage(indexItem: Int, news: News) -> String {
//        let item = news.result.items[indexItem]
//        switch item {
//            case .onboarding(let massDataItem):
//                print(massDataItem)
//                break
//            case .entry(let data):
//                print(data)
//                return data.subsite.avatar.data.id
//        }
//        return ""
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
