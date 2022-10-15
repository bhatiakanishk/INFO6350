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

//Account class with role, id, username, password, displayName, onGoingTaskCount
class Account {
    let role: accountType
    let id: Int
    let username: String
    let password: String
    let displayName: String
    var onGoingTaskCount: Int = 0
    //Enum accountType; teamLeader and teamMember
    enum accountType {
        case teamLeader
        case teamMember
    }
    //Class initializer
    init(role: accountType, id: Int, username: String, password: String, displayName: String) {
        self.role = role
        self.id = id
        self.username = username
        self.password = password
        self.displayName = displayName
    }
    //printMenu function
    func printMenu() {
        //fatalError with message to stop execution
        fatalError("Must Override")
    }
}

//TeamLeader class of type Account
class TeamLeader: Account {
    //Class Initializer
    init(id: Int, username: String, password: String, displayName: String) {
        super.init(role: .teamLeader, id: id, username: username, password: password, displayName: displayName)
    }
    //Override function for teamLeader menu
    override func printMenu() {
        print("\nEnter an option: \n1. Create Task \n2. Update Description \n3. Update Assigned Member \n4. View Tasks \n5. Delete Task \n6. Logout \n7. Exit\n")
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
        case 7:
            exit(0)
        default:
            print("Invalid input\n")
            print("Please select an option between 1 and 7\n")
        }
    }
    
    //Function to create a task
    func createTask() {
        print("Enter the account ID:")
        //Set 0 as the default if Int input is empty
        let accountID = Int(readLine() ?? "0") ?? 0
        print("Enter the task description:")
        //Set an empty String as the default if input is empty
        let taskDescription = readLine() ?? ""
        //Append the new task to the tasks array with the description, id, and assignedMemeber
        tasks.append(Task(desc: taskDescription, status: .todo, id: generateTaskId(), assignedMember: accountID))
    }
    
    //Function to update a task description
    func updateDescTask(){
        print("Enter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        print("Enter the new description: ")
        let updateDescription = readLine()
        //$0 is the first parameter passed
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            tasks[taskIndex].desc = updateDescription ?? ""
        }
    }
    
    //Function to update the assigned member
    func updateMemberTask(){
        print("Enter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        print("Enter the new member ID:")
        //Set a 0 String as the default if input is empty
        let memberId = Int(readLine() ?? "0")
        //$0 is the first parameter passed
        if let account = accounts.first(where: { $0.id == memberId }) {
            //>= 2 DOING tasks, this member should not be assigned new tasks
            if account.onGoingTaskCount >= 2 {
                print("Cannot assign a new task\n")
            } else if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}){
                if tasks[taskIndex].status == .todo {
                    tasks[taskIndex].assignedMember = memberId ?? 0
                } else {
                    print("Cannot change status of the on-going or done task\n")
                }
            } else {
                print("Invalid account ID\n")
            }
        }
    }
    
    //Function to view all the tasks
    func viewTasks(){
        print(tasks)
    }
    
    //Function to delete a task
    func deleteTask(){
        print("Enter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        //$0 is the first parameter passed
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            //tasks[taskIndex].status = Task.taskStatus(rawValue: status ?? 1) ?? .todo
            if tasks[taskIndex].status != .doing {
                tasks.remove(at: taskIndex)
                print("Delete Successful\n")
            } else {
                print("Cannot delete on-going task\n")
            }
        } else {
            print("Enter a valid task id\n")
        }
    }
}

class TeamMember: Account {
    init(id: Int, username: String, password: String, displayName: String) {
        super.init(role: .teamMember, id: id, username: username, password: password, displayName: displayName)
    }
    
    override func printMenu() {
        print("\nEnter an option: \n1. View Task \n2. Update Task Status \n3. Logout \n4. Exit\n")
        let printOption = Int(readLine() ?? "")
        switch printOption {
        case 1:
            viewTask()
        case 2:
            updateTaskStatus()
        case 3:
            loginMenu()
        case 4:
            exit(0)
        default:
            print("Invalid input\n")
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

//Empty account array
var accounts: [Account] = []

//Empty task array
var tasks: [Task] = []
var taskCount = 0

//Function to generate task ID for new tasks
func generateTaskId() -> Int {
    taskCount += 1
    return taskCount
}

//HashMap attempt
/*var accounts: [String: Account] = [:]
 accounts["gaurav"] = Account(role: .teamLeader, id: 10, username: "gaurav", password: "noob", displayName: "Gaurav")*/

//Appending teamLeaders and teamMembers to the accounts array
accounts.append(TeamLeader(id: 10, username: "gaurav", password: "gaurav", displayName: "Gaurav"))
accounts.append(TeamLeader(id: 11, username: "kanishk", password: "kanishk", displayName: "Kanishk"))
accounts.append(TeamMember(id: 20, username: "raj", password: "raj", displayName: "Raj"))

//Function to input the account credentials from the user
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
        //We have the account here
        if account.password == password {
            //Authorization successful
            while (true){
                account.printMenu()
            }
        } else {
            //Invalid password
            print("Invalid Password")
        }
    } else {
        //Username does not exist
        print("Username does not exist")
    }
}

//Call the login menu
loginMenu()
