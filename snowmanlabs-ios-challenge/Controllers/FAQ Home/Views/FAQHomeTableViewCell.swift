//
//  FAQHomeTableViewCell.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import UIKit

class FAQHomeTableViewCell: UITableViewCell {
    
    lazy var backgroundColoredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    lazy var contentViewToTitle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleQuestionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "Titulo da pergunta"
        
        return label
    }()
    
    lazy var arrowIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var answerQuestionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = UIColor(red: 0.55, green: 0.56, blue: 0.61, alpha: 1.00)
        label.numberOfLines = 0
        label.text = "Resposta da pergunta"
        
        return label
    }()
    
    lazy var spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var question: Question!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.mainBackgroundView.backgroundColor = .white
        self.answerQuestionLabel.isHidden = true
        self.arrowIcon.tintColor = UIColor(red: 0.46, green: 0.47, blue: 0.52, alpha: 1.00)
        self.spacingView.backgroundColor = .clear
        
        self.setupCornerRadiusInCell()
        self.setupShadows()
        
        self.setupUI()
    }
    
    func bind(question: Question) {
        self.question = question
        
        self.setupColorView(tagColor: self.question.color)
        
        self.titleQuestionLabel.text = self.question.title
        self.answerQuestionLabel.text = self.question.answer
        
        self.isExpanded(isExpanded: self.question.expanded)
    }
    
    private func setupCornerRadiusInCell() {
        self.clipsToBounds = true
        self.mainBackgroundView.layer.cornerRadius = 10
        self.backgroundColoredView.layer.cornerRadius = 10
    }
    
    private func setupShadows() {
        self.backgroundColoredView.layer.shadowColor = UIColor.black.cgColor
        self.backgroundColoredView.layer.shadowOpacity = 0.4
        self.backgroundColoredView.layer.shadowOffset = .zero
        self.backgroundColoredView.layer.shadowRadius = 2
    }
    
    private func setupUI() {
        self.addSubview(self.backgroundColoredView)
        
        self.backgroundColoredView.addSubview(self.mainBackgroundView)
        
        self.mainBackgroundView.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.contentViewToTitle)
        
        self.contentViewToTitle.addSubview(self.titleQuestionLabel)
        self.contentViewToTitle.addSubview(self.arrowIcon)
        
        self.stackView.addArrangedSubview(self.answerQuestionLabel)
        self.stackView.addArrangedSubview(self.spacingView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundColoredView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.backgroundColoredView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            self.backgroundColoredView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            self.backgroundColoredView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            self.mainBackgroundView.topAnchor.constraint(equalTo: self.backgroundColoredView.topAnchor),
            self.mainBackgroundView.leftAnchor.constraint(equalTo: self.backgroundColoredView.leftAnchor, constant: 2),
            self.mainBackgroundView.rightAnchor.constraint(equalTo: self.backgroundColoredView.rightAnchor),
            self.mainBackgroundView.bottomAnchor.constraint(equalTo: self.backgroundColoredView.bottomAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.mainBackgroundView.topAnchor, constant: 16),
            self.stackView.leftAnchor.constraint(equalTo: self.mainBackgroundView.leftAnchor, constant: 16),
            self.stackView.rightAnchor.constraint(equalTo: self.mainBackgroundView.rightAnchor, constant: -16),
            self.stackView.bottomAnchor.constraint(equalTo: self.mainBackgroundView.bottomAnchor, constant: -16),
            
            self.titleQuestionLabel.topAnchor.constraint(equalTo: self.contentViewToTitle.topAnchor, constant: 8),
            self.titleQuestionLabel.leftAnchor.constraint(equalTo: self.contentViewToTitle.leftAnchor),
            self.titleQuestionLabel.bottomAnchor.constraint(equalTo: self.contentViewToTitle.bottomAnchor, constant: -8),
            
            self.arrowIcon.centerYAnchor.constraint(equalTo: self.contentViewToTitle.centerYAnchor),
            self.arrowIcon.rightAnchor.constraint(equalTo: self.contentViewToTitle.rightAnchor, constant: -8),
            self.arrowIcon.leftAnchor.constraint(greaterThanOrEqualTo: self.titleQuestionLabel.rightAnchor, constant: 8),
            self.arrowIcon.widthAnchor.constraint(equalToConstant: 20),
            self.arrowIcon.heightAnchor.constraint(equalToConstant: 20),
            
            self.spacingView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupColorView(tagColor: Int) {
        switch tagColor {
        case 1:
            self.backgroundColoredView.backgroundColor = UIColor(red: 0.27, green: 0.79, blue: 0.65, alpha: 1.00)
        case 2:
            self.backgroundColoredView.backgroundColor = UIColor(red: 1.00, green: 0.44, blue: 0.45, alpha: 1.00)
        case 3:
            self.backgroundColoredView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
        case 4:
            self.backgroundColoredView.backgroundColor = UIColor(red: 0.06, green: 0.09, blue: 0.60, alpha: 1.00)
        default:
            break
        }
    }
    
    func isExpanded(isExpanded: Bool) {
        self.arrowIcon.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform(rotationAngle: 0)
        self.answerQuestionLabel.isHidden = !isExpanded
    }
    
    func clickInCell(isExpanded: Bool) {
        
        self.answerQuestionLabel.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            self.isExpanded(isExpanded: isExpanded)
        }
    }
}
