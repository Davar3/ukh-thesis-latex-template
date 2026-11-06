# Build with: latexmk   (XeLaTeX + Biber)
$pdf_mode = 5;
$xelatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
# Overleaf runs latexmk in pdfLaTeX mode by default; this makes that mode use XeLaTeX too,
# so the template compiles even if the Overleaf compiler is left on pdfLaTeX.
$pdflatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';
$bibtex_use = 2;
@default_files = ('main.tex');
