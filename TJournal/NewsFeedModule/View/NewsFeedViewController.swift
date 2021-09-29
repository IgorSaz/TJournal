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
    
    // MARK: - Outlet
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupViews()
        self.viewModel = NewsFeedViewModel()
        self.getNews()
        self.setupNavigationBar()
    }
    
    // MARK: - PRIVATE METHOD
    
    private func getNews() {
        viewModel?.getNews(completed: { (message) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            if let message = message {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = false
                    self.creatingAlertError(message: message)
                }
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    private func setupNavigationBar() {
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
        setupTableView()
        registerCell()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.prefetchDataSource = self
    }
    
    private func registerCell() {
        let newsFeedCellNib = UINib(nibName: "NewsFeedTableViewCell", bundle: Bundle.main)
        tableView.register(newsFeedCellNib, forCellReuseIdentifier: "newsCell")
    }
}

    // MARK: - TableViewDelegate

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countItem
    }
}

    // MARK: - TableViewDataSource

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
        cell?.descreptionLabel.text = viewModel.newsList[indexPath.row].descreption
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - TableViewDataSourcePrefetching

extension NewsFeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        <#code#>
    }
}
