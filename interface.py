import tkinter as tk
import clips

# Initialize the CLIPS environment
env = clips.Environment()

def run_expert_system():
    # Load the .clp file
    try:
        env.load('drukarki3d.clp')
        print("CLIPS file loaded successfully.")
    except Exception as e:
        print(f"Error loading CLIPS file: {e}")
        return

    # Reset and run the initial rules in the CLIPS environment
    env.reset()
    env.run()

    # Function to handle user choice and update the CLIPS environment
    def handle_choice(question_id, choice):
        print(f"Chosen: {choice} for question ID: {question_id}")
        env.assert_string(f"(answer (id {question_id}) (value \"{choice}\"))")
        env.run()

        # Retract the question after processing the choice
        for question in [fact for fact in env.facts() if fact.template.name == 'question']:
            if question['id'] == question_id:
                question.retract()
                break

        display_questions()

    # Function to display questions and options
    def display_questions():
        # Clear the previous content
        for widget in frame.winfo_children():
            widget.destroy()

        # Get the current questions from the CLIPS environment
        questions = [fact for fact in env.facts() if fact.template.name == 'question']
        print(f"Number of questions: {len(questions)}")

        if not questions:
            # Display recommended printers
            printers = [fact for fact in env.facts() if fact.template.name == 'printer']
            for printer in printers:
                tk.Label(frame, text=f"Recommended printer: {printer['name']}").pack()
            return

        question = questions[0]
        tk.Label(frame, text=question['text']).pack()
        question_id = question['id']

        for option in question['options']:
            tk.Button(frame, text=option, command=lambda choice=option, qid=question_id: handle_choice(qid, choice)).pack()

    # Create a frame to hold question and answer widgets
    frame = tk.Frame(root)
    frame.pack(expand=True, fill=tk.BOTH)

    # Display initial questions
    display_questions()

# Create the main window
root = tk.Tk()
root.title("3D Printer Expert System")
root.geometry("500x400")

# Add a button to run the expert system
run_button = tk.Button(root, text="Run Expert System", command=run_expert_system)
run_button.pack()

# Start the GUI event loop
root.mainloop()
