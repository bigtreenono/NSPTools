for x in 1...100 {
  let multipleOf3 = x % 3 == 0
  let multipleOf5 = x % 5 == 0
  if (multipleOf3 && multipleOf5) {
    println("FizzBuzz")
  } else if (multipleOf3) {
    println("Fizz")
  } else if (multipleOf5) {
    println("Buzz")
  } else {
    println("\(x)")
  }
}
