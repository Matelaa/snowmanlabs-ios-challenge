//
//  FAQNewQuestionViewController.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 16/02/21.
//

import UIKit

class FAQNewQuestionViewController: UIViewController {

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleInput: FieldWithFloatingLabelComponent = {
        let view = FieldWithFloatingLabelComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.titleLabel.text = "Titulo da Pergunta"
        
        return view
    }()
    
    lazy var answerInput: FieldWithFloatingLabelComponent = {
        let view = FieldWithFloatingLabelComponent()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.titleLabel.text = "Resposta da Pergunta"
        
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Insira o titulo da pergunta"
        
        return textField
    }()
    
    lazy var answerTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = .systemFont(ofSize: 16)
        textView.text = "Resposta da pergunta"
        textView.textColor = UIColor.lightGray
        
        return textView
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Cor"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 30
        
        return stackView
    }()
    
    lazy var greenColorView: ColorCircleView = {
        let view = ColorCircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.tag = 1
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FAQNewQuestionViewController.selectColor(sender:))))
        
        view.insideView.backgroundColor = UIColor(red: 0.27, green: 0.79, blue: 0.65, alpha: 1.00)
        
        view.makeCircle()
        
        return view
    }()
    
    lazy var salmonColorView: ColorCircleView = {
        let view = ColorCircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.tag = 2
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FAQNewQuestionViewController.selectColor(sender:))))
        
        view.insideView.backgroundColor = UIColor(red: 1.00, green: 0.44, blue: 0.45, alpha: 1.00)
        
        view.makeCircle()
        
        return view
    }()
    
    lazy var yellowColorView: ColorCircleView = {
        let view = ColorCircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.tag = 3
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FAQNewQuestionViewController.selectColor(sender:))))
        
        view.insideView.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
        
        view.makeCircle()
        
        return view
    }()
    
    lazy var blueColorView: ColorCircleView = {
        let view = ColorCircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.tag = 4
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FAQNewQuestionViewController.selectColor(sender:))))
        
        view.insideView.backgroundColor = UIColor(red: 0.06, green: 0.09, blue: 0.60, alpha: 1.00)
        
        view.makeCircle()
        
        return view
    }()
    
    lazy var checkIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "check"))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = .white
        
        return imageView
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(UIColor(red: 0.06, green: 0.09, blue: 0.60, alpha: 1.00), for: .normal)
        
        button.backgroundColor = UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
        
        button.addTarget(self, action: #selector(FAQNewQuestionViewController.createNewQuestion), for: .touchUpInside)
        
        return button
    }()
    
    var oldTag: Int = 0
    var selectedTagView: Int = 0
    var viewModel = QuestionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Adicionar Pergunta"
        
        self.setupUI()
        
        self.viewModel.delegate = self
        
        self.answerTextView.delegate = self
    }
    
    private func setupUI() {
        self.view.addSubview(self.contentView)
        
        self.contentView.addSubview(self.titleInput)
        self.contentView.addSubview(self.answerInput)
        
        self.titleInput.addSubview(self.titleTextField)
        
        self.answerInput.addSubview(self.answerTextView)
        
        self.contentView.addSubview(self.colorLabel)
        self.contentView.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.greenColorView)
        self.stackView.addArrangedSubview(self.salmonColorView)
        self.stackView.addArrangedSubview(self.yellowColorView)
        self.stackView.addArrangedSubview(self.blueColorView)
        
        self.contentView.addSubview(self.confirmButton)
        
        self.setupConstraints()
    }
    
    @objc func selectColor(sender: UITapGestureRecognizer) {
        self.switchCheckInColorsView(tag: sender.view!.tag, view: sender.view!)
    }
    
    func switchCheckInColorsView(tag: Int, view: UIView) {
        self.setupCheckIconImageViewConstraints(viewColor: view, oldTag: self.oldTag, tag: tag)
    }
    
    func setupCheckIconImageViewConstraints(viewColor: UIView, oldTag: Int, tag: Int) {
        if self.oldTag == tag {
            self.checkIconImageView.removeFromSuperview()
            self.oldTag = 0
        } else {
            viewColor.addSubview(self.checkIconImageView)
            self.checkIconImageView.centerYAnchor.constraint(equalTo: viewColor.centerYAnchor).isActive = true
            self.checkIconImageView.centerXAnchor.constraint(equalTo: viewColor.centerXAnchor).isActive = true
            self.checkIconImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
            self.checkIconImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
            self.oldTag = tag
        }
    }
    
    @objc func createNewQuestion() {
        guard let title = self.titleTextField.text, !title.isEmpty else {
            let myAlert = UIAlertController(title: "Ops", message: "Verifique se o campo titulo esta preenchido corretamente.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        guard let answer = self.answerTextView.text, answer != "Resposta da pergunta" else {
            let myAlert = UIAlertController(title: "Ops", message: "Verifique se o campo resposta esta preenchido corretamente.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        if self.oldTag == 0 {
            let myAlert = UIAlertController(title: "Ops", message: "Verifique se o campo cor esta preenchido corretamente.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        self.viewModel.postQuestion(title: title, answer: answer, color: self.oldTag)
    }

    private func setupConstraints() {
        self.setupContentViewContraints()
        self.setupTitleInputConstraints()
        self.setupAnswerInputConstraints()
        self.setupTitleTextFieldConstraints()
        self.setupAnswerTextViewConstraints()
        self.setupColorLabelConstraints()
        self.setupStackViewConstraints()
        self.setupConfirmButtonConstraints()
    }
    
    private func setupContentViewContraints() {
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24),
            self.contentView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.contentView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.contentView.heightAnchor.constraint(equalToConstant: 460)
        ])
        
        self.contentView.backgroundColor = .white
        
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.4
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 2
        self.contentView.layer.cornerRadius = 10
    }
    
    private func setupTitleInputConstraints() {
        NSLayoutConstraint.activate([
            self.titleInput.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            self.titleInput.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.titleInput.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.titleInput.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setupAnswerInputConstraints() {
        NSLayoutConstraint.activate([
            self.answerInput.topAnchor.constraint(equalTo: self.titleInput.bottomAnchor, constant: 24),
            self.answerInput.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.answerInput.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            self.answerInput.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTitleTextFieldConstraints() {
        NSLayoutConstraint.activate([
            self.titleTextField.topAnchor.constraint(equalTo: self.titleInput.topAnchor, constant: 16),
            self.titleTextField.leftAnchor.constraint(equalTo: self.titleInput.leftAnchor, constant: 28),
            self.titleTextField.rightAnchor.constraint(equalTo: self.titleInput.rightAnchor, constant: -8),
            self.titleTextField.bottomAnchor.constraint(equalTo: self.titleInput.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupAnswerTextViewConstraints() {
        NSLayoutConstraint.activate([
            self.answerTextView.topAnchor.constraint(equalTo: self.answerInput.topAnchor, constant: 16),
            self.answerTextView.leftAnchor.constraint(equalTo: self.answerInput.leftAnchor, constant: 28),
            self.answerTextView.rightAnchor.constraint(equalTo: self.answerInput.rightAnchor, constant: -8),
            self.answerTextView.bottomAnchor.constraint(equalTo: self.answerInput.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupColorLabelConstraints() {
        NSLayoutConstraint.activate([
            self.colorLabel.topAnchor.constraint(equalTo: self.answerTextView.bottomAnchor, constant: 48),
            self.colorLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        ])
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor, constant: 12),
            self.stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func setupConfirmButtonConstraints() {
        NSLayoutConstraint.activate([
            self.confirmButton.heightAnchor.constraint(equalToConstant: 50),
            self.confirmButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.confirmButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.confirmButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}

extension FAQNewQuestionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Resposta da pergunta"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension FAQNewQuestionViewController: QuestionViewModelDelegate {
    func addedNewQuestion() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loading(isLoading: Bool) {}
    
    func getQuestions() {}
}
