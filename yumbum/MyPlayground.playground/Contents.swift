//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var i = 0
if (i = 0) {
    // Doesn't work 😱
}
if (i == 0) {
    // Works💁🏻
}


let 🐱 = "foo"
var 👀 = "bar"

let foo :Int = 1
let bar :String = "one"

func count(string: String) -> (vowels: Int, consonants: Int, others: Int) {
    let vowels = 0, consonants = 0, others = 0
    // something
    return (vowels, consonants, others)
}

func swapTwoValues<T>(var input a:T, var input b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

swapTwoValues(input: 1, input: 1)
swapTwoValues(input: "hello", input: "goodbye")


let _ = 1

operator prefix +++ _ = _ = {}
prefix @assignment func +++ (left: Int, right:Int) -> Int {
    return left + right
}

var someValue = 2+++3