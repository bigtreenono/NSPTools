// Playground - noun: a place where people can play

import UIKit

let whazzup = "Whazzup"
let dawg = "Dawg"
var greeting = whazzup + " " + dawg
greeting

greeting = greeting + "!"
greeting += "!"

var constantGreeting = "Welcome"
constantGreeting += ", Mic!"

let kermit = "Kermit"
let msPiggy = "Ms. Piggy"

var love = msPiggy + " and " + kermit + ", sitting in a tree."
var love2 = "\(msPiggy) and \(kermit), sitting in a tree."
let fingers = "Kermit has \(5*2) fingers."
let fingers2 = "Kermit has " + String(5*2) + " fingers."

let kermit1 = "kermit"
let kermit2 = "kerm" + "it"

kermit1 == kermit2

let kermit3 = "KeRmIt"
let kermit4 = "kermit"

kermit3.lowercaseString == kermit4.lowercaseString

var empty1 = ""
var empty2 = String()
empty1.isEmpty && empty2.isEmpty


let str1 = String(1)
//let str2 = String(3.14)
let str2 = NSString(format: "%0.2f", 3.14)

let myScore = "1".toInt()
if let myScore = myScore {
  println(myScore)
}
let pi = ("3.14" as NSString).doubleValue

var flappy = "Flappy Felipe"
(flappy as NSString).containsString("Felipe")

let englishMorning = "Good Morning"
let japaneseMorning = "おはよう"

let おはよう = "hi"
おはよう
let valentinesDay:Character = "💝"
let halloween:Character = "🎃"
var holidays = ""

holidays.append(valentinesDay)
holidays.append(halloween)
holidays

let π = 3.14
let radius = 100 / π * 2

count(holidays)
count(kermit)

count(kermit.utf16)
count(holidays.utf16)



















