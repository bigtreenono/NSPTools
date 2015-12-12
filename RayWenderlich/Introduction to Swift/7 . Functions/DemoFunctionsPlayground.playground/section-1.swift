// Playground - noun: a place where people can play

import UIKit

func count(#targetNumber:Int) ->() {
  for n in 0 ... targetNumber {
    println(n)
  }
}
count(targetNumber:10)

func countTo(targetNumber:Int,by:Int = 2, #dividedBy:Int) {
  for var i = 0; i < targetNumber; i += by {
    println(i)
  }
}
countTo(10, by:5, dividedBy:2)

func bizzaroCase(inout text:String) -> String {
  text += "!"
  var result = ""
  for (index, element) in enumerate(text) {
    var letter = String(element)
    if index % 2 == 0 {
      result += letter.uppercaseString
    } else {
      result += letter.lowercaseString
    }
  }
  return result
}
var hello = "Hello World"
bizzaroCase(&hello)
hello

func bizzaroCase2(text:String...) -> [String] {
  var results = [String]()
  for item in text {
    var result = ""
    for (index, element) in enumerate(item) {
      var letter = String(element)
      if index % 2 == 0 {
        result += letter.uppercaseString
      } else {
        result += letter.lowercaseString
      }
    }
    results.append(result)
  }
  return results
}

var text = "He thrusts his fist against the post and still insists that he sees ghosts."
var text2 = "She sells seashells by the seashore."
let bizzaro = bizzaroCase2(text)
bizzaro








