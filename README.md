# duke-git
Easy, intuitive, add-on git commands (bash shell scripts).

# Introduction

The project provides a bunch of executable bash shell scripts that can be added to PATH and used as add-on git commands. These shell scripts begin with `git-`. In essence, we shall have custom, intuitive git commands to accomplish frequent tasks in git.

# Install and configure

## Install

### Default installation

By default `duke-git` shall be installed in `$HOME` 

```shell
bash <(wget --quiet --output-document=- https://raw.githubusercontent.com/cafeduke/duke-git/master/install.sh)
```

### Install in custom directory

Use the following command to install `duke-git` in custom directory `<path-to-custom-dir>`

```shell
bash <(echo "set -- <path-to-custom-dir>" && wget --quiet --output-document=- https://raw.githubusercontent.com/cafeduke/duke-git/master/install.sh)
```

## Add binary to path

```shell
# Edit $HOME/.profile and add $HOME/duke-git/bin as shown in below example
# Note: If you have provided <path-to-custom-dir>, add <path-to-custom-dir>/duke-git/bin to PATH
export PATH=${PATH}:${HOME}/duke-git/bin

# Reload
source ~/.profile
```

# Commands

## Core Commands Diagram
![DukeGitStorageLevel](/images/DukeGitStorageLevel.jpg)

## Command Usage Help

Execute command with `-h`  or `--help` to get the description and usage of the command.

## List of Commands

| Command                              | Description                                                  |
| ------------------------------------ | ------------------------------------------------------------ |
| git-history<br />git-history-commits | List of last `n` (default=25) from `branch` (default=current branch) |
| git-history-branch-commits           | List `commit` history of this branch. All `commit(s)` until it meets a `commit` of the parent `branch`. |
| git-ls-commit-files                  | List union of files (along with status code) affected by the `commit(s)` (default=`HEAD`) |
| git-ls-stage-files                   | List files in `stage` (index/cache)                          |
| git-ls-branch-files                  | List all the files touched by the branch. This includes files of all `commit(s)`, after branching from parent |
| git-ls-tags                          | List tags along with the commit ids and tag metadata         |
| git-mk-tag                           | Create a tag (Annotated tag), by name, with message and tag the `commit` |
| git-cat<br />git-cat-commit-file     | Print contents of file from `commit` (default `commit` is `HEAD`) |
| git-cat-stage-file                   | Print contents of file from `stage`                          |
| git-mv-head-work                     | Move files from `HEAD` to `workspace`                        |
| git-mv-stage-work                    | Move files from `stage` to `workspace`                       |
| git-cp-commit-work                   | Copy files from`HEAD` to work (The `commit` is unaffected)   |
| git-cp-stage-work                    | Copy files from stage to work.                               |
| git-branch<br />git-add-branch       | Create a `branch` (if not already present) and switch to the branch. |
| git-rm-work                          | List all untracked files in `workspace`. Remove these untracked files upon confirmation. |
| git-rm-stage-files                   | Remove given files from `stage`. The files shall be deleted permanently. |
| git-rm-branch                        | Delete a `branch` (if present)                               |
| git-rm-tag                           | Remove a tag                                                 |
| git-edit-tag                         | Point tag to new commit and/or update the tag message.       |
| git-diff-work-commit                 | Compare file in `workspace` with the file in `commit`        |
| git-diff-work-stage                  | Compare file in `workspace` with the file in `stage`         |
| git-diff-stage-commit                | Compare file in `stage` with the file in `commit`            |
| git-merge-commits                    | Join the top `n` `commit` into a single `commit` with `mesg` (Use the `HEAD`'s message by default) |
| git-merge-branch                     | Merge source/child `branch` into target/parent `branch`. The target `branch` defaults to the current `branch`. Open any merge conflict in meld (UI merge tool) |
| git-refresh                          | Refresh current `branch` with the remote counterpart. Open any merge conflict in meld (UI merge tool) |
| git-rebase                           | Rebase the current `branch` with the latest `commit` of parent `branch`. Open any merge conflict in meld (UI merge tool) |

# Sample Operations

Lets take a look at a couple of sample git operations.

## A fast-forward merge of branches

The developer in branch `dev_jackie`  has added "Jackie", meanwhile the master has proceeded by 2 commits adding veggies. The developers commit does not conflict with the existing commits in master. Below, we see a fast-forward merge of the developer branch on to the master.

![Merge](/images/Merge.jpg)

## A rebase that results in conflict

The developer in branch `dev_jackie` has added "Jackie", meanwhile the master has proceeded by 1 commit adding "Mango". The master and dev have modified the same file "fruit.txt". Instead of merge as seen in the above section, the developer chooses to rebase with the master. The list of files having conflict are displayed. A UI tool [meld](https://meldmerge.org/) is opened upon confirmation to resolve merge conflicts.

![Rebase](/images/Rebase.jpg)

The merge conflict is displayed using meld as shown below.

![Rebase](/images/RebaseMeld.jpg)

Once the conflicts have been resolved the script prompts us to double check the changes and continue with `git rebase --continue`

![Rebase](/images/RebaseCompletion.jpg)