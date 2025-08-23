# Array Data Structure in Swift

This project provides a comprehensive explanation and visualization of array data structures using Swift programming language and Swift APIs, along with Manim visualizations.

## 🎯 Project Overview

Arrays are one of the most fundamental data structures in computer science. This project demonstrates:
- Array basics and operations in Swift
- Search algorithms (Linear and Binary Search)
- Sorting algorithms (Bubble, Selection, Insertion Sort)
- Performance analysis and time complexity
- Visual animations using Manim

## 📁 Project Structure

```
dsa-visualisation-manin/
├── ArrayDataStructure.swift    # Main Swift implementation
├── ArrayVisualization.py       # Manim visualization scripts
├── README.md                   # This documentation
└── examples/                   # Additional examples
```

## 🚀 Getting Started

### Prerequisites

1. **Swift**: Install Xcode or Swift compiler
2. **Python 3.7+**: For Manim visualizations
3. **Manim**: Animation engine for visualizations

### Running the Swift Code

```bash
# Run the Swift array exploration
swift ArrayDataStructure.swift
```

### Running the Visualizations

```bash
# Activate manim environment
source manim_env/bin/activate

# Run array visualization
manim ArrayVisualization.py ArrayVisualization -p -ql

# Run bubble sort visualization
manim ArrayVisualization.py BubbleSortVisualization -p -ql
```

## 📚 What You'll Learn

### 1. Array Basics
- Array declaration and initialization
- Accessing and modifying elements
- Array properties (count, isEmpty)
- Safe access methods (first, last)

### 2. Swift Array APIs
- **Functional operations**: `map()`, `filter()`, `reduce()`
- **Search operations**: `contains()`, `first(where:)`
- **Sorting**: `sorted()`, `sort()`
- **Manipulation**: `append()`, `insert()`, `remove()`

### 3. Search Algorithms
- **Linear Search**: O(n) time complexity
- **Binary Search**: O(log n) time complexity for sorted arrays

### 4. Sorting Algorithms
- **Bubble Sort**: O(n²) comparison-based sorting
- **Selection Sort**: O(n²) with minimum swaps
- **Insertion Sort**: O(n²) adaptive sorting

### 5. Advanced Operations
- Array concatenation and slicing
- Array chunking and rotation
- Finding unique elements
- Performance timing analysis

## 🎬 Visualizations

The Manim animations demonstrate:

1. **Array Structure Visualization**
   - Visual representation of array elements
   - Index highlighting
   - Element access patterns

2. **Operation Animations**
   - Insertion and deletion operations
   - Search algorithm step-by-step execution
   - Sorting algorithm comparisons and swaps

3. **Sorting Visualization**
   - Bar chart representation
   - Real-time sorting progress
   - Color-coded comparisons and swaps

## 🔍 Key Concepts Covered

### Time Complexity Analysis
- **Access by index**: O(1)
- **Linear search**: O(n)
- **Binary search**: O(log n)
- **Insertion/Deletion at end**: O(1)
- **Insertion/Deletion at beginning**: O(n)

### Space Complexity
- **Array storage**: O(n)
- **Additional space**: Varies by algorithm

### Swift-Specific Features
- Array type safety and generics
- Value semantics and copy-on-write optimization
- Protocol conformance (Collection, Sequence)
- Functional programming capabilities

## 🛠 Code Examples

### Basic Array Operations
```swift
var numbers: [Int] = []
numbers.append(5)
numbers.insert(3, at: 0)
let first = numbers.first ?? 0
```

### Functional Operations
```swift
let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }
let evens = numbers.filter { $0 % 2 == 0 }
let sum = numbers.reduce(0, +)
```

### Search Implementation
```swift
func binarySearch<T: Comparable>(array: [T], target: T) -> Int? {
    var left = 0, right = array.count - 1
    while left <= right {
        let mid = (left + right) / 2
        if array[mid] == target { return mid }
        else if array[mid] < target { left = mid + 1 }
        else { right = mid - 1 }
    }
    return nil
}
```

## 📈 Performance Insights

The project includes real-world performance measurements and demonstrates:
- How array size affects operation timing
- Difference between theoretical and actual performance
- Memory usage patterns
- Best practices for array operations in Swift

## 🎓 Educational Value

This project is perfect for:
- Computer Science students learning data structures
- Swift developers wanting to understand native array operations
- Anyone interested in algorithm visualization
- Interview preparation for technical roles

## 🤝 Contributing

Feel free to enhance this project by:
- Adding more sorting algorithms
- Implementing additional search techniques
- Creating more detailed visualizations
- Adding performance benchmarks

## 📄 License

This project is created for educational purposes. Feel free to use and modify for learning and teaching.