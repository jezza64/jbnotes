<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Conda

- [Conda](#conda)
  - [Creating conda  environments](#creating-conda--environments)
  - [Installing packages](#installing-packages)
    - [Managing environments](#managing-environments)
  - [Conda vs Pip](#conda-vs-pip)

Conda and anaconda navigator can control package version, multiple environments, environment management. Navigator is just a GUI conda. Can e.g. run a different version of Python in a second environment on same machine.

Miniconda is cut down, just packages you need (not loads of DS packages). Separate install. Better for duplicating environments.

## Creating conda  environments

Miniconda sets up conda and the root environment. Root includes a version of python.

Conda in one folder.
\pkgs contains caches packages.
\envs contains environments
\scripts has executables, e.g. \Scripts\jupyter-notebook.exe

Get env info:
>`conda info`

Create environment
>`conda create --name conda-env python                  # Or use -n`

To specify package versions:
>`conda create -n conda-env python=3.7 numpy=1.16.1 requests=2.19.1`

Activate / Deactivate
>`conda activate conda-env`
>`conda deactivate`

Conda environments live in envs folder, e.g. /Users/user-name/miniconda3/envs   

Can set the folder on creation. This is good because have it under your project folder, one env per project. Then it's clear, but need to change the prompt to just the env name (change in .condarc file), and need to specify the --prefix flag when installing packages, because conda can't find the environment with just the name.
>`conda create --prefix /path/to/conda-env             # Or use -p`

List environments:  
>`conda env list`

## Installing packages

Can do 
-in the active environment -- this is better as no risk of unintentionally installing for all envs
-from default shell (use --name or --prefix)

By default packages come from anaconda repository. (same for all commands)

Install in active environment:
>`(conda-env) % conda install pandas`  
>`(conda-env) % conda install pandas=0.24.1`

Install from default shell:
>`% conda install -n conda-env pandas=0.24.1`

Update:
>`conda update pandas`

List:
>`conda list`

To install from alternate repository, pass --channel
>`conda install --channel conda-forge opencv`

Permanently add a channel as a package source:
>`conda config --append channels conda-forge`

Search for a package in repositaries:
>`conda search -f seaborn`

That modifies .condarc, where env variables are stored.

Can install with pip if you need, within conda. 
>`(conda-env) % pip install requests`

Pip doesn't have as many features (metadata) as conda so can cause problems, install from conda where you can.#

### Managing environments

Include a file in project root folder listing all packages with version numners. Make an environment file with:
>`(conda-env) % conda env export --file environment.yml`

To recreate an environment with an environment file:
>`% conda env create -n conda-env -f /path/to/environment.yml`

To add packages listed in an enviromnet file to existing enviroment:
>`% conda env update -n conda-env -f /path/to/environment.yml`

revision history:
>`conda list --revisions`

To roll back to previous revision:
>`conda install --revision 1`

Clean up tars to free disk space
>`conda clean --all`

To create a requirements.txt file
>`conda list --export > requirements.txt`

## Conda vs Pip

Pip is package manager for python
venv is environment manager for python
Conda does both, plus is multi language.

Conda Can run on linux, and can install from PiPy in a conda environment
Gets packages from anaconda cloud / ana repository
