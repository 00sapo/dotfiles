# sample ipython_config.py
c = get_config()

c.InteractiveShellApp.log_level = 20
c.InteractiveShellApp.extensions = ["autoreload"]
c.InteractiveShellApp.exec_lines = [
    """
try:
    import numpy as np
    %autoreload 2
    import pandas as pd
except:
    print('Cannot import numpy, pandas, or autoreload')
""",
]
c.InteractiveShell.color_info = True
# c.InteractiveShell.colors = 'Linux'
# c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.highlight_matching_brackets = True
