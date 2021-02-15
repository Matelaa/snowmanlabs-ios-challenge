//
//  QuestionService.swift
//  snowmanlabs-ios-challenge
//
//  Created by José Matela Neto on 15/02/21.
//

import Foundation
import FirebaseDatabase

protocol QuestionsServiceDelegate {
    func fetchQuestions(questions: [Question])
    func createQuestion(question: Question)
}

class QuestionService {
    
    let questionRef = Database.database().reference().child("questions")
    
    var delegate: QuestionsServiceDelegate!
    
    func observeQuestions() {
        
        self.questionRef.observe(.value) { snapshot in
            
            var questions = [Question]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String:Any],
                   let title = dict["title"] as? String,
                   let answer = dict["answer"] as? String,
                   let color = dict["color"] as? Int {
                    
                    let question = Question(title: title, answer: answer, color: color, expanded: false)
                    
                    questions.append(question)
                }
            }
            
            self.delegate.fetchQuestions(questions: questions)
        }
    }
    
    func postQuestion(title: String, answer: String, color: Int) {
        
        let questionRef = self.questionRef.childByAutoId()
        
        let postQuestion = Question(title: title, answer: answer, color: color, expanded: false)
        
        questionRef.setValue([
            "title": postQuestion.title,
            "answer": postQuestion.answer,
            "color": postQuestion.color,
        ])
        
        self.delegate.createQuestion(question: postQuestion)
    }
}
