import Foundation

func randomIndex(count: Int) -> Int {
  return Int(arc4random_uniform(UInt32(count)))
}

// Your code here! Write knockKnockJoke() function
// Make an array of 3 knock knock jokes
// Return a random joke!

func knockKnockJoke() -> (who: String, punchline: String) {
  let jokes = [
    (who: "A herd", punchline: "A herd you were home, so I came over!"),
    (who: "A little old lady", punchline: "I didn't know you could yodel!"),
    (who: "Kirtch", punchline: "God bless you!")
  ]
  return jokes[randomIndex(jokes.count)]
}

let joke = knockKnockJoke()
println("Knock, knock.")
println("Who's there?")
println("\(joke.who)")
println("\(joke.who) who?")
println("\(joke.punchline)")
