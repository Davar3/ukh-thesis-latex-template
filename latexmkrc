# Build with: latexmk main.tex   (or latexmk cover.tex)
$pdf_mode = 5;          # XeLaTeX
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex_use = 2;        # run Biber when needed
@default_files = ('main.tex');
