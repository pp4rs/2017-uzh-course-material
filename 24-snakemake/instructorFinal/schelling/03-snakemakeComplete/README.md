# A Bash Pipeline for the Schelling Model

* Main Contributor: Lachlan Deer (@ldeer)

## What this directory does

* We extend the simple `Snakefile` in `02-snakemakeSimple` to a set of subworkflows and add a config file that references our directories
* Subworkflows are added to the following directories:
    * `src/data_management`
    * `src/analysis`
    * `src/final`
    * `src/paper`

## Important!

Snake workflow with a set of subworkflows cannot be built in a root directory that has a space or parentheses in the relative path to your home directory.
