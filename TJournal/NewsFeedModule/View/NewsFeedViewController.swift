//
//  NewsFeedViewController.swift
//  TJournal
//
//  Created by Игорь Сазонов on 24.09.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var news: News!
    
    // MARK: - init View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let newsFeedCellNib = UINib(nibName: "NewsFeedTableViewCell", bundle: Bundle.main)
        tableView.register(newsFeedCellNib, forCellReuseIdentifier: "newsCell")
        
        navigationItem.title = "Лента"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
        NetworkService.shared.getNews(sortingType: .baseUrl, completed: { [weak self] result in
            switch result {
                case .success(let news):
                    
                    DispatchQueue.main.async {
                        self?.news = news
                        self?.tableView.reloadData()
                    }
                    print(news)
                case .failure(let messageError):
                    print(messageError)
            }
        })
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
//    func returnDataImage(indexCell: Int) -> Data? {
//
//
//
//
//        return Data?()
//    }
    
    
    func returnIdImage(indexItem: Int) -> String {
        let item = news.result.items[indexItem]
        switch item {
            case .onboarding(let massDataItem):
                print(massDataItem)
                return ""
            case .entry(let data):
                print(data)
                return data.subsite.avatar.data.id
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.news?.result.items.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsFeedTableViewCell
        cell?.setupCell(news: self.news, indexPath: indexPath)
        
//        cell?.setupCell(news: self.news, indexPath: indexPath)
        
//        let idImage = returnIdImage(indexItem: indexPath.row)
        
//        if idImage != "" {
//            NetworkService.shared.loadImage(idImage: idImage) { (result) in
//                switch result {
//                    case .success(let data):
//                        DispatchQueue.main.async {
//                            cell?.newsImageView = UIImageView(image: UIImage(data: data))
//                        }
//                    case .failure(_):
//                        DispatchQueue.main.async {
//                            cell?.newsImageView = UIImageView(image: UIImage(named: "newsImage"))
//                        }
//                }
//            }
//        }
        return cell ?? UITableViewCell()
    }
}
