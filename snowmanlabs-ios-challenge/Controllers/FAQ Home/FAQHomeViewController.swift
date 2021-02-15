//
//  FAQHomeViewController.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import UIKit

class FAQHomeViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .red
        
        self.view.addSubview(tableView)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Perguntas Frequentes"
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(FAQHomeTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.tableView.separatorStyle = .none
        
        self.setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
        ])
    }
}

extension FAQHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FAQHomeTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
