3D Printer Expert System
========================

Overview
--------

This 3D Printer Expert System is designed to help users choose a 3D printer that best suits their needs. The system asks a series of questions and, based on the user's responses, recommends a printer. It's built using Python, Tkinter for the GUI, and CLIPS (a forward-chaining rule-based programming language) for the expert system logic.

Requirements
------------

-   Python 3.x
-   Tkinter
-   CLIPS Python module

File Descriptions
-----------------

-   **interface.py**: This is the main Python script that runs the GUI for the expert system.
-   **drukarki3d.clp**: The CLIPS file containing the rules and logic for the expert system.

Setup and Execution
-------------------

1.  Ensure Python 3.x is installed on your system.
2.  Install the CLIPS Python module `pip install clips` if it's not already installed.

3.  Place both `interface.py` and `drukarki3d.clp` in the same directory.
4.  Run `interface.py` using Python `python interface.py`

5.  The GUI will launch, and you can interact with the expert system.

How It Works
------------

-   Upon launching, the GUI will present a button to start the expert system.
-   Once started, the system will ask a series of questions to the user. The user can select their preferences.
-   Based on the answers, the system will use its rules defined in `drukarki3d.clp` to suggest one or more suitable 3D printers.
-   After the recommendations are given, the user has the option to start over.
