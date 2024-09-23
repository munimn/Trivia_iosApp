//
//  AddQuestionController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/18/22.
//


import UIKit

class AddQuestionController : UIViewController {
    @IBOutlet var questionField : UITextField!
    @IBOutlet var optionsField : UITextField!
    @IBOutlet var answerField : UITextField!
    var question : Question!
    var quiz : Quiz!
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer) {
        questionField.resignFirstResponder()
        optionsField.resignFirstResponder()
        answerField.resignFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionField.text = question.question
        optionsField.text = question.options
        answerField.text = String(question.answer)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        question.quiz = quiz.id
        question.question = questionField.text!
        question.options = optionsField.text!
        question.answer = Int(answerField.text! )!
        
    }
}
