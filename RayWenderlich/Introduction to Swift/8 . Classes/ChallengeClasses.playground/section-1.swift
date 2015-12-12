class Animal {
  let name: String
  
  init(name: String) {
    self.name = name
  }
  
  func speak() {
  }
}

class Dog : Animal {
  init() {
    super.init(name: "Dog")
  }
  
  override func speak() {
    println("Woof!")
  }
}

class Cat : Animal {
  init() {
    super.init(name: "Cat")
  }
  
  override func speak() {
    println("Meow!")
  }
}

class Fox : Animal {
  init() {
    super.init(name: "Fox")
  }
  
  override func speak() {
    println("Ring-ding-ding-ding-dingeringeding!")
  }
}

let animals = [Dog(), Cat(), Fox()]
for animal in animals {
  animal.speak()
}
