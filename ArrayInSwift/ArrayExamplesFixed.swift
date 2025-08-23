import Foundation

// MARK: - Simple Array Examples

func basicOperations() {
    print("📚 Basic Array Operations")
    print("========================\n")
    
    var fruits = ["apple", "banana", "cherry"]
    print("Initial array: \(fruits)")
    
    // Adding elements
    fruits.append("date")
    fruits.insert("elderberry", at: 2)
    print("After additions: \(fruits)")
    
    // Accessing elements
    print("First fruit: \(fruits.first ?? "None")")
    print("Last fruit: \(fruits.last ?? "None")")
    print("Fruit at index 2: \(fruits[2])")
    
    // Removing elements
    let removed = fruits.removeFirst()
    print("Removed: \(removed), Remaining: \(fruits)")
    
    // Array properties
    print("Count: \(fruits.count)")
    print("Is empty: \(fruits.isEmpty)")
    print("Capacity: \(fruits.capacity)\n")
}

func functionalProgramming() {
    print("🔧 Functional Programming with Arrays")
    print("====================================\n")
    
    let numbers = Array(1...10)
    print("Original numbers: \(numbers)")
    
    // Map: Transform each element
    let squares = numbers.map { $0 * $0 }
    print("Squares: \(squares)")
    
    // Filter: Select elements matching condition
    let evens = numbers.filter { $0 % 2 == 0 }
    print("Even numbers: \(evens)")
    
    // Reduce: Combine all elements into single value
    let sum = numbers.reduce(0, +)
    let product = numbers.reduce(1, *)
    print("Sum: \(sum), Product: \(product)")
    
    // Chaining operations
    let evenSquaresSum = numbers
        .filter { $0 % 2 == 0 }
        .map { $0 * $0 }
        .reduce(0, +)
    print("Sum of squares of even numbers: \(evenSquaresSum)")
    
    // CompactMap: Transform and remove nils
    let strings = ["1", "2", "three", "4", "five"]
    let validNumbers = strings.compactMap { Int($0) }
    print("Valid numbers from strings: \(validNumbers)\n")
}

func searchComparison() {
    print("🔍 Search Algorithms Comparison")
    print("===============================\n")
    
    let largeArray = Array(1...100000)
    let target = 99999
    
    print("Searching for \(target) in array of 100,000 elements...")
    
    // Linear search timing
    var startTime = CFAbsoluteTimeGetCurrent()
    let linearResult = linearSearch(array: largeArray, target: target)
    var timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Linear search result: index \(linearResult), Time: \(String(format: "%.4f", timeElapsed * 1000)) ms")
    
    // Binary search timing (array is already sorted)
    startTime = CFAbsoluteTimeGetCurrent()
    let binaryResult = binarySearch(array: largeArray, target: target)
    timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Binary search result: index \(binaryResult), Time: \(String(format: "%.4f", timeElapsed * 1000)) ms")
    
    // Using Swift's built-in methods
    startTime = CFAbsoluteTimeGetCurrent()
    let firstIndex = largeArray.firstIndex(of: target)
    timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Swift firstIndex result: \(firstIndex?.description ?? "nil"), Time: \(String(format: "%.4f", timeElapsed * 1000)) ms")
    
    print("💡 Binary search is significantly faster for large sorted arrays!\n")
}

func linearSearch(array: [Int], target: Int) -> Int {
    for (index, element) in array.enumerated() {
        if element == target {
            return index
        }
    }
    return -1
}

func binarySearch(array: [Int], target: Int) -> Int {
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        let mid = (left + right) / 2
        let midValue = array[mid]
        
        if midValue == target {
            return mid
        } else if midValue < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return -1
}

