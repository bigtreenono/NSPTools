// Playground - noun: a place where people can play

import UIKit

let starWarsMovies = ["A New Hope", "The Empire Strikes Back", "The Return of the Jedi"]

let starWarsMoviesExplicit:Array<String> = starWarsMovies

let starWarsMoviesExplicit2:[String] = starWarsMovies

let starWarsMoviesEmpty:[String] = []

let firstMovie = starWarsMovies[0]
let lastMovie = starWarsMovies[starWarsMovies.count - 1]
let empire = starWarsMovies[1]
starWarsMovies.isEmpty

let index = find(starWarsMovies, "The Return of the Jedi")
if let index = index {
  println("Found at \(index): \(starWarsMovies[index])")
} else {
  println("Not found!")
}


let immutable = starWarsMovies
//immutable.append("The Star Wars Holiday Special")
var mutable = starWarsMovies
mutable.append("The Force Awakens")

mutable.removeAtIndex(3)
mutable.removeLast()
//mutable.removeAll(keepCapacity: false)

mutable.insert("The Phantom Menace", atIndex:0)
mutable
mutable[1...2] = ["Attack of the Clones", "The Revenge of the Sith", "A New Hope", "The Empire Strikes Back", "The Return of the Jedi", "The Force Awakens"]
mutable

mutable.sort({ (a, b) -> Bool in
  return a > b
})

mutable



















