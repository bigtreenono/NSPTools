// Playground - noun: a place where people can play

import UIKit

for var i = 0; i < 10; i++ {
  //println(i)
}

for i in 1 ..< 10 {
  //println(i)
}

var counter = 10
//while (counter > 0) {
//  println(counter)
//  counter -= 1
//}

//do {
//  println(counter)
//  counter -= 1
//} while (counter > 0)

let movies = ["Star Wars", "Raiders of the Lost Ark", "Aliens"]

for movie in movies {
  //println(movie)
}

let movieTypes = ["Star Wars" : "Action", "Raiders of the Lost Ark" : "Adventure", "Aliens" : "Sci-fi"]
for (key, value) in movieTypes {
  //println("The key is '\(key)'. The value is '\(value)'")
}

for (_, value) in movieTypes {
  //println("\(value)")
}

var name = "Brian"
if name == "Brian"  {
  //println("Your name is Brian")
}
//while (counter > 0) {
//  if counter > 5 {
//    println("\(counter) - Greater than five")
//  } else if counter > 2 {
//    println("\(counter) - Greater than two")
//  } else {
//    println("\(counter) - default")
//  }
//  counter -= 1
//}

//while (counter > 0) {
//  switch(counter) {
//  case 6...10:
//    println("\(counter) - Greater than five")
//  case 3...5:
//    println("\(counter) - Greater than two")
//  default:
//    println("\(counter) - default")
//  }
//  counter -= 1
//}

let names = ["Ray", "Vicki", "Brian", "Greg", "Mic", "Christine"]
for name in names {
  print(name)
  switch(name) {
  case "Vicki":
    fallthrough
  case "Ray":
    print(" - Founded Razeware")
  case let employee where employee.rangeOfString("i") != nil:
    print(" - Has an 'i' in their name.")
  case let nameLength where count(nameLength) > 3 && count(nameLength) < 5:
    print("- Hi Greg!")
  default:
    print(" - Cheers")
  }
  println("")
  
}




