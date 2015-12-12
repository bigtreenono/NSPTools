// Playground - noun: a place where people can play

import UIKit

class Account {
  
  var firstName: String
  var lastName: String
  var balance: Double
  var rate = 0.0
  
  init(firstName:String, lastName:String, balance:Double) {
    self.firstName = firstName
    self.lastName = lastName
    self.balance = balance
  }
  
  convenience init() {
    self.init(firstName:"", lastName:"", balance:0)
  }
  
  func interestOverYears(years:Double) -> Double {
    return 0
  }
  
  func printBreakDown() {
    var balance = NSString(format: "%f", self.balance)
    println("\(firstName) \(lastName): \(balance)")
  }
}

class CheckingAccount: Account {
  
  override init(firstName:String, lastName:String, balance:Double) {
    super.init(firstName:firstName, lastName:lastName, balance:balance)
    self.rate = 4.3
  }
  
  override func interestOverYears(years: Double) -> Double {
    return (balance * rate * years) / 100
  }

}


//var account = Account(firstName: "Brian", lastName: "Moakley", balance: 1.0)
//var account = Account()
//account.printBreakDown()

var checkingAccount = CheckingAccount(firstName: "Brian", lastName: "Moakley", balance: 1000.00)
checkingAccount.interestOverYears(1)