func sortingDemo() {
    print("📊 Sorting Algorithms Demo")
    print("==========================\n")
    
    let originalArray = [64, 34, 25, 12, 22, 11, 90, 88, 76, 50, 42]
    print("Original array: \(originalArray)")
    
    // Swift's built-in sorting
    var swiftSorted = originalArray
    let startTime = CFAbsoluteTimeGetCurrent()
    swiftSorted.sort()
    let swiftTime = CFAbsoluteTimeGetCurrent() - startTime
    print("Swift sort result: \(swiftSorted)")
    print("Swift sort time: \(String(format: "%.4f", swiftTime * 1000)) ms")
    
    // Custom sorting algorithms
    print("\nCustom sorting algorithms:")
    
    // Bubble sort
    var bubbleArray = originalArray
    let bubbleStart = CFAbsoluteTimeGetCurrent()
    bubbleSort(&bubbleArray)
    let bubbleTime = CFAbsoluteTimeGetCurrent() - bubbleStart
    print("Bubble sort: \(bubbleArray)")
    print("Bubble sort time: \(String(format: "%.4f", bubbleTime * 1000)) ms")
    
    // Quick sort
    var quickArray = originalArray
    let quickStart = CFAbsoluteTimeGetCurrent()
    quickArray = quickSort(quickArray)
    let quickTime = CFAbsoluteTimeGetCurrent() - quickStart
    print("Quick sort: \(quickArray)")
    print("Quick sort time: \(String(format: "%.4f", quickTime * 1000)) ms\n")
}

func bubbleSort(_ array: inout [Int]) {
    let n = array.count
    for i in 0..<n {
        var swapped = false
        for j in 0..<(n - i - 1) {
            if array[j] > array[j + 1] {
                array.swapAt(j, j + 1)
                swapped = true
            }
        }
        if !swapped { break } // Optimization: stop if no swaps
    }
}

func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    let pivot = array[array.count / 2]
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSort(less) + equal + quickSort(greater)
}

func memoryManagement() {
    print("🧠 Array Memory Management")
    print("==========================\n")
    
    // Copy-on-write behavior
    let array1 = [1, 2, 3, 4, 5]
    var array2 = array1 // Shares memory initially
    
    print("array1: \(array1)")
    print("array2: \(array2)")
    print("Both arrays share memory until modification")
    
    // Modifying triggers copy
    array2.append(6)
    print("After modifying array2:")
    print("array1: \(array1)")
    print("array2: \(array2)")
    print("Now they have separate memory")
    
    // Capacity management
    var capacityDemo: [Int] = []
    print("\nCapacity demonstration:")
    
    for i in 1...10 {
        capacityDemo.append(i)
        print("Count: \(capacityDemo.count), Capacity: \(capacityDemo.capacity)")
    }
    
    // Reserving capacity
    var reservedArray: [Int] = []
    reservedArray.reserveCapacity(100)
    print("Reserved capacity: \(reservedArray.capacity)\n")
}

func genericOperations() {
    print("🔧 Generic Array Operations")
    print("============================\n")
    
    // Generic function example
    func findMax<T: Comparable>(in array: [T]) -> T? {
        return array.max()
    }
    
    let numbers = [3, 7, 2, 9, 1, 8]
    let strings = ["zebra", "apple", "banana", "cherry"]
    
    print("Max number: \(findMax(in: numbers) ?? 0)")
    print("Max string: \(findMax(in: strings) ?? "")")
    
    // Generic partition function
    func partition<T>(array: [T], predicate: (T) -> Bool) -> ([T], [T]) {
        var matching: [T] = []
        var notMatching: [T] = []
        
        for element in array {
            if predicate(element) {
                matching.append(element)
            } else {
                notMatching.append(element)
            }
        }
        
        return (matching, notMatching)
    }
    
    let (evens, odds) = partition(array: numbers) { $0 % 2 == 0 }
    print("Even numbers: \(evens)")
    print("Odd numbers: \(odds)")
    
    // Working with different types
    struct Person {
        let name: String
        let age: Int
    }
    
    let people = [
        Person(name: "Alice", age: 30),
        Person(name: "Bob", age: 25),
        Person(name: "Charlie", age: 35)
    ]
    
    let adults = people.filter { $0.age >= 30 }
    let names = people.map { $0.name }
    
    print("Adults: \(adults.map { $0.name })")
    print("All names: \(names)\n")
}

// MARK: - Main Execution

print("🎯 Swift Array Examples Explorer")
print("================================\n")

basicOperations()
functionalProgramming()
searchComparison()
sortingDemo()
memoryManagement()
genericOperations()

print("✅ All array examples completed!")