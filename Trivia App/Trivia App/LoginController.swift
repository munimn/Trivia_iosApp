//
//  LoginController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/16/22.
//

import UIKit

class LoginController: UIViewController {
    var quizlist : QuizList = QuizList()
    @IBOutlet var user : UITextField!
    @IBOutlet var password : UITextField!
    
    @IBAction func newUser(_ source : UIButton) {
        quizlist.user.name = user.text!
        quizlist.user.password = password.text!
        quizlist.newUser(success: {self.goToMain()},failure: {self.showAlert(message: "Add new user failed")})
    }
    
    @IBAction func login(_ source : UIButton) {
        if let name = user!.text, let pwd = password!.text {
            guard !name.isEmpty else {
                showAlert(message: "You must provide a user name")
                return
            }
            guard !pwd.isEmpty else {
                showAlert(message: "You must provide a password")
                return
            }
            quizlist.user.name = name
            quizlist.user.password = pwd
            quizlist.getKey(success:{self.goToMain()},failure:{self.showAlert(message: "Login failed")})
        }
    }
    
    func goToMain() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "Quizzes") as! UINavigationController
        let listView = mainViewController.viewControllers.first as! ViewController
        listView.quizlist = quizlist
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    func showAlert(message msg : String) {
        let alert = UIAlertController(title:nil,message: msg,preferredStyle: .alert)
        let ok = UIAlertAction(title:"OK",style:.default) { action in }
        alert.addAction(ok)
        self.present(alert,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !quizlist.user.key.isEmpty {
            quizlist.refresh {
                self.goToMain()
            }
        }
    }
}
