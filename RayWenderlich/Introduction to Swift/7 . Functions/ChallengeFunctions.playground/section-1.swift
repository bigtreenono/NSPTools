func sumOfMultiples(#mult1:Int, #mult2:Int, max:Int=1000) -> Int {
  var sum = 0
  for i in 0..<max {
    if i % mult1 == 0 || i % mult2 == 0 {
      sum += i
    }
  }
  return sum
}
sumOfMultiples(mult1: 3, mult2: 5)

