<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Python tools

- [Python tools](#python-tools)
  - [Jupyter / Ipython commands](#jupyter--ipython-commands)
  - [Jupyter on VSCode](#jupyter-on-vscode)
  - [DVC (data version control)](#dvc-data-version-control)
  - [Python on VS Code](#python-on-vs-code)

## Jupyter / Ipython commands

Tab completion
Command mode with grey cell, edit mode is green cell.

```python
%run to run a .py file
Object? for help
Object?? For source code
Np.\*load\*? To show

%run (with file name) to run in new namespace
%load (with file name) to load a file to a cell
%paste to paste from clipboard to a cell
%cpaste to paste from clipboard to a cell but not execute
%matplotlib inline
! does a command system op, e.g. !cat filename
%%timeit to run a few loops of timing info
Series.drop? to get help
```

## Jupyter on VSCode

Jupyter starts automatically if necessary.

Looks pretty similar. Nice table viewer and plot viewer. Debug by exporting jupyter file as a python file, and back again. Live share. Variable explorer.  

Can connect to remote jupyter server.

## DVC (data version control)

Like a large scale GIT for data. Store on AWS, manage versions of data.

## Python on VS Code

run terminal  
f5 to run debugger. Config saved in launch.json  
