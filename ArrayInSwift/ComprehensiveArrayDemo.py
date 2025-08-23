from manim import *

class ComprehensiveArrayDemo(Scene):
    def construct(self):
        # Main title
        main_title = Text("Swift Array Data Structure", font_size=48, color=BLUE)
        subtitle = Text("Complete Visualization Guide", font_size=24, color=WHITE)
        subtitle.next_to(main_title, DOWN, buff=0.3)
        
        title_group = VGroup(main_title, subtitle)
        title_group.to_edge(UP, buff=1)
        
        self.play(Write(main_title), run_time=2)
        self.play(Write(subtitle), run_time=1)
        self.wait(1)
        
        # Show all sections
        self.show_array_structure()
        self.wait(1)
        
        self.clear()
        self.play(Write(main_title))
        
        self.show_array_operations()
        self.wait(1)
        
        self.clear()
        self.play(Write(main_title))
        
        self.show_search_demonstration()
        self.wait(2)

    def show_array_structure(self):
        section_title = Text("1. Array Structure & Access", font_size=36, color=GREEN)
        section_title.to_edge(UP, buff=2)
        self.play(Write(section_title))
        
        # Create array
        array_values = [10, 25, 30, 47, 52, 68, 75]
        boxes, numbers, indices = self.create_array_visual(array_values)
        
        array_group = VGroup(boxes, numbers, indices)
        array_group.move_to(ORIGIN)
        
        # Labels
        elements_label = Text("Array Elements:", font_size=24, color=WHITE)
        elements_label.next_to(array_group, UP, buff=0.5)
        
        indices_label = Text("Indices (0-based):", font_size=20, color=GRAY)
        indices_label.next_to(array_group, DOWN, buff=0.5)
        
        # Animate creation
        self.play(Write(elements_label))
        self.play(Create(boxes), run_time=2)
        self.play(Write(numbers), run_time=2)
        self.play(Write(indices), Write(indices_label))
        
        # Demonstrate access patterns
        self.demonstrate_access_patterns(boxes, numbers, array_values)
        
        # Properties
        properties = self.create_properties_display(array_values)
        self.play(Write(properties))
        self.wait(2)

    def create_array_visual(self, values):
        boxes = VGroup()
        numbers = VGroup()
        indices = VGroup()
        
        box_width = 1.0
        box_height = 0.8
        
        for i, value in enumerate(values):
            # Create box
            box = Rectangle(width=box_width, height=box_height, color=WHITE, stroke_width=2)
            box.move_to(LEFT * 3 + RIGHT * i * box_width)
            boxes.add(box)
            
            # Add number
            number = Text(str(value), font_size=24, color=YELLOW)
            number.move_to(box.get_center())
            numbers.add(number)
            
            # Add index
            index = Text(str(i), font_size=18, color=GRAY)
            index.move_to(box.get_center() + DOWN * 0.6)
            indices.add(index)
        
        return boxes, numbers, indices

    def demonstrate_access_patterns(self, boxes, numbers, values):
        # Access first element
        self.highlight_access(boxes, numbers, 0, "First element: array[0]", RED)
        self.wait(1)
        
        # Access last element
        self.highlight_access(boxes, numbers, len(values)-1, "Last element: array[6]", ORANGE)
        self.wait(1)
        
        # Access middle element
        mid_index = len(values) // 2
        self.highlight_access(boxes, numbers, mid_index, f"Middle element: array[{mid_index}]", PURPLE)
        self.wait(1)

    def highlight_access(self, boxes, numbers, index, description, color):
        # Create highlight
        highlight_box = boxes[index].copy()
        highlight_box.set_stroke(color=color, width=4)
        
        # Create description
        desc_text = Text(description, font_size=20, color=color)
        desc_text.to_edge(DOWN, buff=1)
        
        # Animate
        self.play(
            Create(highlight_box),
            numbers[index].animate.set_color(color),
            Write(desc_text),
            run_time=1
        )
        
        self.wait(1)
        
        # Clean up
        self.play(
            FadeOut(highlight_box),
            FadeOut(desc_text),
            numbers[index].animate.set_color(YELLOW),
            run_time=0.5
        )

    def create_properties_display(self, values):
        properties_title = Text("Array Properties:", font_size=24, color=BLUE)
        properties_list = VGroup(
            Text(f"• Length: {len(values)}", font_size=20, color=WHITE),
            Text("• Zero-indexed (starts at 0)", font_size=20, color=WHITE),
            Text("• O(1) random access time", font_size=20, color=WHITE),
            Text("• Contiguous memory layout", font_size=20, color=WHITE),
            Text("• Fixed size after creation", font_size=20, color=WHITE)
        )
        
        properties_list.arrange(DOWN, aligned_edge=LEFT, buff=0.2)
        properties = VGroup(properties_title, properties_list)
        properties.arrange(DOWN, aligned_edge=LEFT, buff=0.3)
        properties.to_edge(RIGHT, buff=1)
        
        return properties

    def show_array_operations(self):
        section_title = Text("2. Array Operations", font_size=36, color=GREEN)
        section_title.to_edge(UP, buff=2)
        self.play(Write(section_title))
        
        # Create initial array
        initial_values = [5, 12, 8, 3, 9]
        boxes, numbers, indices = self.create_array_visual(initial_values)
        array_group = VGroup(boxes, numbers, indices)
        
        self.play(Create(array_group))
        
        # Show insertion operation
        self.demonstrate_insertion(boxes, numbers, indices, initial_values, 2, 15)
        self.wait(1)
        
        # Show deletion operation  
        self.demonstrate_deletion(boxes, numbers, indices, initial_values, 1)
        self.wait(2)

    def demonstrate_insertion(self, boxes, numbers, indices, values, index, new_value):
        insert_title = Text(f"Insertion: Add {new_value} at index {index}", font_size=24, color=ORANGE)
        insert_title.to_edge(DOWN, buff=2)
        self.play(Write(insert_title))
        
        # Highlight insertion point
        arrow = Arrow(
            boxes[index].get_center() + UP * 1, 
            boxes[index].get_center() + UP * 0.1, 
            color=ORANGE
        )
        self.play(Create(arrow))
        
        # Create new element
        new_box = Rectangle(width=1.0, height=0.8, color=ORANGE, stroke_width=3)
        new_box.move_to(boxes[index].get_center())
        new_number = Text(str(new_value), font_size=24, color=YELLOW)
        new_number.move_to(new_box.get_center())
        
        # Show the new element appearing
        self.play(
            Create(new_box),
            Write(new_number),
            run_time=1
        )
        
        self.wait(1)
        
        # Clean up
        self.play(
            FadeOut(arrow),
            FadeOut(insert_title),
            FadeOut(new_box),
            FadeOut(new_number)
        )

    def demonstrate_deletion(self, boxes, numbers, indices, values, index):
        delete_title = Text(f"Deletion: Remove element at index {index}", font_size=24, color=RED)
        delete_title.to_edge(DOWN, buff=2)
        self.play(Write(delete_title))
        
        # Highlight element to delete
        delete_highlight = boxes[index].copy()
        delete_highlight.set_stroke(color=RED, width=4)
        
        self.play(
            Create(delete_highlight),
            numbers[index].animate.set_color(RED),
            run_time=1
        )
        
        # Show deletion animation
        self.play(
            FadeOut(delete_highlight),
            FadeOut(numbers[index]),
            run_time=1
        )
        
        self.wait(1)
        
        # Clean up
        self.play(FadeOut(delete_title))

    def show_search_demonstration(self):
        section_title = Text("3. Linear Search Algorithm", font_size=36, color=GREEN)
        section_title.to_edge(UP, buff=2)
        self.play(Write(section_title))
        
        # Create array for search
        search_values = [4, 7, 2, 9, 1, 6, 8]
        target = 9
        
        boxes, numbers, indices = self.create_array_visual(search_values)
        array_group = VGroup(boxes, numbers, indices)
        
        search_info = Text(f"Searching for: {target}", font_size=24, color=PURPLE)
        search_info.next_to(array_group, UP, buff=0.5)
        
        self.play(Create(array_group))
        self.play(Write(search_info))
        
        # Perform linear search animation
        self.animate_linear_search(boxes, numbers, search_values, target)
        
        # Show complexity information
        complexity_info = VGroup(
            Text("Linear Search Complexity:", font_size=24, color=BLUE),
            Text("• Time: O(n)", font_size=20, color=WHITE),
            Text("• Space: O(1)", font_size=20, color=WHITE),
            Text("• Best case: O(1) - found at first position", font_size=18, color=WHITE),
            Text("• Worst case: O(n) - found at last position", font_size=18, color=WHITE)
        )
        complexity_info.arrange(DOWN, aligned_edge=LEFT, buff=0.2)
        complexity_info.to_edge(RIGHT, buff=1)
        
        self.play(Write(complexity_info))
        self.wait(2)

    def animate_linear_search(self, boxes, numbers, values, target):
        step_counter = Text("Steps: 0", font_size=20, color=WHITE)
        step_counter.to_edge(DOWN, buff=1)
        self.play(Write(step_counter))
        
        for i, value in enumerate(values):
            # Update step counter
            new_counter = Text(f"Steps: {i+1}", font_size=20, color=WHITE)
            new_counter.to_edge(DOWN, buff=1)
            self.play(Transform(step_counter, new_counter))
            
            # Highlight current element
            current_highlight = boxes[i].copy()
            current_highlight.set_stroke(color=PURPLE, width=4)
            
            self.play(
                Create(current_highlight),
                numbers[i].animate.set_color(PURPLE),
                run_time=0.8
            )
            
            if value == target:
                # Found target!
                found_text = Text("FOUND!", font_size=28, color=GREEN)
                found_text.next_to(boxes[i], UP, buff=0.3)
                
                success_highlight = boxes[i].copy()
                success_highlight.set_stroke(color=GREEN, width=5)
                
                self.play(
                    Transform(current_highlight, success_highlight),
                    Write(found_text),
                    numbers[i].animate.set_color(GREEN),
                    run_time=1
                )
                
                self.wait(2)
                self.play(FadeOut(found_text), FadeOut(current_highlight))
                break
            else:
                # Not found, continue
                self.play(
                    FadeOut(current_highlight),
                    numbers[i].animate.set_color(YELLOW),
                    run_time=0.3
                )
        
        self.play(FadeOut(step_counter))