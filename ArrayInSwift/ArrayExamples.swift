import Foundation

// MARK: - Interactive Array Examples

struct ArrayExample {
    let title: String
    let description: String
    let code: () -> Void
}

class InteractiveArrayExplorer {
    
    private let examples: [ArrayExample]
    
    init() {
        self.examples = [
            ArrayExample(
                title: "Basic Array Operations",
                description: "Demonstrate fundamental array operations in Swift"
            ) { self.basicOperations() },
            
            ArrayExample(
                title: "Functional Programming with Arrays",
                description: "Using map, filter, reduce with Swift arrays"
            ) { self.functionalProgramming() },
            
            ArrayExample(
                title: "Search Algorithms Comparison",
                description: "Compare linear and binary search performance"
            ) { self.searchComparison() },
            
            ArrayExample(
                title: "Sorting Algorithms Demo",
                description: "Demonstrate different sorting algorithms"
            ) { self.sortingDemo() },
            
            ArrayExample(
                title: "Array Memory Management",
                description: "Understanding Swift array memory behavior"
            ) { self.memoryManagement() },
            
            ArrayExample(
                title: "Generic Array Operations",
                description: "Working with generic array functions"
            ) { self.genericOperations() }
        ]
    }
    
    func runAllExamples() {
        print("🎯 Interactive Array Explorer")
        print("=============================\n")
        
        for (index, example) in examples.enumerated() {
            print("📚 Example \(index + 1): \(example.title)")
            print("Description: \(example.description)")
            print("---")
            example.code()
            print("\n" + String(repeating: "=", count: 50) + "\n")
        }
    }
    
    // MARK: - Example Implementations
    
    private func basicOperations() {
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
        print("Capacity: \(fruits.capacity)")
    }
    
    private func functionalProgramming() {
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
        print("Valid numbers from strings: \(validNumbers)")
    }
    
    private func searchComparison() {
        let smallArray = Array(1...100)
        let largeArray = Array(1...100000)
        let target = 99999
        
        print("Searching for \(target) in different sized arrays...")
        
        // Linear search timing
        var startTime = CFAbsoluteTimeGetCurrent()
        let linearResult = linearSearch(array: largeArray, target: target)
        var timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Linear search result: index \(linearResult), Time: \(timeElapsed * 1000) ms")
        
        // Binary search timing (array is already sorted)
        startTime = CFAbsoluteTimeGetCurrent()
        let binaryResult = binarySearch(array: largeArray, target: target)
        timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Binary search result: index \(binaryResult), Time: \(timeElapsed * 1000) ms")
        
        // Using Swift's built-in methods
        startTime = CFAbsoluteTimeGetCurrent()
        let firstIndex = largeArray.firstIndex(of: target)
        timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Swift firstIndex result: \(firstIndex?.description ?? "nil"), Time: \(timeElapsed * 1000) ms")
        
        // Performance comparison
        print("Binary search is significantly faster for large sorted arrays!")
    }
    
    private func linearSearch(array: [Int], target: Int) -> Int {
        for (index, element) in array.enumerated() {
            if element == target {
                return index
            }
        }
        return -1
    }
    
    private func binarySearch(array: [Int], target: Int) -> Int {
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
    
    private func sortingDemo() {
        let originalArray = [64, 34, 25, 12, 22, 11, 90, 88, 76, 50, 42]
        print("Original array: \(originalArray)")
        
        // Swift's built-in sorting
        var swiftSorted = originalArray
        let startTime = CFAbsoluteTimeGetCurrent()
        swiftSorted.sort()
        let swiftTime = CFAbsoluteTimeGetCurrent() - startTime
        print("Swift sort result: \(swiftSorted)")
        print("Swift sort time: \(swiftTime * 1000) ms")
        
        // Custom sorting algorithms
        print("\nCustom sorting algorithms:")
        
        // Bubble sort
        var bubbleArray = originalArray
        let bubbleStart = CFAbsoluteTimeGetCurrent()
        bubbleSort(&bubbleArray)
        let bubbleTime = CFAbsoluteTimeGetCurrent() - bubbleStart
        print("Bubble sort: \(bubbleArray), Time: \(bubbleTime * 1000) ms")
        
        // Quick sort
        var quickArray = originalArray
        let quickStart = CFAbsoluteTimeGetCurrent()
        quickArray = quickSort(quickArray)
        let quickTime = CFAbsoluteTimeGetCurrent() - quickStart
        print("Quick sort: \(quickArray), Time: \(quickTime * 1000) ms")
        
        // Merge sort
        var mergeArray = originalArray
        let mergeStart = CFAbsoluteTimeGetCurrent()
        mergeArray = mergeSort(mergeArray)
        let mergeTime = CFAbsoluteTimeGetCurrent() - mergeStart
        print("Merge sort: \(mergeArray), Time: \(mergeTime * 1000) ms")
    }
    
    private func bubbleSort(_ array: inout [Int]) {
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
    
    private func quickSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        
        let pivot = array[array.count / 2]
        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }
        
        return quickSort(less) + equal + quickSort(greater)
    }
    
    private func mergeSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        
        let mid = array.count / 2
        let left = mergeSort(Array(array[0..<mid]))
        let right = mergeSort(Array(array[mid..<array.count]))
        
        return merge(left, right)
    }
    
    private func merge(_ left: [Int], _ right: [Int]) -> [Int] {
        var result: [Int] = []
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] <= right[rightIndex] {
                result.append(left[leftIndex])
                leftIndex += 1
            } else {
                result.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        result.append(contentsOf: left[leftIndex...])
        result.append(contentsOf: right[rightIndex...])
        
        return result
    }
    
    private func memoryManagement() {
        print("Understanding Swift Array Memory Management")
        
        // Copy-on-write behavior
        var array1 = [1, 2, 3, 4, 5]
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
        print("Reserved capacity: \(reservedArray.capacity)")
    }
    
    private func genericOperations() {
        print("Generic Array Operations")
        
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
        print("All names: \(names)")
    }
}

// MARK: - Main Execution

let explorer = InteractiveArrayExplorer()
explorer.runAllExamples()