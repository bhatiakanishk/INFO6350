//
//  main.swift
//  Assignment_4
//
//  Created by Kanishk Bhatia on 10/13/22.
//
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
        //superclass version access
        super.init(role: .teamLeader, id: id, username: username, password: password, displayName: displayName)
    }
    //Override function for teamLeader menu
    override func printMenu() {
        print("\nTeam Leader Account")
        print("---------------------")
        print("Select an option: \n1. Create Task \n2. Update Description \n3. Update Assigned Member \n4. View Tasks \n5. Delete Task \n6. Logout \n7. Exit\n")
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
            print("Invalid input")
            print("Please select an option between 1 and 7\n")
        }
    }
    
    //Function to create a task
    func createTask() {
        print("\nEnter the account ID:")
        //Set 0 as the default if Int input is empty
        let accountID = Int(readLine() ?? "0") ?? 0
        print("\nEnter the task description:")
        //Set an empty String as the default if input is empty
        let taskDescription = readLine() ?? ""
        //Append the new task to the tasks array with the description, id, and assignedMemeber
        tasks.append(Task(desc: taskDescription, status: .todo, id: generateTaskId(), assignedMember: accountID))
    }
    
    //Function to update a task description
    func updateDescTask(){
        print("\nEnter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        print("\nEnter the new description: ")
        let updateDescription = readLine()
        //$0 is the first parameter passed
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            tasks[taskIndex].desc = updateDescription ?? ""
        }
    }
    
    //Function to update the assigned member
    func updateMemberTask(){
        print("\nEnter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        print("\nEnter the new member ID:")
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
        print("\nEnter the task ID:")
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

//TeamMember class of type Account
class TeamMember: Account {
    init(id: Int, username: String, password: String, displayName: String) {
        //superclass version access
        super.init(role: .teamMember, id: id, username: username, password: password, displayName: displayName)
    }
    //Override function for teamMember menu
    override func printMenu() {
        print("\nTeam Menu Account")
        print("---------------------")
        print("\nSelect an option: \n1. View Task \n2. Update Task Status \n3. Logout \n4. Exit\n")
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
    
    //Function to view the tasks of the logged in teamMember
    func viewTask() {
        print(tasks.filter({ $0.assignedMember == self.id }))
    }
    
    //Function to update the task status
    func updateTaskStatus() {
        print("\nEnter the task ID:")
        //Set a 0 String as the default if input is empty
        let taskID = Int(readLine() ?? "0")
        print("\nEnter the status of the task: \n1. Todo \n2. Doing \n3. Done\n")
        //Set Int 1 as the default if input is empty
        let status = Int(readLine() ?? "0") ?? 1
        if let taskIndex = tasks.firstIndex(where: {$0.id == taskID}) {
            let statusEnum = Task.taskStatus(rawValue: status) ?? .todo
            tasks[taskIndex].status = statusEnum
            if statusEnum == .doing {
                //Increase the counter
                self.onGoingTaskCount += 1
            } else {
                //Decrease the counter
                self.onGoingTaskCount -= 1
            }
        }
    }
}

//Task class with CustomStringConvertible to make debugging easy
class Task: CustomStringConvertible {
    var desc: String
    var status: taskStatus
    let id: Int
    var assignedMember: Int
    //Enum taskStatus of type Int
    enum taskStatus: Int {
        case todo = 1
        case doing
        case done
    }
    //class initializer
    init(desc: String, status: taskStatus, id: Int, assignedMember: Int) {
        self.desc = desc
        self.status = status
        self.id = id
        self.assignedMember = assignedMember
    }
    
    //function to update status of task
    func updateStatus(status: taskStatus){
        self.status = status
    }
    
    var description: String {
        return "Task ID: \(id) \nDescription: \(desc) \nMember: \(assignedMember) \nStatus: \(status)"
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
 accounts["gaurav"] = Account(role: .teamLeader, id: 10, username: "kanishk", password: "kanishk", displayName: "Kanishk")*/

//Appending teamLeaders and teamMembers to the accounts array
accounts.append(TeamLeader(id: 10, username: "gaurav", password: "gaurav", displayName: "Gaurav"))
accounts.append(TeamLeader(id: 11, username: "kanishk", password: "kanishk", displayName: "Kanishk"))

accounts.append(TeamMember(id: 20, username: "raj", password: "raj", displayName: "Raj"))
accounts.append(TeamMember(id: 21, username: "andy", password: "andy", displayName: "Andy"))

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
            print("Invalid Password\n")
            //Call login menu again
            loginMenu()
        }
    } else {
        //Username does not exist
        print("Username does not exist\n")
        //Call login menu again
        loginMenu()
    }
}

//Call the login menu
loginMenu()
