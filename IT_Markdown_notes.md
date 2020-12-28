<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Markdown notes

- [Markdown notes](#markdown-notes)
  - [Markdown](#markdown)
  - [cheatsheet](#cheatsheet)
    - [code blocks](#code-blocks)
    - [Blockquotes](#blockquotes)
    - [Rule](#rule)
    - [line breaks](#line-breaks)
  - [Using MS Visual Studio Code](#using-ms-visual-studio-code)
  - [installation and setup](#installation-and-setup)
    - [settings files](#settings-files)
    - [To snapshot images](#to-snapshot-images)
  - [Compiling with markdown-it](#compiling-with-markdown-it)
  - [Alternative MD compiler: pandoc](#alternative-md-compiler-pandoc)
  - [Deployment to AWS](#deployment-to-aws)
  - [Style for HTML](#style-for-html)

## Markdown

[Markdown guide](https://www.markdownguide.org/)  

[Compiling Markdown](https://code.visualstudio.com/docs/languages/markdown)

## cheatsheet

### code blocks

```bash
for code blocks
```

With syntax highlighting:

```python
var = a
print a
```

### Blockquotes

> this is a blockquote  
> with line 2

quote break

> and another quote.

### Rule

Three or more
***

___

### line breaks

use 2 spaces for lines  
next line

2 returns for paragraph.

2nd paragraph

## Using MS Visual Studio Code

In terminal window, run
> py -3 --version

To edit a file from ubuntu in VS Code, in the ubuntu folder type
>`code .`  
Or go in to vs code and navigate to it.

## installation and setup

need  markdown-it, so needed to install more packaged to get it.
installed nodejs on ubuntu
installed npm on ubuntu
installed markdown-it on ubuntu
that automatically got python 2.7 onto my machine ubuntu environment.

>`sudo apt install nodejs`  
>`sudo apt install npm`  
>`npm install -g markdown-it`  

### settings files

User settings in settings.json file, or UI.
Workspace settings in the .vscode folder

### To snapshot images

using "Paste Image" extension from Mushan

- copy to clipboard (start+shift+s)
- paste to markdown window (ctrl+alt+v)

I've set this up so images go into \jbnotes_images subfolder, with no prefix, and the datetime as the file name

## Compiling with markdown-it

1. ubuntu
created directory markdown_notes under ~
create sample.md file with simple markdown.

Simple example:  
>`markdown-it git.md -o git.html`

1. Create tasks.json
Use VSCode to create a template to access markdown-it from vs code. Add a label, and command  

>`"command": "markdown-it sample.md -o sample.html"`  

Puts tasks.json in vsCode subdir.

1. Run the build  
in VSCode, Terminal -> run task
puts output in the same folder.

## Alternative MD compiler: pandoc

[Pandoc tips](https://thisdavej.com/build-an-amazing-markdown-editor-using-visual-studio-code-and-pandoc/)

## Deployment to AWS

1. run compile_all_md.sh
2. copy the html folder to S3 bucket

## Style for HTML

Add to each file:
>`<LINK href="air_style_sheet.css" rel="stylesheet" type="text/css">`
Source style sheets from e.g. https://markdowncss.github.io/
