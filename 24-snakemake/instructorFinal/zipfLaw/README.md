# Snakemake Workflows with Zipf's law

* Main contributor: Lachlan Deer (@ldeer)

## What we do

We introduce the concept of research workflows and emphasize the role of buildtools to manage their execution. We start with a bash script, discuss potential problems and then look at how a specialized tool (in our case `Snakemake`) can be used to manage complicated workflows.

We build up confidence in using `Snakefiles` gradually by incrementally building up our knowledge and applying it a single workflow.

## The Workflow: Zipf's Law

* Zipf's law says that the first most occuring word in a text should occur twice as often as the second-most.
* To test this, we look at four texts, and run the following workflow:
    * Count the occurence of words within a text
    * Plot the frequency of each word in a text
    * Test Zipf's law by calcuating the ratio of the first and secon most occuring words
* We emphasize code modularity by completing each of these tasks with separate python files that can be used on any text.

## Incrementally Building Up Knowledge

To build up student comfort with unfamiliar tools we proceed gradually. In particular:

* `01-bashPipeline` creates a simple bash pipeline to complete the workflow
* `02a-firstRule` introduces `Snakemake` as a way of writing rules that translate shell commands into rules, that specify inputs and outputs
* `02b` is a student challenge to construct some simples rules using what we did together as a guide
* `03a-automaticVariables` shows how to use macros inside of `snakemake` to simplify the shell calls
* `03b` is a student challenge to apply `03a` to all rules
* `04-dependencies` discusses correct speciification of dependencies and how to reference multiple inputs
* `05-pattern rules` discusses how to generalize rules to run multiple instances
* `06-studentChallege` gets students to try to create a pattern rule on their own, copying the logic of `05-`
* `07-allTarget` shows how to create a target that will allow the execution of all build rules in a single call
* `08-subworkflows` demonstrates how to divide a workflow into multiple subworkflows, and how to manage dependencies between them
* `09-tidyingUp` introduces a `config.yaml` file to try and tidy up the mess of multiple calls to long directory names by prespecifying them in a separate file and then referenceing that dictionary

## Time to complete the lesson

We are allocating (in expectation) `4h 30m` to the teaching of this example. 

The remaining 90m of the day will ask students to walk through another example `schelling` to create a new workflow with less guidance. See the `schelling` directory's `README` file for further information
