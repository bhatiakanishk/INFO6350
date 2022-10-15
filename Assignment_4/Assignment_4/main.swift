//
//  main.swift
//  Assignment_4
//
//  Created by Kanishk Bhatia on 10/13/22.
//
/* Develop a command line Swift program to create a simple version of an agile software management.
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
    var onGoingTaskCount: Int = 0
    
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
    
    func printMenu() {
        fatalError("Must Override")
    }
}

class TeamLeader: Account {
    
    init(id: Int, username: String, password: String, displayName: String) {
        super.init(role: .teamLeader, id: id, username: username, password: password, displayName: displayName)
    }
    
    override func printMenu() {
        print("Enter an option: \n1. Create Task \n2. Update Description \n3. Update Assigned Member \n4. View Tasks \n5. Delete Task \n6. Exit")
        let printOption = Int(readLine() ?? "")
        switch printOption {
        case 1:
            createTask()
        case 2:
            updateDescTask()
        case 3:
            updateMemberTask()
        case 4:
            viewTasks()
        case 5:
            deleteTask()
        case 6:
            loginMenu()
        default:
            print("Invalid input")
        }
    }
    
    func createTask(){
        print("Enter Task description:")
        let taskDescription = readLine() ?? ""
        print("Enter Account ID:")
        let accountID = Int(readLine() ?? "0") ?? 0
        tasks.append(Task(desc: taskDescription, status: .todo, id: generateTaskId(), assignedMember: accountID))
    }
    
    func updateDescTask(){
        print("Enter Task ID:")
        let taskID = Int(readLine() ?? "0")
        print("Enter new description: ")
        let updateDescription = readLine()
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            tasks[taskIndex].desc = updateDescription ?? ""
        }
    }
    
    func updateMemberTask(){
        print("Enter Task ID:")
        let taskID = Int(readLine() ?? "0")
        print("Enter Member ID: ")
        let memberId = Int(readLine() ?? "0")
        if let account = accounts.first(where: { $0.id == memberId }) {
            if account.onGoingTaskCount >= 2 {
                print("Cannot Assign")
            } else if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}){
                if tasks[taskIndex].status == .todo {
                    tasks[taskIndex].assignedMember = memberId ?? 0
                } else {
                    print("Cannot change status of on going or done task")
                }
            } else {
                print("Invalid Account ID")
            }
        }
    }
    
    func viewTasks(){
        print(tasks)
    }
    func deleteTask(){
        print("Enter Task ID:")
        let taskID = Int(readLine() ?? "0")
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            //tasks[taskIndex].status = Task.taskStatus(rawValue: status ?? 1) ?? .todo
            if tasks[taskIndex].status != .doing {
                tasks.remove(at: taskIndex)
                print("Delete Success")
            } else {
                print("Cannot delete on going task")
            }
        } else {
            print("Enter valid task id")
        }
    }
}

class TeamMember: Account {
    init(id: Int, username: String, password: String, displayName: String) {
        super.init(role: .teamMember, id: id, username: username, password: password, displayName: displayName)
    }
    
    override func printMenu() {
        print("Enter an option: \n1. View Task \n2. Update Task Status \n3. Exit")
        let printOption = Int(readLine() ?? "")
        switch printOption {
        case 1:
            viewTask()
        case 2:
            updateTaskStatus()
        case 3:
            exit(0)
        default:
            print("Invalid input")
        }
    }
    
    func viewTask(){
        print(tasks.filter({ $0.assignedMember == self.id }))
    }
    
    func updateTaskStatus(){
        print("Enter Task ID:")
        let taskID = Int(readLine() ?? "0")
        print("Enter Status: \n1. Todo \n2. Doing \n3. Done")
        let status = Int(readLine() ?? "0") ?? 1
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            let statusEnum = Task.taskStatus(rawValue: status) ?? .todo
            tasks[taskIndex].status = statusEnum
            if statusEnum == .doing {
                self.onGoingTaskCount += 1
            } else {
                self.onGoingTaskCount -= 1
            }
        }
    }
}

class Task: CustomStringConvertible {
    var desc: String
    var status: taskStatus
    let id: Int
    var assignedMember: Int
    enum taskStatus: Int {
        case todo = 1
        case doing
        case done
    }
    init(desc: String, status: taskStatus, id: Int, assignedMember: Int) {
        self.desc = desc
        self.status = status
        self.id = id
        self.assignedMember = assignedMember
    }
    
    func updateStatus(status: taskStatus){
        self.status = status
    }
    
    var description: String {
        return "\(id) \(status) \(assignedMember) \(desc)"
    }
}

var accounts: [Account] = []
var tasks: [Task] = []
var taskCount = 0
func generateTaskId() -> Int {
    taskCount += 1
    return taskCount
}

/*var accounts: [String: Account] = [:]
 accounts["gaurav"] = Account(role: .teamLeader, id: 10, username: "gaurav", password: "noob", displayName: "Gaurav")*/

accounts.append(TeamLeader(id: 10, username: "gaurav", password: "gaurav", displayName: "Gaurav"))
accounts.append(TeamLeader(id: 11, username: "kanishk", password: "kanishk", displayName: "Kanishk"))
accounts.append(TeamMember(id: 20, username: "raj", password: "raj", displayName: "Raj"))

func loginMenu(){
    print("Enter username:")
    let userName = readLine()
    print("Enter password:")
    let password = readLine()
    
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
            while (true){
                account.printMenu()
            }
        } else {
            //in valid password
            print("Invalid Password")
        }
    } else {
        // user name does not exist
        print("Username does not exist")
    }
}


loginMenu()
