//
//  QuestionController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/17/22.
//

import UIKit
class QuestionController: UITableViewController{
    var quizlist: QuizList!
    var selectedquiz : Quiz!
    var currentquestion : Question?
    var currentAnswer : Answer?
    var selectedQues: Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        quizlist.getquestions(selectedquiz){
            self.tableView.reloadData()
        }
        currentquestion = nil
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizlist.getCountQues()
    }
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let question = quizlist.getQuestions(at:indexPath.row)
        cell.textLabel?.text = question.question

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedQues = indexPath.row
        self.performSegue(withIdentifier: "Answer", sender: self)

    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddQuestion":
            let controller = segue.destination as! AddQuestionController
            currentquestion = Question(question: "", options: "", answer: 0)
            controller.question = currentquestion
            controller.quiz = selectedquiz
        case "Answer":
            let controller = segue.destination as! AnswerController
            currentAnswer = Answer(response: 0, question: selectedQues+1)
            controller.Answer = currentAnswer
            controller.selectedquestion = quizlist.getQuestions(at: selectedQues)
            controller.quizlist = quizlist
            controller.quiz = selectedquiz
         

        default:
            preconditionFailure("Unexpected segue identifier")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let p = currentquestion {
            quizlist.addQuestion(selectedquiz, p) {
                self.tableView.reloadData()
                self.currentquestion = nil
            }
        }
    }
    
   
}




