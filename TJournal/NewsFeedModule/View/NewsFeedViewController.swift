//
//  NewsFeedViewController.swift
//  TJournal
//
//  Created by Игорь Сазонов on 24.09.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {

    // MARK: - VAR
    
    var news: News!
    public var viewModel: NewsFeedViewModel!
    
    @IBOutlet var tableView: UITableView!

    // MARK: - init View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.viewModel = NewsFeedViewModel()
        
        viewModel?.getResultRequest(completed: { (message) in
            if let message = message {
                DispatchQueue.main.async {
                    self.creatingAlertError(message: message)
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
    }
    
    private func creatingAlertError(message: String) {
        let alert = UIAlertController(title: "Ошибка Сети", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
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
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.newsList.count ?? .zero
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsFeedTableViewCell
        
        cell?.titleLabel.text = viewModel.newsList[indexPath.row].title
        cell?.nameSubsiteLabel.text = viewModel.newsList[indexPath.row].nameSubsite
        cell?.nameAuthorLabel.text = viewModel.newsList[indexPath.row].nameAuthor
        
        viewModel.loadImage(idImage: viewModel.newsList[indexPath.row].idImageSubsite) { (data) in
            DispatchQueue.main.async() {
                cell?.avatarSubsiteImageView.image = UIImage(data: data)
            }
        }

        viewModel.loadImage(idImage: viewModel.newsList[indexPath.row].idImageSubsite) { (data) in
            DispatchQueue.main.async() {
                cell?.newsImageView.image = UIImage(data: data)
            }
        }
        
        cell?.dateNewsLabel.text = viewModel.newsList[indexPath.row].date
        
        
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
