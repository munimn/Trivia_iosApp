//
//  LeaderboardController.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/18/22.
//

import UIKit

class LeaderboardController: UITableViewController {
    var quizlist : QuizList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !quizlist.user.key.isEmpty {
            quizlist.leaderlist{
   
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !quizlist.user.key.isEmpty {
            quizlist.leaderlist{
                self.tableView.reloadData()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizlist.getCountleader()
    }
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let leader = quizlist.getLeader(at:indexPath.row)
        cell.textLabel?.text = leader.name
        cell.detailTextLabel?.text = String(leader.score)

        return cell
    }
        @IBAction func NewQuiz(_ button : UIButton) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "Quizzes") as! UINavigationController
            let listView = mainViewController.viewControllers.first as! ViewController
            quizlist.result = ""
            listView.quizlist = quizlist
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    
    }


