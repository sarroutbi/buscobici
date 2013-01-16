#!/bin/bash
pdflatex frame.tex 
pdftk frame.pdf cat 2-end output statistics.pdf
