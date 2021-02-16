//
//  ColorCicleView.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 16/02/21.
//

import UIKit

class ColorCircleView: UIView {

    lazy var insideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.addSubview(self.insideView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 40),
            self.heightAnchor.constraint(equalToConstant: 40),
            
            self.insideView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            self.insideView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 3),
            self.insideView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -3),
            self.insideView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
        ])
    }
    
    func makeCircle() {
        self.layoutIfNeeded()
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        self.backgroundColor = .white
        
        self.insideView.layer.cornerRadius = self.insideView.frame.size.width / 2
        self.insideView.clipsToBounds = true
    }
}
