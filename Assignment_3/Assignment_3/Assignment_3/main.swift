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
    var name: String
    var age: Int
    var id: Int
    var GPA: Double
    
    mutating func changeName() {
        name = "Java"
    }
    
    mutating func changeGPA() {
        GPA = 4.0
    }
}

//2. Create a student instance and call these functions.
var std = Student(name: "Kanishk", age: 24, id: 256, GPA: 3.4)
std.changeName()
std.changeGPA()

//3. Print the new value of all the four properties on the console
print(std)
