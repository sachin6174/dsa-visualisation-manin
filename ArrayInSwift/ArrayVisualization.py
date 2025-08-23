from manim import *
import numpy as np

class ArrayVisualization(Scene):
    def construct(self):
        # Title
        title = Text("Array Data Structure Visualization", font_size=36, color=BLUE)
        title.to_edge(UP)
        self.play(Write(title))
        self.wait(1)
        
        # Initial array setup
        array_values = [3, 7, 1, 9, 4, 6, 2, 8]
        self.visualize_array_basics(array_values)
        self.wait(2)
        
        self.clear()
        self.play(Write(title))
        
        # Array operations
        self.visualize_array_operations(array_values.copy())
        self.wait(2)

    def create_array_visualization(self, values, position=ORIGIN):
        """Create visual representation of an array"""
        boxes = VGroup()
        numbers = VGroup()
        indices = VGroup()
        
        box_width = 0.8
        box_height = 0.6
        
        for i, value in enumerate(values):
            # Create box
            box = Rectangle(width=box_width, height=box_height, color=WHITE)
            box.move_to(position + RIGHT * i * box_width)
            boxes.add(box)
            
            # Add number
            number = Text(str(value), font_size=24, color=YELLOW)
            number.move_to(box.get_center())
            numbers.add(number)
            
            # Add index
            index = Text(str(i), font_size=18, color=GRAY)
            index.move_to(box.get_center() + DOWN * 0.5)
            indices.add(index)
        
        return VGroup(boxes, numbers, indices)

    def visualize_array_basics(self, values):
        """Visualize basic array concepts"""
        # Create array visualization
        array_viz = self.create_array_visualization(values, UP * 1)
        
        # Add labels
        array_label = Text("Array: [3, 7, 1, 9, 4, 6, 2, 8]", font_size=24, color=WHITE)
        array_label.next_to(array_viz, UP, buff=0.5)
        
        indices_label = Text("Indices:", font_size=20, color=GRAY)
        indices_label.next_to(array_viz, DOWN, buff=0.3)
        
        # Animate array creation
        self.play(
            FadeIn(array_label),
            Create(array_viz[0]),  # boxes
            Write(array_viz[1]),   # numbers
            Write(array_viz[2]),   # indices
            Write(indices_label)
        )
        self.wait(1)
        
        # Highlight specific elements
        self.highlight_element(array_viz, 0, "First element (index 0)")
        self.wait(1)
        self.highlight_element(array_viz, len(values)-1, "Last element (index {})".format(len(values)-1))
        self.wait(1)
        
        # Show array properties
        properties = VGroup(
            Text("Properties:", font_size=24, color=BLUE),
            Text(f"• Length: {len(values)}", font_size=20, color=WHITE),
            Text("• Zero-indexed", font_size=20, color=WHITE),
            Text("• Contiguous memory", font_size=20, color=WHITE),
            Text("• Random access O(1)", font_size=20, color=WHITE)
        )
        properties.arrange(DOWN, aligned_edge=LEFT, buff=0.2)
        properties.to_edge(RIGHT, buff=1)
        
        self.play(Write(properties))
        self.wait(2)

    def highlight_element(self, array_viz, index, description):
        """Highlight a specific array element"""
        # Get the box and number at the specified index
        box = array_viz[0][index]
        number = array_viz[1][index]
        
        # Create highlight
        highlight = box.copy()
        highlight.set_stroke(color=RED, width=4)
        
        # Create description
        desc = Text(description, font_size=18, color=RED)
        desc.next_to(array_viz, DOWN, buff=1)
        
        # Animate highlight
        self.play(
            Create(highlight),
            Write(desc),
            number.animate.set_color(RED)
        )
        self.wait(1)
        
        # Remove highlight
        self.play(
            FadeOut(highlight),
            FadeOut(desc),
            number.animate.set_color(YELLOW)
        )

    def visualize_array_operations(self, values):
        """Visualize common array operations"""
        # Create initial array
        array_viz = self.create_array_visualization(values, UP * 1.5)
        operation_title = Text("Array Operations", font_size=28, color=GREEN)
        operation_title.next_to(array_viz, UP, buff=0.5)
        
        self.play(
            Write(operation_title),
            Create(array_viz[0]),
            Write(array_viz[1]),
            Write(array_viz[2])
        )
        self.wait(1)
        
        # Operation 1: Insert element
        self.demonstrate_insertion(array_viz, values, 2, 5)
        self.wait(2)
        
        # Operation 2: Delete element
        self.demonstrate_deletion(array_viz, values, 1)
        self.wait(2)
        
        # Operation 3: Search element
        self.demonstrate_search(array_viz, values, 9)
        self.wait(2)

    def demonstrate_insertion(self, array_viz, values, index, new_value):
        """Demonstrate array insertion"""
        desc = Text(f"Insert {new_value} at index {index}", font_size=20, color=ORANGE)
        desc.to_edge(DOWN, buff=1)
        self.play(Write(desc))
        
        # Highlight insertion point
        insert_point = array_viz[0][index].get_center()
        arrow = Arrow(insert_point + UP * 0.8, insert_point + UP * 0.1, color=ORANGE)
        self.play(Create(arrow))
        
        # Show shifting elements
        for i in range(index, len(values)):
            box = array_viz[0][i]
            number = array_viz[1][i]
            self.play(
                box.animate.shift(RIGHT * 0.8),
                number.animate.shift(RIGHT * 0.8),
                run_time=0.3
            )
        
        # Insert new element
        new_box = Rectangle(width=0.8, height=0.6, color=ORANGE)
        new_box.move_to(insert_point)
        new_number = Text(str(new_value), font_size=24, color=YELLOW)
        new_number.move_to(new_box.get_center())
        
        self.play(
            Create(new_box),
            Write(new_number)
        )
        
        self.play(FadeOut(arrow), FadeOut(desc))
        values.insert(index, new_value)

    def demonstrate_deletion(self, array_viz, values, index):
        """Demonstrate array deletion"""
        desc = Text(f"Delete element at index {index}", font_size=20, color=RED)
        desc.to_edge(DOWN, buff=1)
        self.play(Write(desc))
        
        # Highlight deletion point
        delete_box = array_viz[0][index]
        delete_number = array_viz[1][index]
        
        # Mark for deletion
        self.play(
            delete_box.animate.set_stroke(color=RED, width=4),
            delete_number.animate.set_color(RED)
        )
        
        # Remove element
        self.play(
            FadeOut(delete_box),
            FadeOut(delete_number)
        )
        
        # Shift remaining elements
        for i in range(index + 1, len(values)):
            box = array_viz[0][i]
            number = array_viz[1][i]
            self.play(
                box.animate.shift(LEFT * 0.8),
                number.animate.shift(LEFT * 0.8),
                run_time=0.3
            )
        
        self.play(FadeOut(desc))
        values.pop(index)

    def demonstrate_search(self, array_viz, values, target):
        """Demonstrate linear search"""
        desc = Text(f"Search for element {target}", font_size=20, color=PURPLE)
        desc.to_edge(DOWN, buff=1)
        self.play(Write(desc))
        
        # Linear search animation
        for i, value in enumerate(values):
            if i < len(array_viz[0]):  # Ensure index exists
                box = array_viz[0][i]
                number = array_viz[1][i]
                
                # Highlight current element
                self.play(
                    box.animate.set_stroke(color=PURPLE, width=3),
                    number.animate.set_color(PURPLE),
                    run_time=0.5
                )
                
                if value == target:
                    # Found target
                    found_text = Text("Found!", font_size=24, color=GREEN)
                    found_text.next_to(box, UP, buff=0.3)
                    self.play(
                        Write(found_text),
                        box.animate.set_stroke(color=GREEN, width=4),
                        number.animate.set_color(GREEN)
                    )
                    self.wait(1)
                    self.play(FadeOut(found_text))
                    break
                else:
                    # Reset color
                    self.play(
                        box.animate.set_stroke(color=WHITE, width=1),
                        number.animate.set_color(YELLOW),
                        run_time=0.2
                    )
        
        self.play(FadeOut(desc))


