//
//  AnswerController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/18/22.
//
import UIKit
import Foundation
class AnswerController : UIViewController {
    @IBOutlet var questionField : UILabel!
    @IBOutlet var optionsField : UILabel!
    @IBOutlet var resultField : UILabel!
    @IBOutlet var answerField : UITextField!
    var selectedquestion : Question!
    var quizlist : QuizList!
    var quiz : Quiz!
    var Answer : Answer!
    
    @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer) {
            answerField.resignFirstResponder()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionField.text = "Question :\(selectedquestion.question)"
        optionsField.text = "Options :\(selectedquestion.options)"
        answerField.text = String(Answer.response)
    }
    @IBAction func checkAnswer(_ source : UIButton){
        Answer.response = Int(answerField.text!)!
        quizlist.addAnswer(Answer, quiz,success:{
            if self.quizlist.result == "Wrong"{
                self.showAlert(message: "Your Answer is Wrong! Go to LeaderBoard")
                self.resultField.text = "Your Answer is Wrong! Go to LeaderBoard"
            }
            if self.quizlist.result == "Correct"{
                self.showAlert(message: "Your Answer is Correct! Go to LeaderBoard")
                self.resultField.text = "Your Answer is Correct! Go to LeaderBoard"
            }
            if self.quizlist.result == "Duplicate answer"{
                self.showAlert(message: "You've answered this before Go to LeaderBoard")
                self.resultField.text = "You've answered this before Go to LeaderBoard"
            }
            
        },failure:{self.showAlert(message: "There is a Problem")})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "LeaderboardShow":
            let controller = segue.destination as! LeaderboardController
            controller.quizlist = quizlist
        default:
            preconditionFailure("Unexpected segue identifier")
        }

    }
    
    func showAlert(message msg : String) {
        let alert = UIAlertController(title:nil,message: msg,preferredStyle: .alert)
        let ok = UIAlertAction(title:"OK",style:.default) { action in }
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil)
    }
    

    
    
    
    
    

}
