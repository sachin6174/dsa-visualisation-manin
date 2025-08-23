from manim import *

class SimpleArrayDemo(Scene):
    def construct(self):
        # Title
        title = Text("Swift Array Data Structure", font_size=40, color=BLUE)
        title.to_edge(UP)
        self.play(Write(title))
        self.wait(1)
        
        # Create a simple array visualization
        array_values = [5, 2, 8, 1, 9]
        self.show_array_basics(array_values)
        self.wait(2)
        
        # Show a simple operation
        self.show_array_operation(array_values)
        self.wait(2)

    def show_array_basics(self, values):
        # Create array boxes
        boxes = VGroup()
        numbers = VGroup()
        indices = VGroup()
        
        for i, value in enumerate(values):
            # Box
            box = Rectangle(width=1, height=0.8, color=WHITE)
            box.move_to(RIGHT * i * 1.2)
            boxes.add(box)
            
            # Number
            number = Text(str(value), font_size=28, color=YELLOW)
            number.move_to(box.get_center())
            numbers.add(number)
            
            # Index
            index = Text(str(i), font_size=20, color=GRAY)
            index.move_to(box.get_center() + DOWN * 0.6)
            indices.add(index)
        
        array_group = VGroup(boxes, numbers, indices)
        
        # Labels
        array_label = Text("Array elements:", font_size=24, color=WHITE)
        array_label.next_to(array_group, UP, buff=0.5)
        
        index_label = Text("Indices:", font_size=20, color=GRAY)
        index_label.next_to(array_group, DOWN, buff=0.3)
        
        # Animate
        self.play(Write(array_label))
        self.play(Create(boxes), run_time=2)
        self.play(Write(numbers), run_time=2)
        self.play(Write(indices), Write(index_label), run_time=1)
        
        # Store for later use
        self.array_group = array_group

    def show_array_operation(self, values):
        # Show accessing an element
        access_text = Text("Accessing element at index 2:", font_size=24, color=GREEN)
        access_text.to_edge(DOWN, buff=2)
        
        self.play(Write(access_text))
        
        # Highlight the element at index 2
        target_box = self.array_group[0][2]  # boxes[2]
        target_number = self.array_group[1][2]  # numbers[2]
        
        highlight = target_box.copy()
        highlight.set_stroke(color=RED, width=4)
        
        self.play(
            Create(highlight),
            target_number.animate.set_color(RED),
            run_time=1
        )
        
        # Show the result
        result_text = Text(f"array[2] = {values[2]}", font_size=28, color=RED)
        result_text.next_to(access_text, DOWN, buff=0.5)
        
        self.play(Write(result_text))
        self.wait(2)
        
        # Clean up
        self.play(
            FadeOut(highlight),
            FadeOut(access_text),
            FadeOut(result_text),
            target_number.animate.set_color(YELLOW)
        )

class ArraySortDemo(Scene):
    def construct(self):
        title = Text("Bubble Sort Visualization", font_size=36, color=BLUE)
        title.to_edge(UP)
        self.play(Write(title))
        self.wait(1)
        
        # Array to sort
        values = [4, 2, 7, 1, 3]
        self.visualize_bubble_sort(values)

    def visualize_bubble_sort(self, values):
        # Create bars
        bars = VGroup()
        labels = VGroup()
        
        max_val = max(values)
        
        for i, value in enumerate(values):
            # Normalize height
            height = (value / max_val) * 2 + 0.5
            
            # Create bar
            bar = Rectangle(width=0.8, height=height, color=BLUE, fill_opacity=0.7)
            bar.move_to(LEFT * 3 + RIGHT * i * 1.2 + UP * height/2)
            bars.add(bar)
            
            # Label
            label = Text(str(value), font_size=20, color=WHITE)
            label.move_to(bar.get_bottom() + DOWN * 0.3)
            labels.add(label)
        
        chart = VGroup(bars, labels)
        self.play(Create(chart))
        self.wait(1)
        
        # Simple bubble sort
        n = len(values)
        for i in range(n):
            for j in range(0, n - i - 1):
                # Highlight comparison
                self.play(
                    bars[j].animate.set_color(RED),
                    bars[j + 1].animate.set_color(RED),
                    run_time=0.5
                )
                
                if values[j] > values[j + 1]:
                    # Swap
                    values[j], values[j + 1] = values[j + 1], values[j]
                    
                    # Animate swap
                    self.play(
                        bars[j].animate.move_to(bars[j + 1].get_center()),
                        bars[j + 1].animate.move_to(bars[j].get_center()),
                        labels[j].animate.move_to(labels[j + 1].get_center()),
                        labels[j + 1].animate.move_to(labels[j].get_center()),
                        run_time=0.8
                    )
                    
                    # Update references
                    bars[j], bars[j + 1] = bars[j + 1], bars[j]
                    labels[j], labels[j + 1] = labels[j + 1], labels[j]
                
                # Reset colors
                self.play(
                    bars[j].animate.set_color(BLUE),
                    bars[j + 1].animate.set_color(BLUE),
                    run_time=0.3
                )
            
            # Mark sorted
            self.play(bars[n - 1 - i].animate.set_color(GREEN), run_time=0.5)
        
        # Final message
        completion = Text("Sorting Complete!", font_size=28, color=GREEN)
        completion.to_edge(DOWN)
        self.play(Write(completion))
        self.wait(2)