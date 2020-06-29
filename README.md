---
typora-root-url: ./
---

# duke-git
Easy, intuitive, add-on git commands (bash shell scripts).

# Introduction

The project provides a bunch of executable bash shell scripts that can be added to PATH and used as add-on git commands. These shell scripts begin with `git-`. In essence, we shall have custom, intuitive git commands to accomplish frequent tasks in git.

# Help

Execute command with `-h`  or `--help` to get the description and usage of the command.

# Commands

| Command                              | Description                                                  |
| ------------------------------------ | ------------------------------------------------------------ |
| git-history<br />git-history-commits | List of last `n` (default=25) from `branch` (default=current branch) |
| git-history-branch-commits           | List `commit` history of this branch. All `commit(s)` until it meets a `commit` of the parent `branch`. |
| git-ls-commit-files                  | List union of files (along with status code) affected by the `commit(s)` (default=`HEAD`) |
| git-ls-stage-files                   | List files in `stage` (index/cache)                          |
| git-ls-branch-files                  | List all the files touched by the branch. This includes files of all `commit(s)`, after branching from parent |
| git-cat<br />git-cat-commit-file     | Print contents of file from `commit` (default `commit` is `HEAD`) |
| git-cat-stage-file                   | Print contents of file from `stage`                          |
| git-mv-commit-work                   | Move files from `commit` (defaults to `HEAD`) to `workspace` |
| git-mv-stage-work                    | Move files from `stage` to `workspace`                       |
| git-cp-commit-work                   | Copy files from`HEAD` to work (The `commit` is unaffected)   |
| git-branch<br />git-add-branch       | Create a `branch` (if not already present) and switch to the branch. |
| git-rm-work                          | List all untracked files in `workspace`. Remove these untracked files upon confirmation. |
| git-rm-stage-files                   | Remove given files from `stage`. The files shall be deleted permanently. |
| git-rm-branch                        | Delete a `branch` (if present)                               |
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

The developer in branch `dev_jackie`  has added "Jackie", meanwhile the master as proceeded by 2 commits adding veggies. The developers commit does not conflict with the existing commits in master. Below, we see a fast-forward merge of the developer branch on to the master.

![](/images/Merge.jpg)