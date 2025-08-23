import Foundation

// MARK: - Array Data Structure Explanation in Swift

class ArrayDataStructureExplorer {
    
    // MARK: - Basic Array Operations
    
    func demonstrateArrayBasics() {
        print("=== Array Basics in Swift ===\n")
        
        // Declaration and initialization
        var numbers: [Int] = []
        var fruits = ["apple", "banana", "cherry"]
        let fixedNumbers = [1, 2, 3, 4, 5]
        
        print("Empty array: \(numbers)")
        print("String array: \(fruits)")
        print("Fixed array: \(fixedNumbers)")
        print("Array count: \(fruits.count)")
        print("Is empty: \(numbers.isEmpty)\n")
    }
    
    // MARK: - Array Access and Modification
    
    func demonstrateArrayAccess() {
        print("=== Array Access and Modification ===\n")
        
        var colors = ["red", "green", "blue"]
        
        // Accessing elements
        print("First element: \(colors[0])")
        print("Last element: \(colors[colors.count - 1])")
        print("Safe access with first: \(colors.first ?? "No element")")
        print("Safe access with last: \(colors.last ?? "No element")")
        
        // Modifying elements
        colors[1] = "yellow"
        print("After modification: \(colors)")
        
        // Adding elements
        colors.append("purple")
        colors.insert("orange", at: 2)
        print("After additions: \(colors)")
        
        // Removing elements
        let removed = colors.remove(at: 1)
        print("Removed '\(removed)': \(colors)")
        colors.removeLast()
        print("After removing last: \(colors)\n")
    }
    
    // MARK: - Array Operations with Swift APIs
    
    func demonstrateArrayOperations() {
        print("=== Array Operations with Swift APIs ===\n")
        
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // Filter
        let evenNumbers = numbers.filter { $0 % 2 == 0 }
        print("Even numbers: \(evenNumbers)")
        
        // Map
        let squaredNumbers = numbers.map { $0 * $0 }
        print("Squared numbers: \(squaredNumbers)")
        
        // Reduce
        let sum = numbers.reduce(0, +)
        print("Sum of numbers: \(sum)")
        
        // Contains
        print("Contains 5: \(numbers.contains(5))")
        
        // First/Last where
        let firstEven = numbers.first { $0 % 2 == 0 }
        print("First even number: \(firstEven ?? -1)")
        
        // Sorting
        let unsorted = [64, 34, 25, 12, 22, 11, 90]
        let sorted = unsorted.sorted()
        print("Sorted array: \(sorted)")
        
        var mutableArray = unsorted
        mutableArray.sort()
        print("In-place sorted: \(mutableArray)\n")
    }
    
    // MARK: - Array Search Algorithms
    
    func demonstrateSearchAlgorithms() {
        print("=== Array Search Algorithms ===\n")
        
        let array = [2, 5, 8, 12, 16, 23, 38, 45, 67, 78, 89, 91]
        let target = 23
        
        // Linear Search
        let linearResult = linearSearch(array: array, target: target)
        print("Linear search for \(target): Index \(linearResult)")
        
        // Binary Search (for sorted arrays)
        let binaryResult = binarySearch(array: array, target: target)
        print("Binary search for \(target): Index \(binaryResult)\n")
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
    
    // MARK: - Array Sorting Algorithms
    
    func demonstrateSortingAlgorithms() {
        print("=== Array Sorting Algorithms ===\n")
        
        let unsortedArray = [64, 34, 25, 12, 22, 11, 90]
        print("Original array: \(unsortedArray)")
        
        // Bubble Sort
        var bubbleSorted = unsortedArray
        bubbleSort(&bubbleSorted)
        print("Bubble sort result: \(bubbleSorted)")
        
        // Selection Sort
        var selectionSorted = unsortedArray
        selectionSort(&selectionSorted)
        print("Selection sort result: \(selectionSorted)")
        
        // Insertion Sort
        var insertionSorted = unsortedArray
        insertionSort(&insertionSorted)
        print("Insertion sort result: \(insertionSorted)\n")
    }
    
    func bubbleSort(_ array: inout [Int]) {
        let n = array.count
        for i in 0..<n {
            for j in 0..<(n - i - 1) {
                if array[j] > array[j + 1] {
                    array.swapAt(j, j + 1)
                }
            }
        }
    }
    
    func selectionSort(_ array: inout [Int]) {
        let n = array.count
        for i in 0..<n {
            var minIndex = i
            for j in (i + 1)..<n {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            if minIndex != i {
                array.swapAt(i, minIndex)
            }
        }
    }
    
    func insertionSort(_ array: inout [Int]) {
        for i in 1..<array.count {
            let key = array[i]
            var j = i - 1
            
            while j >= 0 && array[j] > key {
                array[j + 1] = array[j]
                j -= 1
            }
            array[j + 1] = key
        }
    }
    
    // MARK: - Advanced Array Operations
    
    func demonstrateAdvancedOperations() {
        print("=== Advanced Array Operations ===\n")
        
        let array1 = [1, 2, 3]
        let array2 = [4, 5, 6]
        
        // Array concatenation
        let combined = array1 + array2
        print("Combined arrays: \(combined)")
        
        // Array slicing
        let slice = Array(combined[1..<4])
        print("Slice [1..<4]: \(slice)")
        
        // Chunking array into subarrays
        let chunked = combined.chunked(into: 2)
        print("Chunked into groups of 2: \(chunked)")
        
        // Unique elements
        let duplicates = [1, 2, 2, 3, 3, 3, 4, 5, 5]
        let unique = Array(Set(duplicates)).sorted()
        print("Unique elements: \(unique)")
        
        // Array rotation
        var rotateArray = [1, 2, 3, 4, 5]
        rotateLeft(&rotateArray, by: 2)
        print("Array rotated left by 2: \(rotateArray)\n")
    }
    
    func rotateLeft(_ array: inout [Int], by positions: Int) {
        let n = array.count
        let k = positions % n
        array = Array(array[k..<n] + array[0..<k])
    }
    
    // MARK: - Performance Analysis
    
    func demonstratePerformanceAnalysis() {
        print("=== Array Performance Analysis ===\n")
        
        let smallArray = Array(1...1000)
        let largeArray = Array(1...100000)
        
        // Time complexity examples
        print("Time Complexity Examples:")
        print("- Access by index: O(1)")
        print("- Linear search: O(n)")
        print("- Binary search (sorted): O(log n)")
        print("- Insertion at end: O(1) amortized")
        print("- Insertion at beginning: O(n)")
        print("- Deletion from end: O(1)")
        print("- Deletion from beginning: O(n)")
        
        // Demonstrate actual timing
        let startTime = CFAbsoluteTimeGetCurrent()
        let _ = largeArray.first { $0 == 99999 }
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        
        print("\nActual search time for element in large array: \(timeElapsed * 1000) ms")
        
        // Space complexity
        print("\nSpace Complexity:")
        print("- Array storage: O(n)")
        print("- Additional space for operations: varies by algorithm\n")
    }
}

// MARK: - Array Extension for Chunking

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

// MARK: - Main Execution

let explorer = ArrayDataStructureExplorer()

print("🚀 Swift Array Data Structure Explorer\n")
print("This program demonstrates various aspects of arrays in Swift using native APIs.\n")

explorer.demonstrateArrayBasics()
explorer.demonstrateArrayAccess()
explorer.demonstrateArrayOperations()
explorer.demonstrateSearchAlgorithms()
explorer.demonstrateSortingAlgorithms()
explorer.demonstrateAdvancedOperations()
explorer.demonstratePerformanceAnalysis()

print("✅ Array exploration completed!")