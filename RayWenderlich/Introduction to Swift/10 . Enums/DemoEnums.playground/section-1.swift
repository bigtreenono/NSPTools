// Playground - noun: a place where people can play

import UIKit

enum Monsters {
  case Lions,Tigers,Bears
}
Monsters.Bears

var randomEncounterType:Monsters = .Bears

if randomEncounterType == .Lions {
  println("growl")
} else {
  println("You got lucky!")
}

enum MoreMonsters:String {
  case Lions = "Lions",Tigers = "Tigers",Bears = "Bears"
  init() {
    self = .Bears
  }
}

var anotherEncounter:MoreMonsters = .Tigers
println("You are surrounded by \(anotherEncounter.rawValue)")

var monsters = MoreMonsters()
monsters.rawValue

enum Contact {
  case NoContact
  case Email(String)
  case Phone(Int)
}

let contact = Contact.Phone(5555555)
let anotherContact = Contact.Email("user@mycompany.com")

switch anotherContact {
  case .Email(let email):
    println(email)
  default:
    println("nothing")
}







