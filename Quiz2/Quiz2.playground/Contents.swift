import UIKit



/*
 1. Write a swift programming code to perform following tasks
 a) Declare an optional variable that stores the age of a person
 b) Declare a constant that stores the earth gravity 9.8

 */

//Declare an optional variable that stores the age of a person
print("\n")
print("------------Question 1------------")
var age:Int? = 22
print(age)
//Declare a constant that stores the earth gravity 9.8
let gravity = 9.8
print(gravity)



/*
 2.
 Write switch-case statement that displays the following information if the RFM (relative fat mass) is the input
 */

let RFM:Int = 25

print("\n")
print("------------Question 2------------")
switch (RFM) {
case 0...20:
    print("You are underfat")
    
case 21...35:
    print("You are healthy")
    
case 36...42:
    print("You are overfat")
    
case 43...:
    print("You are obese")
default:
    print("Default Met")
}


/*
 3.
 a) Write a “for loop” that displays a string in the reverse order (DO NOT use the reverse method)
 b) Now write a swift code segment that reverses each word in a String DO NOT use the reverse method)
 */

// Write a “for loop” that displays a string in the reverse order (DO NOT use the reverse method)
func reverseString(str:String) -> String{
    var rString = ""
    var charArray = [Character]()
    let sChars = Array(str)
    
    for i in stride(from: sChars.endIndex - 1, through: 0, by: -1){
        charArray.append(sChars[i])
    }
    rString = String(charArray)
    
    
    return rString
}

print("\n")
print("------------Question 3------------")
print("Reverse Word: " + reverseString(str: "Hello"))


// Now write a swift code segment that reverses each word in a String DO NOT use the reverse method)
func reverseEachWord(str:String) -> String {
    var rString = ""
    let separated = str.components(separatedBy: " ")
    for word in separated{
        rString += reverseString(str: word) + " "
    }
    
    return rString
}

print("Reverse Each Word: " + reverseEachWord(str: "hello world welcome to today"))


/*
 4. Methods
 i.) Write a method that take an integer array as a parameter and returns the sum
 of positive odd numbers and sum of positive even numbers.
 
 ii.) Define and implement a method that takes a string array as a parameter and returns the length of the shortest and the longest strings in the array
 
 iii.) Implements the sequential search method that takes and array of integers and the item to be search as parameters and returns true if the item to be searched in the array, return false otherwise
 */


// Write a method that take an integer array as a parameter and returns the sum of positive odd numbers and sum of positive even numbers.
print("\n")
print("------------Question 4------------")

func sumEvenOddInts(numbers:[Int]) -> (even:Int, odd:Int){
    var sumEven:Int = 0
    var sumOdd:Int = 0
    
    for num in numbers{
        if num % 2 == 0 {
            sumEven += num
        }
        else{
            sumOdd += num
        }
    }
    
    
    return (sumEven, sumOdd)
}

var ints = [1,2,3,4,5,6,7,8,9,10]

print(sumEvenOddInts(numbers: ints))


// Define and implement a method that takes a string array as a parameter and returns the length of the shortest and the longest strings in the array

func longestStr(strings:[String]) -> (string:String, size:Int) {
    var longest:Int = 0
    var longestW:String = ""
    
    for str in strings{
        if str.count > longest{
            longest = str.count
            longestW = str
        }
    }
    
    return (longestW,longest)
}

var strings = ["Hello", "World", "Swift5", "Apple", "Microsoft", "Google", "Amazon"]

print(longestStr(strings: strings))


//Implements the sequential search method that takes and array of integers and the item to be search as parameters and returns true if the item to be searched in the array, return false otherwise

func sequentialSearch(numbers:[Int], search:Int) -> Bool{
    for num in numbers{
        if num == search{
            return true
        }
    }
    
    return false
}

var ints2 = [1,2,3,4,5,6,7,8,9,10]



//True outcome
print("\nShould return TRUE; Returns: ")
print(sequentialSearch(numbers: ints2, search: 5))
//False Outcome
print("\nShould return FALSE; Returns: ")
print(sequentialSearch(numbers: ints2, search: 13))

/*
 5. Objects:
 Develop an object called cityStatistics. The cityStatistics objects should have following data
 members
 */

class cityStatistics {
    private var cityName:String?
    private var population:Int?
    private var latitude:Double?
    private var longitude:Double?
    
    init(name:String, pop:Int, lat:Double, lon:Double){
        cityName = name
        population = pop
        latitude = lat
        longitude = lon
    }
    
    public func getName() -> String{
        return self.cityName!
    }
    public func getPopulation() -> Int{
        return self.population!
    }
    
    public func getLatitude() -> Double{
        return self.latitude!
    }
}

var city:cityStatistics = cityStatistics(name: "Phoenix", pop: 1680992, lat: 33.4484, lon: 112.0740)

print("\n")
print("------------Question 5------------")
print("\(city.getName()) Population: \(city.getPopulation())")
print("\(city.getName()) Latitude: \(city.getLatitude())")


var cities = [String:cityStatistics]()

cities["Paris"] = cityStatistics(name: "Paris", pop: 2175601, lat: 48.8566, lon: 2.3522)
cities["London"] = cityStatistics(name: "London", pop: 8961989, lat: 51.3026, lon:0.739)
cities["Sydney"] = cityStatistics(name: "Sydney", pop: 5312163, lat: 33.5154, lon: 151.1234)
cities["Phoenix"] = cityStatistics(name: "Phoenix", pop: 1680992, lat: 33.4484, lon: 112.0740)
cities["Wellington"] = cityStatistics(name: "Wellington", pop: 212700, lat: 41.1720, lon: 174.4638)

var largestCityName:String = ""
var largestCitypop:Int = 0

for cityName in cities {
    if cityName.value.getPopulation() > largestCitypop {
        largestCityName = cityName.value.getName()
        largestCitypop = cityName.value.getPopulation()
    }
}

print("\n")
print("------------Question 6------------")
print("Largest City: \(largestCityName) \nPopulation: \(largestCitypop)")

var students:[[String:Any]] = [[ "firstName": "John", "lastName": "Wilson", "gpa": 2.4 ], [ "firstName": "Nancy", "lastName": "Smith", "gpa": 3.5 ], [ "firstName": "Michael", "lastName": "Liu", "gpa": 3.1 ]]

print(students[0]["gpa"] as! Double)

var highestGPA:Double = 0.0
var studentFirst:String = ""
var studentLast:String = ""

for i in stride(from: 0, to: students.count, by: 1) {
    if(students[i]["gpa"] as! Double > highestGPA){
        highestGPA = students[i]["gpa"] as! Double
        studentFirst = students[i]["firstName"] as! String
        studentLast = students[i]["lastName"] as! String
    }
}
print("\n")
print("------------Question 7------------")
print("Student with Highest GPA\nName: \(studentFirst) \(studentLast) \nGPA: \(highestGPA)")






