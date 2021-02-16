//
//  QuestionViewModel.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import Foundation

protocol QuestionViewModelDelegate {
    func getQuestions()
    func addedNewQuestion()
    func loading(isLoading: Bool)
}

class QuestionViewModel {
    
    var questions: [Question] = []
    var service = QuestionService()
    var delegate: QuestionViewModelDelegate!
    
    func getQuestions() {
        self.service.delegate = self
        self.delegate.loading(isLoading: true)
        self.service.observeQuestions()
    }
    
    func postQuestion(title: String, answer: String, color: Int) {
        self.service.delegate = self
        self.service.postQuestion(title: title, answer: answer, color: color)
    }
    
    func updateExpandedCellValue(question: Question, index: Int) {
        self.questions[index].expanded = !question.expanded
    }
}

extension QuestionViewModel: QuestionsServiceDelegate {
    func fetchQuestions(questions: [Question]) {
        self.delegate.loading(isLoading: false)
        self.questions = questions
        self.delegate.getQuestions()
    }
    
    func createQuestion(question: Question) {
        self.questions.append(question)
        
        self.delegate.addedNewQuestion()
    }
}
