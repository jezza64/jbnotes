<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Git

- [Git](#git)
  - [Git installation](#git-installation)
    - [Git Commands](#git-commands)
  - [Branches](#branches)
  - [Simpler VSCode branch workflow](#simpler-vscode-branch-workflow)
  - [git Stash](#git-stash)
  - [Merge conflicts](#merge-conflicts)
  - [tagging](#tagging)

[Back to index](index.html)

## Git installation

General Steps:

1. Set up a remote repository on github  
2. install git
3. Git config --global user_name "jezza64" to set credentials.  

Nowhere to store password without more effort.

Make the current folder a git repository
>`git init`

Add a remote repository
>`git remote add origin https:\github...`
Here, "origin" is a name for the repository. But confusing.

retrieve files to local
>`git pull`

To do all 3 at once, sets up the .git hidden folder and copies code.
>`git clone https:\\github...` [folder]

To see what remote repository the local repository is tracking,
>`git remote -v`

To store user name password,
>`git config credential.helper store`
Stores it in `.git-credentials` file in plain. ONly needed for remote server access, not for commands to staging area.

### Git Commands

[Good article on managing git and all the process steps](https://itnext.io/become-a-git-pro-in-just-one-blog-a-thorough-guide-to-git-architecture-and-command-line-interface-93fbe9bdb395)

Use `git pull` to get remote changes to local
Commits are actually deltas for each file.
The remote repository merges the changes.  

Local has

1. working area
2. staging area
3. commit area
**Need to use git push to get commits to remote server.** Forgot this and it was painful!!

Use `git status` to see the files which have changed.

Use `git add [filename]` to add a file to staging, or add a new file to working area.
Use `git add -A` to move all changes deleted new files from the working area to the staging area.
Use `git reset` to move a file back to working area
Use `git commit -m "dev"` to commit.
Commit is a batch of changes ready to go.
Use `git log` to see all commits.
Can add to a commit with `git amend`. Changes hash.

To pass these changes to the remote repository (called origin) in master branch
>`git push -u origin master`

To correct a change you want to reverse, `git checkout [filename]`
To clear out untracked files `git clean -f -d`

## Branches

Git history is just a series of commits. Branch is the name of this series. HEAD is pointer to the last commit.
Standard procedure for each developer to work on own branch. Then test, then merge in master.

You're always in a branch. Check which branch you are in with `git status`. The one with the asterix is the one you're in.

Create branch with `git branch [branch name]`, then enter into it with `git checkout [branch name]`

Compare the hash of the HEAD of the branch with the HEAD of master to see if there are changes from master.

use `git fetch` to refresh the branch list.
use `git branch -a` to see which remote branches are available.

To merge back to master, need to merge the commits carefully as there could have been other users on the master. **This is the main job is git.**

Use `git checkout master` to change into master.
Need to refresh the master branch to local to pick up any changes. Use `git pull` to do this. Always do this.
Use `git merge [branch name]` to merge the branch to master.
Use `git branch --merged` to verify the merger.
Then use `git push` to synchronize the master back to the repository.
To delete local branch after merge, `git branch -d [branch name]`
To delete remote branch, `git push --delete origin [branch name]`

## Simpler VSCode branch workflow

- Select a branch to work in
- edit files
- commit locally
- push to server
- on git web site, create pull request
- then merge branch back into master
- delete branch
- **careful because the branch you are in in VS code is automatically created. Flagged in bottom rh corner.**
- Need to publish branch before pushing.

Nice easy help: https://rogerdudler.github.io/git-guide/

## git Stash

Means secretly hiding something, safe place.
`git stash` reverts files, but keeps your files. Use `git stash list` to see them.

## Merge conflicts

You've changed a line, so has someone else.
use `git pull` to bring in changes to your local env. Does a local merge, and shows unresolved issues. Adds conflicting changes to the local file, with <<<<,  >>>> tags.
Best to regularly do `git pull`, and push your commits.

## tagging

Use `git tag [version]` to label a commit with a version
use `git show [tag name]` to see details.
