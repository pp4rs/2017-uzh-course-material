# Git Local exercise

1. create a new folder

  ```
  mkdir git-existing-repository
  ```

2. change to the newly created folder

  ```
  cd git-existing-repository/
  ```

3. created at least 10 folders with wildcards

  ```
  mkdir important-stuff-{a..f}
  ```

4. list the created folders

  ```
  ls -la
  ```

5. put in each of the above created folder at least 10 markdown files with wildcards

  ```
  touch important-stuff-{a..f}/file-{1..3}{a..b}.md
  ```
6. init git

  ```
  git init
  ```

7. check git status

  ```
  git status
  ```

8. stage all files

  ```
  git add .
  ```

9. check git status

  ```
  git status
  ```

8. change your git username and email for the current repository

  ```
  git config --local user.name "Ser Hackerman"  
  git config --local user.email "hacker@rule-the-world.org"
  ```
9. create a file called `newfile.md`

  ```
  touch newfile.md
  ```

10. put some content in the file created above

  ```
  vi newfile.md
  ```

11. check git status

  ```
  git status
  ```

12. stage the changes

  ```
  git add newfile.md
  ```

13. check git status

  ```
  git status
  ```

14. check what the `-f` flag in `git add somefile -f` is doing

  ```
  git add --help
  ```

15. commit your changes

  ```
  git commit -m "Initial commit."
  ```
