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
    
    public var viewModel: NewsFeedViewModel!
    
    // MARK: - init View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.viewModel = NewsFeedViewModel()
        
        viewModel?.getResultRequest(completed: { (message) in
            if let message = message {
                DispatchQueue.main.async {
                    self.creatingErrorAlert(message: message)
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
        
        
        
        
        
        let newsFeedCellNib = UINib(nibName: "NewsFeedTableViewCell", bundle: Bundle.main)
        tableView.register(newsFeedCellNib, forCellReuseIdentifier: "newsCell")
        
        navigationItem.title = "Лента"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        
//        NetworkService.shared.getNews(sortingType: .baseUrl, completed: { [weak self] result in
//            switch result {
//                case .success(let news):
//                    DispatchQueue.main.async {
//                        self?.news = news
//                        self?.tableView.reloadData()
//                    }
//                    print(news)
//                case .failure(let messageError):
//                    print(messageError)
//            }
//        })
    }
    
    private func creatingErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка Сети", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
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
        viewModel?.NewsList.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsFeedTableViewCell
        
        cell?.titleLabel.text = viewModel.NewsList[indexPath.row].title
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd-MM"
//        let formattedDate = formatter.string(from: viewModel.NewsList[indexPath.row].date)
//        cell?.dateNewsLabel.text = formattedDate
        
        
        //cell?.setupCell(news: self.news, indexPath: indexPath)
        
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
