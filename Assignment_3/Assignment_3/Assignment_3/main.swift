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
//3. Create a function that takes a string as input and checks whether the string is palindrome or not. Print the result on the console (true or false).
