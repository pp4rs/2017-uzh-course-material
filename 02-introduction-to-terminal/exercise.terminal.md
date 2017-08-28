# Terminal exercise

1. Create a directory some where beneath your home directory for the programming course

  ```
  mkdir -p $HOME/progcourse/shell/
  ```

2. Navigate to the just created folder

  ```
  cd !$
  ```

3. create a file called fruits.text

  ```
  touch fruits.txt
  ```

4. append 7 fruits to the just created file, each fruit on a seperate line, e.g. apples, oranges, grapes, banana, pears, kiwi, cherries

  ```
  printf "apples,\noranges\n,grapes\nbanana\npears\nkiwi\ncherries\n" >> fruits.txt
  ```
5. print out the number of lines used by fruits.txt

  ```
  wc -l fruits.txt
  ```

6. print out the content of fruits.txt and sort in alphabetical order

  ```
  cat fruits.txt | sort
  ```

7. append the alphabetical sorted content of fruits.txt to fruits.sorted.txt

  ```
  cat fruits.txt | sort >> fruits.sorted.txt
  ```
8. list the content of the folder, you should see to files

  ```
  ls -l
  ```
9. rename the fruits.sorted.txt to sorted.fruits.txt

  ```
  mv fruits.sorted.txt sorted.fruits.txt
  ```

10. Add the following content to a file:

  ```
  Perito Moreno Glacier
  Margerie Glacier
  Furtwängler Glacier
  Pasterze Glacier
  Pasterze Glacier
  Vatnajökull Glacier
  Fox Glacier
  Biafo Glacier
  Biafo Glacier
  Canada Glacier
  Yulong Glacier
  Yulong Glacier
  Jostedalsbreen Glacier
  ```
11. create a new file with the unique and sorted list of the glaciers, and compare the number of lines of both FilterService

  ```
  cat glaciers.txt | uniq | sort >> sorted.unique.glaciers.txt
  echo "old file `wc -l glaciers.txt` < --- > new file `wc -l sorted.unique.glaciers.txt`"
  ```

12. copy sorted.unique.glaciers.txt to lakes.txt

  ```
  cp sorted.unique.glaciers.txt lakes.txt
  ```

13. replace `Glacier` with `Lake` in the new created lakes.txt

  ```
  sed 's/Glacier/Lake/n' lakes.txt
  ```

14. create a new folder and change into that folder. In that folder create 4 files, two with a jpg extension and two with txt extension

  ```
  mkdir test
  cd
  touch {a,b}.jpg
  touch {a,b}.text
  ```

15. create two new folders, a `pictures` and a `text` folder. Move all files with a `jpg` extension into the `picuters` folder and all files with a `txt` extension into the `text` folder

  ```
  mkdir picuters text
  mv *.jpg pictures
  mv *.txt text
  ```

16.
