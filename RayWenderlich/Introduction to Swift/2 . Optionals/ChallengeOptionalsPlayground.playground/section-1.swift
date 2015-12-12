// Playground - noun: a place where people can play

import UIKit

var name:String? = "Brian"
var greeting = "Hello,"

if let name = name {
    println(greeting + " " + name)
}

println(greeting + " " + name!)
