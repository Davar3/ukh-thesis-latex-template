# UKH Thesis LaTeX Template

LaTeX template for theses and dissertations at the University of Kurdistan Hewlêr (UKH).

I made it when I started my MSc thesis. The university only gives a Word template, and I wanted to write mine in LaTeX. It follows the official presentation guidelines (version 6.3, September 2026) and supports Sorani Kurdish.

It should work for MSc/MA, PhD and BSc. You can see what it looks like in [example.pdf](example.pdf).

It's not an official UKH template, so check with your supervisor and the latest guidelines on the [library website](https://www.ukh.edu.krd/library/library-resources/dissertations-and-thesis/) before you submit.

## How to use it

**Overleaf:** download this repo as a ZIP. On Overleaf go to New Project > Upload Project. It compiles with XeLaTeX (set in `latexmkrc`). If it doesn't, change the compiler to XeLaTeX from the menu.

**Your own computer:** install TeX Live or MacTeX, then run `latexmk` in the folder.

Then:
- put your details in `thesis-info.tex`: title, name, student number, degree and so on
- write your chapters in `chapters/`
- put your references in `references.bib` (I export mine from Zotero)

## What it follows from the guidelines

- A4, 3 cm left margin, 2.5 cm for the others
- Arial 12 pt, 1.5 line spacing, no indent, an empty line between paragraphs, two spaces between sentences
- single spacing in tables, captions and long quotes
- chapter titles in 16 pt bold ("Chapter 1 Introduction"), sections 14 pt, subsections 12 pt, no numbering deeper than 1.1.1
- no headers, just the page number centred at the bottom
- page numbers:
  - Roman numerals for the front pages: the title page counts as I but shows no number, the declaration is II and the committee page is III
  - normal numbers from the introduction
  - R1, G1, A1, P1 and B1 for references, glossary, appendices, published papers and bibliography
- title page, declaration and examining committee page laid out like the examples in the guide
- table captions above, figure captions below, 10 pt, numbered by chapter (Table 2.1, Figure 3.1)
- equations numbered by chapter
- appendices named Appendix 1, Appendix 2 and so on, with a place for the ethical consent form (it's required)
- `cover.tex` makes the hard cover page for the binder

## Notes

**Citations:** UKH wants a page number in every in-text citation. `\parencite[p.~12]{key}` gives (Author, 2020, p. 12). The default style is APA, but check with your department. `\documentclass[numeric]{ukhthesis}` switches to numbered citations like [1].

**Kurdish:** use `\textkurdish{...}` inside a sentence, or `\begin{kurdish} ... \end{kurdish}` for a whole right-to-left paragraph, for example when you quote a poem.

**Abbreviations:** because of the two spaces after a full stop, write `e.g.\ ` with a backslash so the abbreviation doesn't get a big gap.

**Arial on Overleaf:** Overleaf doesn't have Arial (it's a Microsoft font), and I can't include it here.
- **Without it:** the template uses Arimo, which has exactly the same letter widths, so the page breaks stay the same.
- **To use the real Arial:** make a `fonts` folder in your Overleaf project and upload your own Arial files from your computer:
  - from Windows: `arial.ttf`, `arialbd.ttf`, `ariali.ttf`, `arialbi.ttf`
  - from a Mac: `Arial.ttf`, `Arial Bold.ttf`, `Arial Italic.ttf`, `Arial Bold Italic.ttf`
- Don't put those files in a public repo.

**Kurdish fonts:** it uses Vazirmatn or Noto Naskh Arabic if you have them. Otherwise it uses Amiri, which comes with TeX Live and Overleaf.

## Options

- `numeric`: numbered citations instead of APA
- `eqparens`: equation numbers like (3.1) instead of 3.1
- `nokurdish`: turns off Kurdish support

## Before you submit

- 70–120 pages for MSc/MA (150–200 for PhD, 35–50 for BSc), not counting the front and end pages
- abstract on one page, with no citations
- ethical consent form as an appendix
- 3 bound copies (red cover for MSc/MA, black for PhD, blue for BSc) and a PDF on CD

## Credits and license

Kurdish support comes from the Kurdish module of [polyglossia](https://ctan.org/pkg/polyglossia). See also the [Kurdish XeLaTeX group](https://github.com/KurdishXeLaTeX).

MIT license. If something doesn't match the guidelines, open an issue or send a pull request.