class BubbleSortVisualization(Scene):
    def construct(self):
        title = Text("Bubble Sort Visualization", font_size=36, color=BLUE)
        title.to_edge(UP)
        self.play(Write(title))
        
        # Array to sort
        values = [64, 34, 25, 12, 22, 11, 90]
        self.visualize_bubble_sort(values)

    def create_bar_chart(self, values, position=ORIGIN):
        """Create bar chart representation"""
        bars = VGroup()
        numbers = VGroup()
        max_val = max(values)
        
        for i, value in enumerate(values):
            # Normalize height
            height = (value / max_val) * 3
            
            # Create bar
            bar = Rectangle(width=0.6, height=height, color=BLUE, fill_opacity=0.8)
            bar.move_to(position + RIGHT * i * 0.8 + UP * height/2)
            bars.add(bar)
            
            # Add number
            number = Text(str(value), font_size=16, color=WHITE)
            number.move_to(bar.get_bottom() + DOWN * 0.2)
            numbers.add(number)
        
        return VGroup(bars, numbers)

    def visualize_bubble_sort(self, values):
        """Visualize bubble sort algorithm"""
        chart = self.create_bar_chart(values, LEFT * 3)
        self.play(Create(chart))
        self.wait(1)
        
        n = len(values)
        for i in range(n):
            for j in range(0, n - i - 1):
                # Highlight comparison
                bar1 = chart[0][j]
                bar2 = chart[0][j + 1]
                
                self.play(
                    bar1.animate.set_color(RED),
                    bar2.animate.set_color(RED),
                    run_time=0.3
                )
                
                if values[j] > values[j + 1]:
                    # Swap needed
                    values[j], values[j + 1] = values[j + 1], values[j]
                    
                    # Animate swap
                    self.play(
                        bar1.animate.move_to(bar2.get_center()),
                        bar2.animate.move_to(bar1.get_center()),
                        chart[1][j].animate.move_to(chart[1][j + 1].get_center()),
                        chart[1][j + 1].animate.move_to(chart[1][j].get_center()),
                        run_time=0.5
                    )
                    
                    # Update references
                    chart[0][j], chart[0][j + 1] = chart[0][j + 1], chart[0][j]
                    chart[1][j], chart[1][j + 1] = chart[1][j + 1], chart[1][j]
                
                # Reset colors
                self.play(
                    bar1.animate.set_color(BLUE),
                    bar2.animate.set_color(BLUE),
                    run_time=0.2
                )
            
            # Mark sorted element
            sorted_bar = chart[0][n - 1 - i]
            self.play(sorted_bar.animate.set_color(GREEN), run_time=0.3)
        
        # Final highlight
        completion_text = Text("Sorting Complete!", font_size=24, color=GREEN)
        completion_text.to_edge(DOWN)
        self.play(Write(completion_text))
        self.wait(2)