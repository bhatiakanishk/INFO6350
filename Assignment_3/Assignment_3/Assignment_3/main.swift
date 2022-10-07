//
//  main.swift
//  Assignment_3
//
//  Created by Kanishk Bhatia on 10/6/22.
//
import Foundation

//Functions
//1. Create a function that implements the factorial operator( ! )
func factorial(n: Int) -> Int {
    var result = 1
    if(n>0){
        for i in 1...n {
            result *= i
        }
    }
    return result
}
let num = 5
let result = factorial(n: num)
print("\(num)! = \(result)")


//2.Create a function that takes an array of integers as input and split it into two arrays of odd and even integers. Print the result on the console(two arrays).
func splitArray(arr: [Int]) -> (odd: [Int], even: [Int]){
    var oddArray: [Int] = []
    var evenArray: [Int] = []
    
    for x in arr {
        if(x.isMultiple(of: 2)){
            evenArray.append(x)
        } else {
            oddArray.append(x)
        }
    }
    return (oddArray, evenArray)
}

let split = splitArray(arr: [1,2,3,4])
print(split)

//3. Create a function that takes a string as input and checks whether the string is palindrome or not. Print the result on the console (true or false).
func isPalindrome(str: String) -> Bool {
    let reversedString = String(str.reversed())
    
    if(str != "" && str == reversedString) {
        return true
    } else {
        return false
    }
}

print(isPalindrome(str: "nitin"))


//Structures
//1. Create a structure Student. This structure should have
//• four properties: name, age, id, and GPA.
//• a function that can change the name.
//• a function that can change the GPA.
struct Student {
    var name = "Kanishk"
    var age = 24
    var id = 10
    var GPA = 3.5
    
    mutating func changeName(name: String) {
        self.name = name
    }
    
    mutating func changeGPA(GPA: Double) {
        self.GPA = GPA
    }
}

//2. Create a student instance and call these functions.
var std = Student()
std.changeName(name: "Raj")
std.changeGPA(GPA: 4.0)

//3. Print the new value of all the four properties on the console
print(std)

//Classes
//1. Create a class Ipad. This class should have
//• an empty function doesSupportApplePencil()
//• an empty function sizeOfScreen()
class Ipad {
    func doesSupportApplePencil(){}
    func sizeOfScreen(){}
}

//2. Create a classe (for example IpadPro5) as a subclass of Ipad and override these functions.
class IpadPro: Ipad {
    override func doesSupportApplePencil() {
        print("Override func doesSupportApplePencil()")
    }
    override func sizeOfScreen() {
        print("Override func sizeOfScreen()")
    }
}

//3. Call these functions
var IpadPro5 = IpadPro()
IpadPro5.doesSupportApplePencil()
IpadPro5.sizeOfScreen()

//Optionals
//1. Ask the user to enter Mobile Number, and take input using the command line.
//• If no input was provided print ‘No Mobile number provided’
//• If the input is all numbers print ‘Mobile Number in Digits’ followed by the number
//• Otherwise, print ‘Mobile Number in String’ followed by the String entered
print("Enter the mobile number: ")
let input: String? = readLine()
if input != nil {
    if(Int(input!) != nil){
        print("Mobile Number in Digits: \(input!)")
    } else {
        print("Mobile Number in String: \(input!)")
    }
}

//Protocols
//1. Create a protocol TransportationTool. This protocol should have
//• a function that returns the number of wheels
//• a function that returns the way of transportation (in the air, on the ground, on the water).
//• a function that takes place of departure and destination as inputs and prints a sentence like “From xx to xx by xx”.
protocol TransportationTool {
    func numberOfWheels() -> Int
    func wayOfTransportation() -> String
    func fromTo(from: String, to: String)
}
//2. Define two classes that conform to this protocol. (car, ship, bicycle, etc.)
class Bicycle: TransportationTool{
    let wheels = 2
    let transportation = "on the ground"
    
    func numberOfWheels() -> Int {
        return wheels
    }
    
    func wayOfTransportation() -> String {
        return transportation
    }
    
    func fromTo(from: String, to: String) {
        print("From \(from) to \(to) by \(numberOfWheels()) wheel/s \(wayOfTransportation())")
    }
}

class Aeroplane: TransportationTool{
    let wheels = 18
    let transportation = "in the air"
    
    func numberOfWheels() -> Int {
        return wheels
    }
    
    func wayOfTransportation() -> String {
        return transportation
    }
    
    func fromTo(from: String, to: String) {
        print("From \(from) to \(to) by \(numberOfWheels()) wheel/s \(wayOfTransportation())")
    }
}

var bicycle = Bicycle()
bicycle.fromTo(from: "Snell Library", to: "Ruggels Station")
var aeroplane = Aeroplane()
aeroplane.fromTo(from: "Boston", to: "Mumbai")

//Closures
//1. Create a closure that takes two Integers as inputs and returns the sum.
var sum = { (num1: Int, num2: Int) -> (Int) in
    let sum = num1 + num2
    return sum
}
var sumOfTwo = sum(2,3)
print("Sum = ", sumOfTwo)

//Enumerations
//1. Rewrite the way of transportation of TransportationTool into an enumeration.
//2. Create an associate enumeration that has:
//• a case GPA that associates two Double values(like 3.9, 4.0, 2.6).
//• a case Grade that associates two String values(like “A”,”B”,”C”).
//3. Create a GPA enumeration instance and Grade enumeration instance

//Extensions
//1. Create a class Distance that has a property:  valueInKilometer.
//2. Create an extension to the Distance class that has: a function that returns the mile value of valueInKilometer.
