# DSA Visualization Project
<!-- https://www.youtube.com/watch?v=rbu7Zu5X1zI&t=26s -->
A comprehensive project for learning Data Structures and Algorithms through interactive visualizations and Swift implementations.

## 🎯 Overview

This project combines theoretical knowledge with practical implementation and visual animations to help understand fundamental data structures and algorithms. It features Swift code examples and Manim-powered visualizations.

## 📁 Project Structure

```
dsa-visualisation-manin/
├── ArrayInSwift/                  # Array data structure implementation
│   ├── ArrayDataStructure.swift   # Core array operations in Swift
│   ├── ArrayExamples.swift        # Basic array examples
│   ├── ArrayExamplesFixed.swift   # Enhanced array examples
│   ├── ArrayVisualization.py      # Manim visualizations
│   ├── SimpleArrayDemo.py         # Simple array demonstrations
│   ├── ComprehensiveArrayDemo.py  # Advanced array operations
│   ├── README.md                  # Array-specific documentation
│   └── project_summary.md         # Project summary
├── media/                         # Generated visualization outputs
│   ├── images/                    # Static visualization images
│   └── videos/                    # Animation videos
├── manim_env/                     # Python virtual environment
├── install_manim.sh              # Manim installation script
└── .gitignore                    # Git ignore file
```

## 🚀 Features

### Data Structures Covered
- **Arrays**: Complete implementation with operations, search, and sorting algorithms
- Visual demonstrations of array operations
- Performance analysis and complexity explanations

### Visualization Types
- **Static Visualizations**: Step-by-step breakdowns
- **Animated Sequences**: Real-time algorithm execution
- **Interactive Demonstrations**: Array operations with visual feedback

## 🛠 Getting Started

### Prerequisites

1. **Swift Development**
   - Xcode (for macOS)
   - Swift compiler

2. **Python Environment**
   - Python 3.7+
   - Manim animation library
   - Virtual environment (recommended)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd dsa-visualisation-manin
   ```

2. **Set up Python environment**
   ```bash
   # Run the installation script
   chmod +x install_manim.sh
   ./install_manim.sh
   
   # Or manually activate the environment
   source manim_env/bin/activate
   ```

3. **Test the installation**
   ```bash
   # Test Swift code
   cd ArrayInSwift
   swift ArrayDataStructure.swift
   
   # Test Manim visualizations
   manim ArrayVisualization.py ArrayVisualization -pql
   ```

## 📚 What You'll Learn

### Array Data Structure
- **Fundamentals**: Declaration, initialization, and basic operations
- **Swift APIs**: Native array methods and functional programming
- **Algorithms**: Linear search, binary search, sorting algorithms
- **Performance**: Time and space complexity analysis

### Visualization Skills
- **Manim Basics**: Creating mathematical animations
- **Algorithm Animation**: Visualizing step-by-step execution
- **Educational Content**: Creating clear, informative presentations

## 🎬 Running Visualizations

### Array Visualizations

```bash
# Activate the environment
source manim_env/bin/activate

# Basic array visualization
manim ArrayInSwift/ArrayVisualization.py ArrayVisualization -pql

# Simple array demo
manim ArrayInSwift/SimpleArrayDemo.py SimpleArrayDemo -pql

# Comprehensive array operations
manim ArrayInSwift/ComprehensiveArrayDemo.py ComprehensiveArrayDemo -pql
```

### Quality Options
- `-pql`: Preview with low quality (fastest)
- `-pqm`: Preview with medium quality
- `-pqh`: Preview with high quality
- `-s`: Save video without preview

## 📖 Educational Content

### Learning Path
1. **Start with Swift basics** in `ArrayInSwift/ArrayDataStructure.swift`
2. **Watch visualizations** to understand operations visually
3. **Experiment with code** by modifying examples
4. **Create your own visualizations** using the provided templates

### Key Concepts
- **Time Complexity**: Understanding Big O notation through examples
- **Space Complexity**: Memory usage patterns
- **Algorithm Design**: Problem-solving approaches
- **Performance Optimization**: Best practices and trade-offs

## 🔍 Code Examples

### Swift Array Operations
```swift
var numbers = [3, 7, 1, 9, 4]
numbers.append(6)           // Add element
numbers.insert(0, at: 2)    // Insert at index
let sorted = numbers.sorted() // Sort array
let doubled = numbers.map { $0 * 2 } // Functional programming
```

### Manim Visualization
```python
# Create array visualization
array_viz = self.create_array_visualization([3, 7, 1, 9, 4])
self.play(Create(array_viz))
self.wait(1)
```

## 📊 Performance Analysis

The project includes real-world performance measurements showing:
- Operation timing comparisons
- Memory usage patterns
- Scalability analysis
- Best vs worst case scenarios

## 🤝 Contributing

Ways to contribute:
- **Add new data structures** (Linked Lists, Trees, Graphs)
- **Implement more algorithms** (Advanced sorting, graph algorithms)
- **Enhance visualizations** (Better animations, interactive elements)
- **Improve documentation** (More examples, clearer explanations)

## 🎓 Educational Use

Perfect for:
- **Computer Science students** learning data structures
- **iOS developers** understanding Swift collections
- **Algorithm enthusiasts** exploring visual learning
- **Educators** teaching programming concepts

## 📄 License

This project is created for educational purposes. Feel free to use, modify, and share for learning and teaching.

## 🔗 Resources

- [Swift Documentation](https://docs.swift.org)
- [Manim Documentation](https://docs.manim.community)
- [Data Structures Fundamentals](https://en.wikipedia.org/wiki/Data_structure)

---

**Happy Learning!** 🚀