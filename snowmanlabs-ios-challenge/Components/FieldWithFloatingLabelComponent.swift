//
//  FieldWithFloatingLabelComponent.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 16/02/21.
//

import UIKit

class FieldWithFloatingLabelComponent: UIView {
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backgroundLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStyle()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupStyle() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = 6
        
        self.contentView.backgroundColor = .white
        self.backgroundLabelView.backgroundColor = .white
    }
    
    private func setupUI() {
        self.addSubview(self.contentView)
        
        self.addSubview(self.backgroundLabelView)
        
        self.backgroundLabelView.addSubview(self.titleLabel)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContentViewConstraints()
        self.setupBackgroundLabelViewConstraints()
        self.setupTitleLabelConstraints()
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    private func setupBackgroundLabelViewConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundLabelView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -14),
            self.backgroundLabelView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.backgroundLabelView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.backgroundLabelView.topAnchor, constant: 2),
            self.titleLabel.leftAnchor.constraint(equalTo: self.backgroundLabelView.leftAnchor, constant: 8),
            self.titleLabel.rightAnchor.constraint(equalTo: self.backgroundLabelView.rightAnchor, constant: -8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.backgroundLabelView.bottomAnchor, constant: -2),
        ])
    }
}
