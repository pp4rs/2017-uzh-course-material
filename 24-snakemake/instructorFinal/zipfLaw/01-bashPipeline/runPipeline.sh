# runPipeline.sh
# Contributor: Lachlan Deer (@ldeer)
# See 'README.md' for explanation of what this file does
# Expected Usage:
#   $ bash runPipeline.sh

## Count Words of texts
python src/analysis/wordcount.py src/data/isles.txt out/analysis/isles.dat
python src/analysis/wordcount.py src/data/abyss.txt out/analysis/abyss.dat

## Plot word count distributions
python src/analysis/plotcount.py out/analysis/isles.dat out/figures/isles.png
python src/analysis/plotcount.py out/analysis/abyss.dat out/figures/abyss.png

## Test Zip's Law
python src/analysis/zipf_test.py \
        out/analysis/abyss.dat  \
        out/analysis/isles.dat \
        > out/final/results.txt
