// Playground - noun: a place where people can play

import UIKit

let gameType = ["Fallout" : "RPG", "Hearthstone" : "Card Game", "Angry Birds" : "Physics Puzzler"]

let gameTypesExplicit:Dictionary<String,String> = ["Fallout" : "RPG", "Hearthstone" : "Card Game", "Angry Birds" : "Physics Puzzler"]

let gameTypesExplicit2:[String: String] = ["Fallout" : "RPG", "Hearthstone" : "Card Game", "Angry Birds" : "Physics Puzzler"]

let gameTypesEmpty = Dictionary<String,String>()


let game = "Hearthstone!"
if let gameType = gameType[game] {
  println("\(game) is a \(gameType)")
} else {
  println("Sorry, never heard of \(game)")
}
gameType.count

//gameType["Super Mario Brothers"] = "Platformer"
var mutable = gameType
mutable["Super Mario Brothers"] = "Platformer"
mutable["Angry Birds"] = "Rio Game"
//mutable["Fallout"] = nil
mutable.removeValueForKey("Fallout")
mutable

for (game, type) in mutable {
  println("[Unsorted] \(game) is a \(type)")
}
let sortedKeys = sorted(Array(mutable.keys))
for game in sortedKeys {
  let type = mutable[game]!
  println("[Sorted] \(game) is a \(type)")
}




