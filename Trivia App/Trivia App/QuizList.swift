//
//  QuizList.swift
//  Trivia App
//
//  Created by Nafis Ahmed Munim on 10/16/22.
//

import Foundation
import UIKit

class QuizList {
    private var quizees : [Quiz]
    var questions : [Question]
    var leaderboard : [Leaders]
    var answer : Answer
    var user : QuizUser
    var result : String
    
    let archiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("user.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: archiveURL)
            let unarchiver = PropertyListDecoder()
            user = try unarchiver.decode(QuizUser.self, from: data)
        } catch {
            user = QuizUser()
        }
        quizees = []
        questions = []
        leaderboard = []
        answer = Answer(response: 0, question: 0)
        result = ""
    }

    func getCount() -> Int {
        return quizees.count
    }
    func getCountQues() -> Int{
        return questions.count
    }
    func getCountleader() -> Int {
        return leaderboard.count
    }
    func getQuestions(at n : Int) ->Question{
        return questions[n]
    }
    func getQuiz(at n : Int) ->Quiz{
        return quizees[n]
    }
    func getLeader(at n : Int) ->Leaders{
        return leaderboard[n]
    }
    

    func saveUser() {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(user)
            try data.write(to: archiveURL)
        } catch {
        }
    }

    func newUser(success callback : @escaping () -> Void,failure complain : @escaping () -> Void) {
        let jsonData = try? JSONEncoder().encode(user)
        let urlStr = "https://cmsc106.net/trivia/users"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,(response as! HTTPURLResponse).statusCode == 200 else {
                DispatchQueue.main.async {
                        complain()
                    }
                return
            }
            self.user.key = String(decoding: data!, as: UTF8.self)
            DispatchQueue.main.async {
                self.saveUser()
            }
            self.refresh(callback)
        }
        task.resume()
    }
    
    func getKey(success callback : @escaping () -> Void,failure complain : @escaping () -> Void) {
        if !user.name.isEmpty, !user.password.isEmpty {
            let urlStr = "https://cmsc106.net/trivia/users?user=\(user.name)&password=\(user.password)"
            let url = URL(string: urlStr)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard error == nil,(response as! HTTPURLResponse).statusCode == 200 else {
                    DispatchQueue.main.async {
                            complain()
                        }
                    return
                }
                self.user.key = String(decoding: data!, as: UTF8.self)
                DispatchQueue.main.async {
                    self.saveUser()
                }
                self.refresh(callback)
            }
            task.resume()
        }
    }
    
    func refresh(_ callback : @escaping () -> Void) {
        if !user.key.isEmpty {
            let urlStr = "https://cmsc106.net/trivia/quizzes"
            let url = URL(string: urlStr)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                if error == nil {
                self.quizees = try! JSONDecoder().decode([Quiz].self, from: data!)
                DispatchQueue.main.async {
                        callback()
                    }
                }
            }
            task.resume()
        }
    }
    func leaderlist(_ callback : @escaping () -> Void) {
        if !user.key.isEmpty {
            let urlStr = "https://cmsc106.net/trivia/leaders"
            let url = URL(string: urlStr)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                if error == nil {
                self.leaderboard = try! JSONDecoder().decode([Leaders].self, from: data!)
                DispatchQueue.main.async {
                        callback()
                    }
                }
            }
            task.resume()
        }
    }
    func getquestions(_ q: Quiz,_ callback: @escaping () -> Void) {
        if !user.key.isEmpty {
            let urlStr = "https://cmsc106.net/trivia/questions?quiz=\(q.id)"
            let url = URL(string: urlStr)
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                if error == nil {
//                print(String(data: data! , encoding: String.Encoding.utf8)!)
                self.questions = try! JSONDecoder().decode([Question].self, from: data!)
                DispatchQueue.main.async {
                        callback()
                    }
                }
            }
            task.resume()
        }
    }
        
    
    func addQuiz(_ q : Quiz,_ callback : @escaping () -> Void) {
        let jsonData = try? JSONEncoder().encode(q)
        let urlStr = "https://cmsc106.net/trivia/quizzes?publisher=\("L01218338")"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
//            print(String(data: data! , encoding: String.Encoding.utf8)!)
            self.refresh(callback)
        }
        task.resume()
    }
    func addQuestion(_ qui: Quiz,_ q: Question,_ callback : @escaping () -> Void) {
        let jsonData = try? JSONEncoder().encode(q)
        let urlStr = "https://cmsc106.net/trivia/questions?publisher=\("L01218338")"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
            
            self.getquestions(qui, callback )
        }
        task.resume()
    }
    func addAnswer(_ a: Answer,_ qui: Quiz,success callback : @escaping () -> Void,failure complain : @escaping () -> Void) {
        let jsonData = try? JSONEncoder().encode(a)
        let urlStr = "https://cmsc106.net/trivia/answers/\(user.key)"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                        complain()
                    }
                return
            }
            self.result = String(decoding: data!, as: UTF8.self)
            print(self.result)
            self.getquestions(qui, callback)
        }
        task.resume()
    
    }
    
    

}
