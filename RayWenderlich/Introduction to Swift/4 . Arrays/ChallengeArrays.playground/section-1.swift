// Make an array with "C", "C++", and "Objective-C"
var programmingLanguages = ["C", "C++", "Objective-C"]

// Append "Swift" to the array
programmingLanguages.append("Swift")

// Insert "Javascript" at Index 2
programmingLanguages.insert("Javscript", atIndex: 2)

// Remove "Objective-C" (without hard-coding the index)
let optIndex = find(programmingLanguages, "Objective-C")
if let defIndex = optIndex {
  programmingLanguages.removeAtIndex(defIndex)
}

programmingLanguages

