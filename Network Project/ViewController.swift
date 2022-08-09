//
//  ViewController.swift
//  Network Project
//
//  Created by Алия Тлеген on 08.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var items = [Post]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.separatorInset = .zero
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        return tableView
    }()
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationItem()
        obtainPosts()
    }
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Posts"
    }
    
    func obtainPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return
        }
        session.dataTask(with: url) { [weak self](data, response, error)  in
            guard let strongSelf = self else {return}
            if error == nil, let parseData = data {
                
                guard let posts = try? strongSelf.decoder.decode([Post].self, from: parseData) else {
                    return
                }
                strongSelf.items = posts
                
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
            
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = items[indexPath.row]
        cell.configure(model: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

}
