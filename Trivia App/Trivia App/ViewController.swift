//
//  ViewController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/15/22.
//
import UIKit

class ViewController: UITableViewController {
    var quizlist : QuizList!
    var currentquiz : Quiz?
    var selectedquiz : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentquiz = nil
        // Do any additional setup after loading the view.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizlist.getCount()
    }
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let quiz = quizlist.getQuiz(at:indexPath.row)
        cell.textLabel?.text = quiz.title

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedquiz = indexPath.row
        self.performSegue(withIdentifier: "QuestionForQuiz", sender: self)
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddQuiz":
            let controller = segue.destination as! AddQuizController
            currentquiz = Quiz(title:"")
            controller.quiz = currentquiz
            
        case "QuestionForQuiz":
            let controller = segue.destination as! QuestionController
            controller.selectedquiz = quizlist.getQuiz(at: selectedquiz)
            
            controller.quizlist = quizlist
            
        default:
            preconditionFailure("Unexpected segue identifier")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let p = currentquiz {
            quizlist.addQuiz(p) {
                self.tableView.reloadData()
                self.currentquiz = nil
            }
        }
    }
    
    @IBAction func logOut(_ button : UIButton) {
        quizlist.user.name = ""
        quizlist.user.password = ""
        quizlist.user.key = ""
        quizlist.saveUser()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyBoard.instantiateViewController(withIdentifier: "LogIn")
        loginController.modalPresentationStyle = .fullScreen
        self.present(loginController, animated: true, completion: nil)
    }
}


