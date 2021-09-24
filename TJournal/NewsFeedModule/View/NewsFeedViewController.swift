//
//  FirstViewController.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    // MARK: - ViewModel
    
    //public let viewModel: ViewModel

    
    // MARK: - Outlet
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - init View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        let newsFeedCellNib = UINib(nibName: "NewsFeedTableViewCell", bundle: Bundle.main)
        tableView.register(newsFeedCellNib, forCellReuseIdentifier: "newsCell") 
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

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        return cell
    }
}
