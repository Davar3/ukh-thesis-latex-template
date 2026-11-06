%% ukhthesis.cls
%% LaTeX class for theses and dissertations at the University of Kurdistan Hewlêr (UKH).
%% Follows "Presentation of Theses/Dissertations at the University of Kurdistan Hewlêr",
%% Presentation Guidelines V6.3 (amended September 2026).
%%
%% Unofficial. Copyright (c) 2026 Davar Adil Yassin. Released under the MIT License.
%% Compile with XeLaTeX (or LuaLaTeX) and Biber.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ukhthesis}[2026/11/06 v1.0 UKH thesis and dissertation class (Guidelines V6.3)]

%% ---------------------------------------------------------------- options
\newif\ifukh@kurdish   \ukh@kurdishtrue   % Sorani Kurdish (Arabic script) support
\newif\ifukh@numeric   \ukh@numericfalse  % numeric (IEEE) citations instead of APA
\newif\ifukh@eqparens  \ukh@eqparensfalse % equation numbers as (3.1) instead of 3.1
\DeclareOption{nokurdish}{\ukh@kurdishfalse}
\DeclareOption{numeric}{\ukh@numerictrue}
\DeclareOption{eqparens}{\ukh@eqparenstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%% Guideline 3b: A4 paper. Front pages single sided, so the whole thesis is set one-sided.
\LoadClass[12pt,a4paper,oneside]{report}

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{ukhthesis}{Please compile with XeLaTeX or LuaLaTeX}%
    {This class uses system fonts (Arial) and Kurdish script, which need XeLaTeX or LuaLaTeX.
     On Overleaf: Menu > Compiler > XeLaTeX.}
\fi

%% ---------------------------------------------------------------- page layout
%% Guideline 3c: binding (left) margin 3.0 cm, other margins 2.5 cm,
%% footer of 1.25 cm used for page numbers only.
\RequirePackage[a4paper,left=3cm,right=2.5cm,top=2.5cm,bottom=2.5cm,footskip=1.25cm]{geometry}

%% ---------------------------------------------------------------- fonts
%% Guideline 3e: Arial, 12 pt text. The class looks for Arial in this order:
%%   1. Arial installed on the computer (Windows and macOS have it);
%%   2. your own Arial files copied into a fonts/ folder in the project, which is how to
%%      get real Arial on Overleaf (Arial is licensed by Microsoft, so this template cannot
%%      include the files; never publish them in a public repository);
%%   3. Arimo, a free font with exactly Arial's letter widths, so pages break the same way.
\RequirePackage{fontspec}
%% Guideline 3d asks for two spaces between sentences: with \nonfrenchspacing below, the
%% space after a full stop becomes exactly twice a normal word space.
\defaultfontfeatures{Ligatures=TeX,PunctuationSpace=TwiceWordSpace}
\newcommand{\ukh@setarial}[5]{% #1 path, #2 regular, #3 bold, #4 italic, #5 bold italic
  \setmainfont{#2}[Path=#1,BoldFont=#3,ItalicFont=#4,BoldItalicFont=#5]%
  \setsansfont{#2}[Path=#1,BoldFont=#3,ItalicFont=#4,BoldItalicFont=#5]}
\IfFontExistsTF{Arial}{%
  \setmainfont{Arial}%
  \setsansfont{Arial}%
}{\IfFileExists{fonts/arial.ttf}{% file names as copied from Windows
  \ukh@setarial{fonts/}{arial.ttf}{arialbd.ttf}{ariali.ttf}{arialbi.ttf}%
}{\IfFileExists{fonts/Arial.ttf}{% file names as copied from macOS
  \ukh@setarial{fonts/}{Arial.ttf}{Arial Bold.ttf}{Arial Italic.ttf}{Arial Bold Italic.ttf}%
}{\IfFontExistsTF{Arimo-Regular.ttf}{%
  \setmainfont{Arimo}[Extension=.ttf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
  \setsansfont{Arimo}[Extension=.ttf,UprightFont=*-Regular,BoldFont=*-Bold,
    ItalicFont=*-Italic,BoldItalicFont=*-BoldItalic]%
}{%
  \setmainfont{texgyreheros}[Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic]%
  \setsansfont{texgyreheros}[Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic]%
}}}}
\renewcommand{\familydefault}{\rmdefault}

%% ---------------------------------------------------------------- spacing
%% Guideline 3d: one and a half line spacing, single column. Single spacing for notes,
%% table text and titles, figure text and titles, and indented quotations.
%% A stretch of 1.43 gives the same line pitch as Word's "1.5 lines" for Arial 12 pt.
\RequirePackage{setspace}
\setstretch{1.43}
%% No paragraph indentation and one blank line between paragraphs.
\RequirePackage[skip=12pt plus 2pt minus 1pt,indent=0pt]{parskip}
%% Two spaces between sentences (see PunctuationSpace in the font set-up above).
%% Write e.g.\ and i.e.\ with a backslash-space so they get a single space.
\nonfrenchspacing
%% Lets TeX stretch a line a little more instead of letting a long word stick out.
\setlength{\emergencystretch}{2em}
\AddToHook{env/quote/begin}{\singlespacing}
\AddToHook{env/quotation/begin}{\singlespacing}
\AddToHook{env/tabular/begin}{\singlespacing}
\AddToHook{env/tabularx/begin}{\singlespacing}
\AddToHook{env/longtable/begin}{\singlespacing}

%% ---------------------------------------------------------------- page numbers
%% Guidelines 3c, 3f and 5e: no headers; the footer holds only a centred page number.
\pagestyle{plain}

%% Start a block of end pages whose numbers carry a letter: R1, R2 ... (Guideline 3f).
\newcommand{\ukh@letteredpages}[1]{%
  \clearpage
  \gdef\thepage{#1\arabic{page}}%
  \setcounter{page}{1}%
}

%% ---------------------------------------------------------------- headings
%% Guideline 5c: chapter headings Arial bold 16 pt, sections bold 14 pt,
%% sub-sections bold 12 pt, all in title case, each chapter on a new page and
%% preceded by the word "Chapter" and its number. Guideline 5d: no deeper numbering.
\RequirePackage{titlesec}
\titleformat{\chapter}[block]
  {\singlespacing\fontsize{16}{20}\selectfont\bfseries}
  {\chaptertitlename\ \thechapter}{0.6em}{}
\titleformat{name=\chapter,numberless}[block]
  {\singlespacing\fontsize{16}{20}\selectfont\bfseries}{}{0pt}{}
\titlespacing*{\chapter}{0pt}{0pt}{18pt}
\titleformat{\section}
  {\singlespacing\fontsize{14}{17}\selectfont\bfseries}{\thesection}{0.75em}{}
\titlespacing*{\section}{0pt}{18pt}{6pt}
\titleformat{\subsection}
  {\singlespacing\fontsize{12}{15}\selectfont\bfseries}{\thesubsection}{0.75em}{}
\titlespacing*{\subsection}{0pt}{14pt}{4pt}
\titleformat{\subsubsection}
  {\singlespacing\normalsize\bfseries\itshape}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{10pt}{2pt}
\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}
%% Kept so they can be restored after bidi (see the end of this file).
\let\ukh@makechapterhead\@makechapterhead
\let\ukh@makeschapterhead\@makeschapterhead

%% ---------------------------------------------------------------- contents and lists
\RequirePackage[titles]{tocloft}
\newcommand{\ukh@listtitlefont}{\fontsize{16}{20}\selectfont\bfseries}
\renewcommand{\cfttoctitlefont}{\ukh@listtitlefont}
\renewcommand{\cftloftitlefont}{\ukh@listtitlefont}
\renewcommand{\cftlottitlefont}{\ukh@listtitlefont}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{18pt}
\setlength{\cftafterloftitleskip}{18pt}
\setlength{\cftafterlottitleskip}{18pt}
%% The contents list names itself and the other lists (as in the UKH Word template).
\renewcommand{\cftaftertoctitle}{\phantomsection\addcontentsline{toc}{chapter}{\contentsname}}
\renewcommand{\cftafterloftitle}{\phantomsection\addcontentsline{toc}{chapter}{\listfigurename}}
\renewcommand{\cftafterlottitle}{\phantomsection\addcontentsline{toc}{chapter}{\listtablename}}
\renewcommand{\contentsname}{Table of Contents}
%% Chapter lines read "Chapter 1 Introduction", with dot leaders on every line.
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchappresnum}{\chaptername\ }
\setlength{\cftchapnumwidth}{5.6em}
\setlength{\cftbeforechapskip}{4pt}
\setlength{\cftsecindent}{1.5em}
\setlength{\cftsecnumwidth}{2.6em}
\setlength{\cftsubsecindent}{4.1em}
\setlength{\cftsubsecnumwidth}{3.4em}
%% "Figure 2.1 Caption ....... 12" and "Table 3.1 Caption ....... 21"
\renewcommand{\cftfigpresnum}{Figure }
\renewcommand{\cfttabpresnum}{Table }
\setlength{\cftfignumwidth}{5.4em}
\setlength{\cfttabnumwidth}{5.4em}
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}
\renewcommand{\cftfigaftersnum}{}
\renewcommand{\cfttabaftersnum}{}


%% ---------------------------------------------------------------- floats and captions
%% Guideline 6a: numbered within chapters (Table 1.1, Figure 3.1); figure captions centred
%% below the figure, table captions centred above the table, Arial 10 pt.
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{float}
\RequirePackage{xcolor}
\RequirePackage{caption}
\DeclareCaptionFont{ukhten}{\fontsize{10}{12}\selectfont}
\captionsetup{font={singlespacing,ukhten},labelfont={},labelsep=colon,
  justification=centering,singlelinecheck=false}
\captionsetup[figure]{position=below,skip=6pt}
\captionsetup[table]{position=above,skip=6pt}

%% ---------------------------------------------------------------- equations
%% Guideline 6b: equations on their own lines, numbered within chapters (3.1).
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\ifukh@eqparens\else
  %% The guide shows the number without brackets: e = mc^2 ...... 3.1
  \renewcommand{\tagform@}[1]{\maketag@@@{\ignorespaces#1\unskip\@@italiccorr}}
\fi

%% ---------------------------------------------------------------- lists
\RequirePackage{enumitem}
\setlist{itemsep=2pt,topsep=4pt}

%% ---------------------------------------------------------------- links
%% Load order matters: hyperref, then polyglossia (which loads bidi), then biblatex.
\RequirePackage[hidelinks,bookmarksnumbered,unicode]{hyperref}

%% ---------------------------------------------------------------- Sorani Kurdish
%% Kurdish (Central Kurdish, Arabic script) through polyglossia's Kurdish module.
%% Use \textkurdish{...} inside a sentence or \begin{kurdish} ... \end{kurdish}
%% for a right-to-left paragraph such as a quoted poem.
\ifukh@kurdish
  \RequirePackage{polyglossia}
  \setdefaultlanguage[variant=british]{english}
  \setotherlanguage[variant=sorani,script=Arabic,numerals=eastern]{kurdish}
  \IfFontExistsTF{Vazirmatn}{%
    \newfontfamily\kurdishfont[Script=Arabic,Scale=MatchLowercase]{Vazirmatn}%
  }{\IfFontExistsTF{Noto Naskh Arabic}{%
    \newfontfamily\kurdishfont[Script=Arabic,Scale=1.05]{Noto Naskh Arabic}%
  }{%
    %% Amiri ships with TeX Live and Overleaf and covers every Sorani letter.
    \newfontfamily\kurdishfont[Script=Arabic,Scale=1.15,Extension=.ttf,
      UprightFont=*-Regular,BoldFont=*-Bold,ItalicFont=*-Italic,
      BoldItalicFont=*-BoldItalic]{Amiri}%
  }}
  \let\arabicfont\kurdishfont
  \let\kurdishfontsf\kurdishfont
  \let\kurdishfonttt\kurdishfont
  %% Arabic-script letters at the end of a word can overhang the space before them,
  %% so inline Kurdish gets a little extra room on both sides.
  \AddToHook{begindocument/end}{%
    \NewCommandCopy{\ukh@textkurdish}{\textkurdish}
    \DeclareDocumentCommand{\textkurdish}{O{}m}{%
      \hspace{0.15em}\ukh@textkurdish[#1]{#2}\hspace{0.15em}}}
\fi

%% ---------------------------------------------------------------- references
%% Guideline 1c: the school or department sets the style, but every in-text citation
%% must include a page number, for example \parencite[p.~12]{key} -> (Author, 2020, p. 12).
\RequirePackage{csquotes}
\ifukh@numeric
  \RequirePackage[backend=biber,style=ieee]{biblatex}
\else
  \RequirePackage[backend=biber,style=apa]{biblatex}
\fi
\DefineBibliographyStrings{english}{references={References}}
\defbibheading{ukhrefs}[\refname]{%
  \chapter*{#1}\phantomsection\addcontentsline{toc}{chapter}{#1}}
\setlength{\bibitemsep}{0.6\baselineskip}

%% ---------------------------------------------------------------- thesis details
\newcommand{\ukh@title}{Title of the Thesis}
\newcommand{\ukh@subtitle}{}
\newcommand{\ukh@author}{Author Name}
\newcommand{\ukh@previousdegree}{}
\newcommand{\ukh@studentid}{00000000}
\newcommand{\ukh@thesistype}{thesis}
\newcommand{\ukh@degree}{Master of Science in Subject}
\newcommand{\ukh@degreeshort}{MSc}
\newcommand{\ukh@subject}{Subject}
\newcommand{\ukh@department}{Department of Computer Science and Engineering}
\newcommand{\ukh@school}{School of Science and Engineering}
\newcommand{\ukh@university}{University of Kurdistan Hewlêr}
\newcommand{\ukh@date}{Month Year}
\newcommand{\ukh@place}{Erbil, Kurdistan}
\newcommand{\ukh@keywords}{}

\renewcommand{\title}[1]{\renewcommand{\ukh@title}{#1}\gdef\@title{#1}}
\newcommand{\subtitle}[1]{\renewcommand{\ukh@subtitle}{#1}}
\renewcommand{\author}[1]{\renewcommand{\ukh@author}{#1}\gdef\@author{#1}}
\newcommand{\previousdegree}[1]{\renewcommand{\ukh@previousdegree}{#1}}
\newcommand{\studentid}[1]{\renewcommand{\ukh@studentid}{#1}}
\newcommand{\thesistype}[1]{\renewcommand{\ukh@thesistype}{#1}}
\newcommand{\degree}[1]{\renewcommand{\ukh@degree}{#1}}
\newcommand{\degreeshort}[1]{\renewcommand{\ukh@degreeshort}{#1}}
\newcommand{\subject}[1]{\renewcommand{\ukh@subject}{#1}}
\newcommand{\department}[1]{\renewcommand{\ukh@department}{#1}}
\newcommand{\school}[1]{\renewcommand{\ukh@school}{#1}}
\newcommand{\university}[1]{\renewcommand{\ukh@university}{#1}}
\newcommand{\submissiondate}[1]{\renewcommand{\ukh@date}{#1}}
\newcommand{\place}[1]{\renewcommand{\ukh@place}{#1}}
\newcommand{\keywords}[1]{\renewcommand{\ukh@keywords}{#1}}
\AtBeginDocument{\hypersetup{pdftitle={\ukh@fulltitle},pdfauthor={\ukh@author},
  pdfsubject={\ukh@degree},pdfkeywords={\ukh@keywords}}}

%% Title and subtitle as one string, for the declaration and certificate texts.
\newcommand{\ukh@fulltitle}{\ukh@title\ifx\ukh@subtitle\@empty\else: \ukh@subtitle\fi}

%% One centred line of the title page or cover: size, then text.
%% Guide: centred, line spacing "multiple 1.08" with 8 pt after each paragraph.
\newcommand{\ukh@line}[2]{%
  {\fontsize{#1}{\fpeval{round(#1*1.15*1.08,1)}}\selectfont #2\par}\vspace{8pt}}

%% ---------------------------------------------------------------- front pages
%% Guideline 3f: front pages carry capital Roman numbers; the title page counts as I
%% but shows no number, so the Declaration is page II.
\newcommand{\frontmatter}{\clearpage\pagenumbering{Roman}}

%% Example 4a: title page.
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \setcounter{page}{1}%
    \singlespacing\centering
    \vspace*{0.5cm}
    {\bfseries\ukh@line{18}{\ukh@title}%
     \ifx\ukh@subtitle\@empty\else\ukh@line{18}{\ukh@subtitle}\fi}
    \vfill
    \ukh@line{12}{\itshape By}
    {\bfseries\ukh@line{16}{\ukh@author}}
    \ifx\ukh@previousdegree\@empty\else\ukh@line{12}{\ukh@previousdegree}\fi
    \ukh@line{12}{Student Number: \ukh@studentid}
    \vfill
    \ukh@line{12}{\itshape A \ukh@thesistype\ submitted in partial fulfilment of the
      requirements for the degree of}
    \ukh@line{14}{\ukh@degree}
    \vfill
    \ukh@line{13}{\ukh@department}
    \ukh@line{13}{\ukh@school}
    \ukh@line{13}{\ukh@university}
    \vfill
    \ukh@line{13}{\ukh@degreeshort}
    \ukh@line{13}{\ukh@date}
    \ukh@line{13}{\ukh@place}
    \vspace*{0.5cm}
  \end{titlepage}%
  \setcounter{page}{2}%
}

%% An unnumbered front or end chapter that appears in the table of contents.
\newcommand{\ukhchapter}[1]{%
  \chapter*{#1}\phantomsection\addcontentsline{toc}{chapter}{#1}}

%% Example 4b: Declaration (page II). Must be bound into every copy.
\newcommand{\makedeclaration}{%
  \ukhchapter{Declaration}
  I hereby declare that this dissertation/thesis entitled: “\ukh@fulltitle” is my
  own original work and hereby certify that unless stated, all work contained within this
  is my own independent research and has not been submitted for the award of any other
  degree at any institution, except where due acknowledgement is made in the text.

  \vspace{2cm}
  \begin{tabular}{@{}l@{}}
    Signature: \rule{6cm}{0.4pt}\\[0.9cm]
    Name: \ukh@author\\[0.9cm]
    Date: \rule{6cm}{0.4pt}
  \end{tabular}
}

%% Example 4c: Examining Committee Certification (page III).
\newcommand{\makecommitteecertification}{%
  \ukhchapter{Examining Committee Certification}
  We certify that we have read this dissertation/thesis: \enquote{\ukh@fulltitle} and as a
  committee have examined the student \enquote{\ukh@author} in its content and what is
  related to it. We approve that it meets the standards of a dissertation/thesis for the
  degree of \enquote{\ukh@degreeshort} in \enquote{\ukh@subject}.

  \vspace{1.8cm}
  {\singlespacing\noindent
  \begin{tabular}{@{}p{0.5\textwidth}p{0.45\textwidth}@{}}
    \rule{6cm}{0.4pt}      & \rule{6cm}{0.4pt}\\
    Signature              & Signature\\[0.4cm]
    Name:                  & Name:\\
    Viva Voce Chairperson  & Member\\[0.4cm]
    Date:                  & Date:\\[2.2cm]
    \rule{6cm}{0.4pt}      & \rule{6cm}{0.4pt}\\
    Signature              & Signature\\[0.4cm]
    Name:                  & Name:\\
    Supervisor             & Member\\[0.4cm]
    Date:                  & Date:
  \end{tabular}\par}
}

%% Guidelines 4d and 4e: optional Dedication and Acknowledgements, 16 pt bold titles,
%% 12 pt text with 1.5 spacing.
\newenvironment{dedication}{\ukhchapter{Dedication}}{}
\newenvironment{acknowledgements}{\ukhchapter{Acknowledgements}}{}

%% Guideline 4f: Abstract on its own single page, no citations, followed on the same
%% page by the author's key words.
\renewenvironment{abstract}{\ukhchapter{Abstract}}{%
  \ifx\ukh@keywords\@empty\else\par\medskip\textbf{Keywords:} \ukh@keywords\fi}

%% Guideline 4h: lists of abbreviations and symbols, in alphabetical order.
\newenvironment{abbreviations}{%
  \ukhchapter{List of Abbreviations}%
  \singlespacing
  \begin{longtable}{@{}p{3.2cm}p{\dimexpr\textwidth-3.2cm-2\tabcolsep\relax}@{}}}
  {\end{longtable}}
\newenvironment{symbols}{%
  \ukhchapter{List of Symbols}%
  \singlespacing
  \begin{longtable}{@{}p{3.2cm}p{\dimexpr\textwidth-3.2cm-2\tabcolsep\relax}@{}}}
  {\end{longtable}}

%% ---------------------------------------------------------------- main text
%% Guideline 3f: the body has Arabic numbers starting at the first page of the
%% Introduction (Chapter 1, Guideline 5a).
\newcommand{\mainmatter}{\clearpage\pagenumbering{arabic}\setcounter{page}{1}}

%% ---------------------------------------------------------------- end pages
%% Guideline 3g order: References (R), Glossary (G), Appendices (A), Published Papers (P),
%% Bibliography (B), Index (I). Each part is numbered with its letter: R1, R2 ...
\newcommand{\references}{%
  \ukh@letteredpages{R}%
  \printbibliography[heading=ukhrefs,title=References,notcategory=bibliographyonly]}

%% Guideline 8b: alphabetical list of technical terms.
\newenvironment{glossaryterms}{%
  \ukh@letteredpages{G}%
  \ukhchapter{Glossary}%
  \begin{description}[style=nextline,leftmargin=1.5em,itemsep=4pt]}
  {\end{description}}

%% Guideline 8c: appendices are "Appendix 1", "Appendix 2" ..., with sections 1.1, 1.2.
%% The Ethical Consent Approval form must be one of the appendices.
\renewcommand{\appendix}{%
  \ukh@letteredpages{A}%
  \setcounter{chapter}{0}%
  \renewcommand{\chaptername}{Appendix}%
  \renewcommand{\thechapter}{\arabic{chapter}}%
  \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{Appendix\ }}%
}

%% Guideline 8d: published papers bound in, numbered P1, P2 ...
\newcommand{\publishedpapers}{%
  \ukh@letteredpages{P}%
  \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{}}%
  \ukhchapter{Published Papers}}

%% Guideline 8e: a bibliography of works consulted but not cited, numbered B1, B2 ...
\newcommand{\bibliographypart}{%
  \ukh@letteredpages{B}%
  \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{}}%
  \printbibliography[heading=ukhrefs,title=Bibliography,category=bibliographyonly]}
\DeclareBibliographyCategory{bibliographyonly}

%% ---------------------------------------------------------------- hardcover
%% Example 12c: front cover, printed in gold by the binder on red board for MA/MSc.
%% Use cover.tex to produce it as a separate PDF for the binder.
\newcommand{\makecover}{%
  \begin{titlepage}
    \singlespacing\centering
    \vspace*{1.5cm}
    {\bfseries\ukh@line{18}{\ukh@title}%
     \ifx\ukh@subtitle\@empty\else\ukh@line{18}{\ukh@subtitle}\fi}
    \vfill
    \ukh@line{13}{By}
    {\bfseries\ukh@line{16}{\ukh@author}}
    \vfill
    \ukh@line{13}{\ukh@university}
    \ukh@line{13}{\ukh@place}
    \vfill
    \ukh@line{13}{\ukh@degreeshort}
    \ukh@line{13}{\ukh@date}
    \vspace*{1.5cm}
  \end{titlepage}}

%% ---------------------------------------------------------------- after bidi
%% bidi (loaded by polyglossia for right-to-left Kurdish) re-applies the report class's
%% default title page and chapter headings at the end of the preamble. Put the UKH
%% versions back once the document starts, and keep the UKH name for the contents list.
\let\ukh@maketitle\maketitle
\AddToHook{begindocument/end}{%
  \let\maketitle\ukh@maketitle
  \let\@makechapterhead\ukh@makechapterhead
  \let\@makeschapterhead\ukh@makeschapterhead
  \renewcommand{\contentsname}{Table of Contents}%
  %% bidi also swaps in the report class's contents commands; use tocloft's again.
  \renewcommand{\tableofcontents}{\clearpage\@cfttocstart\par\begingroup
    \parindent\z@ \parskip\cftparskip\@cftmaketoctitle\@starttoc{toc}\endgroup
    \@cfttocfinish}%
  \renewcommand{\listoffigures}{\clearpage\@cfttocstart\par\begingroup
    \parindent\z@ \parskip\cftparskip\@cftmakeloftitle\@starttoc{lof}\endgroup
    \@cfttocfinish}%
  \renewcommand{\listoftables}{\clearpage\@cfttocstart\par\begingroup
    \parindent\z@ \parskip\cftparskip\@cftmakelottitle\@starttoc{lot}\endgroup
    \@cfttocfinish}}

\endinput
