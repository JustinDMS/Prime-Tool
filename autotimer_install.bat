@ECHO "Installing Virtual Enviornment..."
py -3.10 -m venv Scripting\venv

ECHO "Updating pip..."
Scripting\venv\Scripts\python -m pip install --upgrade pip --quiet

ECHO "Installing requirements..."
Scripting\venv\Scripts\python -m pip install dolphin-memory-engine

ECHO Done!
PAUSE
