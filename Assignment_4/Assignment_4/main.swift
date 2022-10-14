//
//  main.swift
//  Assignment_4
//
//  Created by Kanishk Bhatia on 10/13/22.
//
/*Develop a command line Swift program to create a simple version of an agile software management.
 A.    Account should have:
 •    role: Enumeration of TeamLeader / TeamMember.
 •    id: Int
 •    username: String.
 •    password: String.
 •    displayName: String.
 B.    Task has the following properties:
 •    description: String.
 •    status: Enumeration of TODO/DOING/DONE.
 •    id: Int.
 •    assignedMember: Whatever type you select.
 C.    Team leader should be able to:
 •    Create Task.
 •    Update Task (update property: description & assignedMember).
 •    View Tasks.
 •    Delete Task.
 D.    Team member should be able to:
 •    View Tasks that are assigned to him.
 •    Update Task (update property: status).
 Constraints:
 •    Feel free to add any other properties
 •    When a member has >= 2 DOING tasks, this member should not be assigned new tasks.
 •    When a task is in DOING status, it should not be deleted or assigned to a new member.
 •    When a task is in DONE status, it should not be assigned to a new member.
 •    All inputs and outputs are from and to the console. No graphical user interface is required/needed.
 •    It will be Menu driven program, please give the user some options to move to the next step or to go back.
 •    The purpose of this assignment is to practice Swift constructs (classes, instances, properties, etc…). The evaluation of your solution will take this into consideration.
 •    You can create an extension to the String type to add a method to read from standard input (i.e. console). You can use the Swift standard library function: readLine() to read a string
 */

import Foundation
class Account {
    let role: accountType
    let id: Int
    let username: String
    let password: String
    let displayName: String
    
    enum accountType {
        case teamLeader
        case teamMember
    }
    
    init(role: accountType, id: Int, username: String, password: String, displayName: String) {
        self.role = role
        self.id = id
        self.username = username
        self.password = password
        self.displayName = displayName
    }
}

class TeamLeader: Account {
    func createTask(){
        
    }
    func updateDescTask(){}
    func updateMemberTask(){}
    func viewTask(){}
    func deleteTask(){}
}

class TeamMember: Account {
    func viewTask(){}
    func updateTaskStatus(){
        print("Enter Task ID:")
        let taskID = readLine()
    }
}

class Task {
    let description: String
    let status: taskStatus
    let id: Int
    let assignedMember: Account
    enum taskStatus {
        case todo
        case doing
        case done
    }
    init(description: String, status: taskStatus, id: Int, assignedMember: Account) {
        self.description = description
        self.status = status
        self.id = id
        self.assignedMember = assignedMember
    }
}

var accounts: [Account] = []
var tasks: [Task] = []

/*var accounts: [String: Account] = [:]
accounts["gaurav"] = Account(role: .teamLeader, id: 10, username: "gaurav", password: "noob", displayName: "Gaurav")*/

accounts.append(Account(role: .teamLeader, id: 10, username: "gaurav", password: "noob", displayName: "Gaurav"))
accounts.append(Account(role: .teamLeader, id: 11, username: "kanishk", password: "testing", displayName: "Kanishk"))
accounts.append(Account(role: .teamMember, id: 20, username: "raj", password: "raj1", displayName: "Raj"))

func loginMenu(){
    print("Enter username:")
    print("Enter password:")
    var userName = readLine()
    var password = readLine()
    
/*    if let account = accounts[userName] {
        // we have the account here
        if account.passwd == password {
            // auth success
        } else {
            //in valid password
        }
    } else {
        // user name does not exist
    }*/
    
    
    if let account = accounts.first(where: { $0.username == userName }) {
        // we have the account here
        if account.password == password {
            // auth success
        } else {
            //in valid password
        }
    } else {
        // user name does not exist
    }
}
