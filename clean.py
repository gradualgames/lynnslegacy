import os
import shutil

if os.path.exists("./ll"):
    shutil.rmtree("./ll", ignore_errors=True)
