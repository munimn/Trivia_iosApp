//
//  AddQuizController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/17/22.
//


import UIKit

class AddQuizController : UIViewController {
    @IBOutlet var titleField : UITextField!
    var quiz : Quiz!
    
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer) {
        titleField.resignFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleField.text = quiz.title
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        quiz.title = titleField.text!
        
    }
}
