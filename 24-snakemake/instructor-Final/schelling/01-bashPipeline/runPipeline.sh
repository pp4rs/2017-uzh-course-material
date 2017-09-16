# runPipeline.sh
# Contributor: Lachlan Deer (@ldeer)
# See 'README.md' for explanation of what this file does
# Expected Usage:
#   $ bash runPipeline.sh

## initial_locations : Generate the initial locations of agents.
echo "drawing initial locations"
python src/data_management/get_simulation_draws.py \
    out/data/initial_locations.csv

## baseline model  : run the Schelling model using the baseline rules on how
##                   agents can move
# Pass variables in the following order
#     (0) The script to run
#     (1) Model Specification
#     (2) The Data Set
#     (3) Location of the Log file
#     (4) The pickle file that stores the output
echo "simulating baseline model"
python src/analysis/schelling.py \
	   src/model_specs/baseline.json   \
	   out/data/initial_locations.csv \
	   out/analysis/log/baseline.log \
	   out/analysis/baseline.pickle

## max_moves_2 model  : run the Schelling model using the modified rules on how
##                     agents can move
# Pass variables in the following order
#     (0) The script to run
#     (1) Model Specification
#     (2) The Data Set
#     (3) Location of the Log file
#     (4) The pickle file that stores the output
echo "simulating max_moves_2 model"
python src/analysis/schelling.py \
	   src/model_specs/max_moves_2.json   \
	   out/data/initial_locations.csv \
	   out/analysis/log/max_moves_2.log \
	   out/analysis/max_moves_2.pickle

## baseline.png            : Plot output of the baseline Schelling Model
# Pass Variables in the following order
#		(0) The script to run
#		(1) Mode Specification
#		(2) The pickle file that stores output
#		(3) The name of the figure the file creates

echo "plotting output from baseline model"
python src/final/plot_locations.py \
	   src/model_specs/baseline.json \
	   out/analysis/baseline.pickle \
	   out/figures/baseline.png

## max_moves_2.png      : Plot output of the max_moves_2 Schelling Model
# Pass Variables in the following order
#		(0) The script to run
#		(1) Mode Specification
#		(2) The pickle file that stores output
#		(3) The name of the figure the file creates

echo "plotting output from max_moves_2 model"
python src/final/plot_locations.py \
	   src/model_specs/max_moves_2.json \
	   out/analysis/max_moves_2.pickle \
	   out/figures/max_moves_2.png

## research_paper.pdf      : Compiles paper from markdown to pdf
# Pass Variables in the following order
#		(0) -H the preamble with latex styles and packages
#		(1) the source code of the paper
#		(2) --filter <...> how to format citations
#		(3) the output file created

echo "compiling research paper"
pandoc -H src/paper/preamble.tex \
    src/paper/research_paper.md \
    --filter pandoc-citeproc \
    -o out/paper/research_paper.pdf

## research_pres_30min.pdf      : Compiles slides from markdown to pdf
# Pass Variables in the following order
#		(1) the source code of the slides
#		(2) --filter <...> how to format citations
#       (3) -- slide-level <...> how many hashes indicate a new slide
#       (4) --latex-engine <...> how to build the pdf, either pdflatex or xelatex
#		(5) the output file created
echo "compiling the slides"

pandoc -t beamer \
    src/paper/research_pres_30min.md \
    --filter pandoc-citeproc \
    --slide-level 2 \
    --latex-engine=pdflatex \
    -o out/paper/research_pres_30min.pdf

echo "Workflow COMPLETE!"
