//
//  FAQHomeViewController.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import UIKit

class FAQHomeViewController: UIViewController {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = self.view.center
        activityIndicator.color = .gray
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var addMoreQuestionsButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 20
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Adicionar Pergunta", for: .normal)
        button.setTitleColor(UIColor(red: 0.07, green: 0.09, blue: 0.60, alpha: 1.00), for: .normal)
        
        button.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
        
        button.addTarget(self, action: #selector(FAQHomeViewController.addMoreQuestionButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(button)
        return button
    }()

    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        return tableView
    }()
    
    var viewModel = QuestionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.title = "Perguntas Frequentes"
        
        self.viewModel.delegate = self
        self.viewModel.getQuestions()
    }
    
    private func setupUI() {
        self.setupTableView()
        
        self.setupConstraints()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(FAQHomeTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.tableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 6),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.tableView.bottomAnchor.constraint(equalTo: self.addMoreQuestionsButton.topAnchor, constant: -12),
            
            self.addMoreQuestionsButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.addMoreQuestionsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.addMoreQuestionsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -28),
            self.addMoreQuestionsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicator.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.activityIndicator.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    @objc func addMoreQuestionButtonTapped() {
        let controller = FAQNewQuestionViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension FAQHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FAQHomeTableViewCell
        
        cell.bind(question: self.viewModel.questions[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FAQHomeTableViewCell
        
        self.viewModel.updateExpandedCellValue(question: self.viewModel.questions[indexPath.item], index: indexPath.item)
        
        cell.clickInCell(isExpanded: self.viewModel.questions[indexPath.item].expanded)
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension FAQHomeViewController: QuestionViewModelDelegate {
    func loading(isLoading: Bool) {
        if isLoading {
            self.view.addSubview(self.activityIndicator)
            self.setupActivityIndicatorConstraints()
        } else {
            self.activityIndicator.removeFromSuperview()
            self.setupUI()
        }
    }
    
    func getQuestions() {
        self.tableView.reloadData()
    }
    
    func addedNewQuestion() {}
}
