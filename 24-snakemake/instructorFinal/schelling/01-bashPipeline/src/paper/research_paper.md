---
title: An Example Title
subtitle: With Subtitle
author:
- Joe Bloggs
- Helmut Schmidt
date: "**Preliminary -- please do not quote**"
bibliography: src/paper/refs.bib
csl: src/paper/chicago.csl
abstract: 	Some abstract here.
---

# Introduction
\label{sec:introduction}


Our @Schelling69 example in the code is taken from @StachurskiSargent13

The decision rule of an agent is the following:
\input{./src/paper/formulas/decision_rule}

% this is one way to include a figure
\begin{figure}
    \caption{Segregation by cycle in the baseline model}

    \includegraphics[width=\textwidth]{./out/figures/baseline}

\end{figure}

% this is another

![Segregation in the Schelling model with limited moves per period \label{max_moves_2}](./out/figures/max_moves_2.png "max_moves_2")

<!-- \begin{figure}
    \caption{Segregation by cycle in the baseline @Schelling69 model, limiting the number of potential moves per period to two}

    \includegraphics[width=\textwidth]{./out/figures/max_moves_2}

\end{figure} -->

\newpage
\clearpage

# References
