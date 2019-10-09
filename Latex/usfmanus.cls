\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{usfmanus}[2019/09/15 2.0 jbsubils
University of South Florida Manuscript Class]

% Heavily modified by Jean-Baptiste Subils (jbsubils@gmail.com) in 2019 when a lot of changes were requested from graduate studies.
%I hacked my way through it. It may not work for your needs but adapt it and share with other :)

% ------------------------------------------------------------------------------
%  Add Additional Packages here
% ------------------------------------------------------------------------------
\RequirePackage{setspace,etoolbox}

\newcommand\@ptsize{}
\newif\if@frontmatter
\newif\if@copyrightpage
\@copyrightpagefalse
\newif\if@openbib
\@openbibfalse
\newif\ifvitarequired \vitarequiredfalse
\newif\if@final \@finaltrue
\newif\ifdiss \dissfalse

\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{draft}{\setlength\overfullrule{5pt}\@finalfalse}
\DeclareOption{final}{\setlength\overfullrule{0pt}\@frontmattertrue\@finaltrue}
\DeclareOption{copyright}{\@copyrightpagetrue}
\DeclareOption{frontmatter}{\@frontmattertrue}
\DeclareOption{nofrontmatter}{\@frontmatterfalse}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{\@openbibtrue}
\DeclareOption{thesis}{
  \newcommand\reporttypeshort{thesis}
  \newcommand\reporttypelong{Master's Thesis}
}
\DeclareOption{dissertation}{
  \newcommand\reporttypeshort{dissertation}
  \newcommand\reporttypelong{Ph.D. Dissertation}
  %\vitarequiredtrue % create vitapage I don't think this is required
  \disstrue
}
\DeclareOption{vita}{
  \vitarequiredtrue % create vitapage even for MS
}
\ExecuteOptions{10pt,final,frontmatter}
\ProcessOptions

\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}

%FYI important: For some reason overleaf will not respect the paper size for the few first pages. Fixed by (in main.tex):
% \usepackage{ifpdf}
% \ifpdf
%   \pdfpageheight=11in
%   \pdfpagewidth=8.5in
% \else
%   \special{papersize=11in,8.5in}
% \fi
\paperheight 11in
\paperwidth 8.5in


\voffset 0in
\topmargin 0in

\headheight 0pt
\headsep 0pt
\textheight 9.0in

\oddsidemargin 0.5in
% \evensidemargin 0in
% \marginparwidth 0.0in
% \textwidth 5.95in%6.0in
\widowpenalty \@MM
\clubpenalty \@MM

\def\ps@headings{%
  \let\@oddfoot\@empty
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markright {\ifnum \c@secnumdepth >\m@ne
        \@chapapp\ \thechapter. \ \fi
        ##1}}}
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\thepage\hfil\slshape\leftmark}%
  \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
  \let\@mkboth\@gobbletwo
  \let\chaptermark\@gobble
  \let\sectionmark\@gobble}

\def\ps@myotherheadings{%
  \def\@evenfoot{\thepage\hfil}%  -> page number then fill
  \def\@oddfoot{\hfil\thepage} %  -> fill, then page number
  \def\@oddhead{{\slshape\rightmark}\hfil} % remove the page number
  \def\@evenhead{\hfil\slshape\leftmark}%
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble
}

\newcommand\chaptermark[1]{}
\setcounter {secnumdepth}{3}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thechapter       {\arabic{chapter}}
\renewcommand\thesection       {\thechapter.\arabic{section}}
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection .\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}

\newcommand\@chapapp{Chapter}
\newcommand\chapter{%
  \clearpage
  \doublespacing
  \thispagestyle{myotherheadings}
  \global\@topnum\z@
  %\@afterindentfalse
  \@afterindenttrue
  \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{%
  \refstepcounter{chapter}%
  \typeout{\@chapapp\space\thechapter. #1}%
  % 1999.6 Period after chapter number removed in TOC.  HJG
  \addcontentsline{toc}{chapter}{\protect\numberline{%
        {\@chapapp\space\thechapter:\space#1}}}%
  \chaptermark{#1}%
  \@makechapterhead{#2}%
  \@afterheading}
\def\@makechapterhead#1{%
  \vspace*{0.7in}%
  {\centering
    \ifnum \c@secnumdepth >\m@ne
      \bfseries \@chapapp\space\thechapter:\space#1 \par
    \fi
%    \vspace*{1000\p@}

    \par\nobreak
    \vspace*{20\p@}}
  % HJG: The following line controls spacing in the chapters
%  \@finaltrue
  \if@final
  \normalsize
        \doublespacing
  \else
 \normalsize    \onehalfspacing
  \fi}
\def\@schapter#1{%
  \addcontentsline{toc}{chapter}{\protect\numberline{#1}}%
  \@makeschapterhead{#1}%
  \@afterheading}
\def\@makeschapterhead#1{%
  \vspace*{.7in}
  {\centering
    \bfseries#1
    \par\nobreak
    \vspace*{20\p@}}}

\newcommand\section{\@startsection {section}{1}{\z@}%
  {3.25ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\reset@font\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\reset@font\itshape}} %removed centering MWP
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {3.25ex\@plus -1ex \@minus -.2ex}
  {1.5ex\@plus .2ex}
  {\reset@font\itshape}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\reset@font\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\reset@font\normalsize\bfseries}}

\setlength\leftmargini  {2.5em}
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}

\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\arabic{enumi}}
\renewcommand\theenumii{\alph{enumii}}
\renewcommand\theenumiii{\roman{enumiii}}
\renewcommand\theenumiv{\Alph{enumiv}}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}

\newenvironment{description}
{\list{}{\labelwidth\z@ \itemindent-\leftmargin
    \let\makelabel\descriptionlabel}}
{\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
  \normalfont\bfseries #1}
\newenvironment{verse}
{\let\\=\@centercr
  \list{}{\itemsep      \z@
    \itemindent   -1.5em%
    \listparindent\itemindent
    \rightmargin  \leftmargin
    \advance\leftmargin 1.5em}%
\item[]}
{\endlist}
\newenvironment{quotation}
{\list{}{\listparindent 1.5em%
    \itemindent    \listparindent
    \rightmargin   \leftmargin
    \parsep        \z@ \@plus\p@}%
\item[]}
{\endlist}
\newenvironment{quote}
{\list{}{\rightmargin\leftmargin}%
\item[]}
{\endlist}
\newlength{\appendixheadheight}\setlength{\appendixheadheight}{23\p@}
\newlength{\appendixheadsep}   \setlength{\appendixheadsep}{20\p@}

% This controls the appendix chapter. It creates a separate page before appendices and a header in the TOC
% \newcommand\appendix{%
% 	\setcounter{chapter}{0}
% 	\setcounter{section}{0}
% 	\renewcommand\thechapter{\Alph{chapter}}
% 	\newpage
% 	\par\null\vfill
% 	\vspace*{-7.2in}
% 	\def\@appname{\appendicesname}
% 	\textbf{\hfill\@appname\hfill}
% 	\par\vfill\par
% 	\addcontentsline{toc}{chapter}{\protect\numberline{%
% 			\@appname}}
% 	\let\chapter=\appendixchapter
% 	\addtolength{\textheight}{-\appendixheadheight}
% 	\addtolength{\textheight}{-\appendixheadsep}}

\newcommand{\appendixchapter}[1]{%
	\clearpage
	\refstepcounter{chapter}
	\doublespacing
	\addcontentsline{toc}{appendix}{%
		\protect\numberline{%
			\appendixchaptername\space\thechapter}%
		%\hspace*{-0.25in}
		\ignorespaces{#1}}
	\@makeappendixhead{#1}}

% I thought the following was for the appendix page but removing did not change anything
% \newsavebox{\appendixfirsthead}
% \def\ps@appendixchapterfirstpage{\relax}
% \def\@makeappendixhead#1{%
% 	\setlength{\headheight}{\appendixheadheight}
% 	\setlength{\headsep}{\appendixheadsep}
% 	\renewcommand{\ps@appendixchapterfirstpage}{%
% 		\renewcommand{\@oddhead}{%
% 			\protect\parbox[b][\appendixheadheight][t]{\textwidth}{%
% 				\def\baselinestretch{1}\normalsize
% 				\protect \centering % commented out centering MWP
% 				\textbf{\appendixchaptername\space\thechapter} %\\ commented break MWP
% 				\textbf{#1}}}%
% 		\renewcommand{\@evenhead}{\@oddhead}%
% 		\renewcommand{\@evenfoot}{\hfil\thepage\hfil}%
% 		\renewcommand{\@oddfoot}{\@evenfoot}}
% 	\renewcommand{\ps@plain}{%
% 		\renewcommand{\@oddhead}{%
% 			\protect\parbox[b][\appendixheadheight][t]{\textwidth}{%
% 				\def\baselinestretch{1}\normalsize
% 				\protect % \centering % commented centering MWP
% 				% 1999.6: "CONTINUED" changed to mixed case. HJG
% %				\textbf{\appendixchaptername\space\thechapter\space(Continued)}
% 			}}
% 		\renewcommand{\@evenhead}{\@oddhead}%
% 		\renewcommand{\@evenfoot}{\hfil\thepage\hfil}%
% 		\renewcommand{\@oddfoot}{\@evenfoot}}
% 	\pagestyle{plain}
% 	\thispagestyle{appendixchapterfirstpage}}

\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}
\long\def\@caption#1[#2]#3{%
  \par\addcontentsline{\csname ext@#1\endcsname}{#1}%
  {\protect\numberline{\csname #1name\endcsname\space\csname
      %the#1\endcsname\figurenamesep\ }{\ignorespaces #2}}
      the#1\endcsname\ }{\ignorespaces #2}}
  \addtocontents{\csname ext@#1\endcsname}{\protect\vspace{10\p@}}
  \begingroup \@parboxrestore \normalsize
  \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{5\p@} %10\p@}
\setlength\belowcaptionskip{5\p@} %0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1\figurenamesep\ #2}%
  %\sbox\@tempboxa{#1\ #2}%
  \ifdim \wd\@tempboxa >\hsize
  #1\figurenamesep\ #2\par
  %#1\ #2\par
  \else
  \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

\newcounter{figure}[chapter]
%\renewcommand\thefigure{\@arabic\c@figure}
\renewcommand \thefigure
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}{\@float{figure}}{\end@float}
\newenvironment{figure*}{\@dblfloat{figure}{\end@dblfloat}}

\@addtoreset {equation}{chapter}
\renewcommand\theequation
  {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
%\@addtoreset {equation}{chapter}
%\renewcommand\theequation{\arabic{equation}}

\newcounter{table}[chapter]
%\renewcommand\thetable{\@arabic\c@table}
\renewcommand \thetable
     {\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

\newcommand\@pnumwidth{.5in}
\newcommand\@tocrmarg {1in}
\newcommand\@dotsep{400}% This make the dot separation between the heading and the page number so large that they are not visible. Change 400 to 1 and take a look.
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
  \clearpage\singlespace
  \pagenumbering{roman}
  \global\@topnum\z@
  \@afterindentfalse
  \@makeschapterhead{\vspace{0.05in}\contentsname}
  \@afterheading
  \pagestyle{myotherheadings}
  \@starttoc{toc}}
\newcommand\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
{\leavevmode
   \bfseries #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
   \nobreak
     \global\@nobreaktrue
     \everypar{\global\@nobreakfalse\everypar{}}
    \endgroup
  \fi}
\newcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{7em}%8em}%
    \begingroup
      %\hyphenpenalty=10000\exhyphenpenalty=10000%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {#1}%
      \nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
      \endgroup
  \fi}
\newcommand\l@section      {\@dottedtocline{1}{0.5in}{2.3em}}
\newcommand\l@subsection   {\@dottedtocline{2}{1.0in}{3.2em}}
\newcommand\l@subsubsection{\@dottedtocline{3}{1.5in}{4.1em}}
\newcommand\l@paragraph    {\@dottedtocline{4}{2.0in}{5em}}
\newcommand\l@subparagraph {\@dottedtocline{5}{2.5in}{6em}}
\newcommand\l@appendix     {\@dottedtocline{1}{0.5in}{6.5em}}

\newcommand\listoffigures{%
  \chapter*{\vspace{-.1in}\listfigurename
    \@mkboth{\listfigurename}{\listfigurename}}%
  \vspace*{11\p@}
  \singlespace
  % ********** Look at document tocolft.pdf to make changes to lof layout**************
  \@starttoc{lof}}%
\newcommand\l@figure{\@dottedtocline{0}{0pt}{6em}} %5em}}

\newcommand\listoftables{%
  \chapter*{\vspace{-.1in}\listtablename
    \@mkboth{\listtablename}{\listtablename}}%
  \vspace*{11\p@}
  \pagestyle{myotherheadings}
    \singlespace
  \@starttoc{lot}}%
%\newcommand\l@table{\@dottedtocline{0}{0pt}{4em}} %5em}}
\let\l@table\l@figure

\newdimen\bibindent
\bibindent=1.4em %changed MWP from 1.5em
\newenvironment{thebibliography}[1]
{\chapter*{\vspace{-.12in}References
    \@mkboth{\bibname}{\bibname}}%
  \vspace*{\baselineskip}
  \list{\@biblabel{\arabic{enumiv}}}%
  {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \if@openbib
    \advance\leftmargin\bibindent
    \itemindent -\bibindent
    \listparindent \itemindent
    \parsep \z@
    \fi
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\arabic{enumiv}}}%
  \if@openbib
  \renewcommand\newblock{\par}
  \else
  \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
  \fi
  \sloppy\clubpenalty4000\widowpenalty4000%
  \sfcode`\.=\@m}
{\def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}
\newcommand\newblock{}

\if@final%
  \def\missingalert#1{\ClassError{usfmanus}{#1}{%
      Use the appropriate class command to provide the necessary
      \MessageBreak information.  See the usfsampt.tex and
      usfsampd.tex\MessageBreak files for examples.  You may use empty
      definitions, e.g.\MessageBreak \protect\title{}, or use the
      draft class option.  Otherwise, just try \MessageBreak pressing
      <return>.}}
\else%
  \def\missingalert#1{\ClassWarningNoLine{usfmanus}{#1}}
\fi
\def\title#1{\def\@title{{#1}}}
\def\@title{\missingalert{No \noexpand\title given}}
\def\author#1{\def\@author{#1}}
\def\@author{\missingalert{No \noexpand\author given}}
\def\degree#1{\def\@degree{#1}}
\def\@degree{\missingalert{No \noexpand\degree given}}
\def\department#1{\def\@department{#1}}
\def\keywords#1{\def\@keywords{#1}}
\def\@department{\missingalert{No \noexpand\department given}}
\def\college#1{\def\@college{#1}}
\def\@college{\missingalert{No \noexpand\college given}}
\def\graddate#1{\def\@graddate{#1}}
\def\@graddate{\missingalert{No \noexpand\graddate given}}
\def\presentdate#1{\def\@presentdate{#1}}
\def\@presentdate{\missingalert{No \noexpand\presentdate given}}
\def\copyrightyear#1{\def\@copyrightyear{#1}}
\def\@copyrightyear{\missingalert{No \noexpand\copyrightyear given}}
\def\majorprofessor#1{\def\@majorprofessor{#1}}
\def\@majorprofessor{\missingalert{No \noexpand\majorprofessor given}}
\def\majorproftitle#1{\def\@majorproftitle{#1}}
\def\@majorproftitle{\missingalert{No \noexpand\majorproftitle given}}
\def\members#1{\def\@members{#1}}
\def\@members{\missingalert{No \noexpand\members given}}
\long\def\dedication#1{\long\def\@dedication{#1}}
\long\def\acknowledgments#1{\long\def\@acknowledgments{#1}}
\ifvitarequired
  \long\def\vita#1{\long\def\@vita{#1}}
  \def\@vita{\missingalert{\No \noexpand\vita given}}
\fi

\long\def\abstract#1{%
  \long\def\@abstract{#1}}

  %\ifnum\@wordcount>350
\def\@abstract{\missingalert{No \noexpand\abstract given}}



\def\@mylists{\relax}
\def\mylists#1{\def\@mylists{#1}}
\def\makefrontmatter{%
%  \approvalpage
  \titlepage
%  \copyrightpage
  \dedicationpage
  \acknowledgmentspage
  \ifdiss
   \textheight 8.55in%9.0in
  \fi
  \tableofcontents
  \listoftables
  \listoffigures
  \@mylists
  %\abstracttitlepage
  \abstractpage}

%\def\abstractpage{%
%  \newpage
%  \raggedbottom
%  \thispagestyle{plain}
%  \addcontentsline{toc}{chapter}{\abstractname}
%\singlespacing  %\@makeschapterhead{\@title}
%\doublespacing
%  \vspace*{-0.2\baselineskip}
%  %\begin{center}
%  {\centering
%   \vspace*{1.2\baselineskip}
%   \vspace{0.75in}
%   {\bf \abstractname } \\
%   \vspace*{\baselineskip}
%  }
%  %\end{center}
%  \fussy
%  \begin{doublespace}
%    %\noindent
%    \indent
%    \@abstract\nopagebreak\par
%    \raggedbottom
%  \end{doublespace}
%  \raggedbottom}

\def\abstractpage{%
  \clearpage\thispagestyle{myotherheadings}
  \addcontentsline{toc}{chapter}{\abstractname}
  %\null%\vfill
  \begin{center}
  ~\\~\\~\\~\\~\\{\bf \abstractname}~\\~\\
  \end{center}
  \begin{doublespace}
  \@abstract\nopagebreak\par
  \end{doublespace}
  \vfill}

\def\titlepage{%
  \countands{\@majorprofessor}
  \majorcount\andcount
  \advance\majorcount by 1
  \ifnum\majorcount<2 \def\@majorprofname{\majorname}
  \else \def\@majorprofname{\comajorname} \fi
  \countands{\@members}
  \membercount\andcount
  \advance\membercount by 1
  \totalmembers\majorcount
  \advance\totalmembers by \membercount
  \newpage
  %\let\tempheight=\textheight
  %\vsize 10in
  \thispagestyle{empty}
  %\null\vfill
  {\centering%
    ~\\~\\~\\~\\~\\\@title\\~\\~\\~\\
    by\\~\\~\\~\\
    \@author\\~\\~\\~\\~\\~\\
    A \reporttypeshort\ submitted in partial fulfillment\\
    of the requirements for the degree of\\
    \@degree \\
    Department of \@department \\
    College of \@college \\
    University of South Florida\\~\\~\\~\\
    \def\and{\\\@majorprofname:\ }
    \@majorprofname:\ \@majorprofessor
    \def\and{\ \\}\and\@members\\~\\~\\
    Date of Approval: \\
    \@presentdate\\~\\~\\~\\
    Keywords:\ \@keywords \\
   }
   \begin{center}
      \ Copyright\ \copyright ~\@copyrightyear, \@author
   \end{center}
   %\vfill
}

\def\approvalpage{%
  \countands{\@majorprofessor}
  \majorcount\andcount
  \advance\majorcount by 1
  \ifnum\majorcount<2 \def\@majorprofname{\majorname}
  \else \def\@majorprofname{\comajorname} \fi
  \countands{\@members}
  \membercount\andcount
  \advance\membercount by 1
  \totalmembers\majorcount
  \advance\totalmembers by \membercount
  \newpage
  \let\tempheight=\textheight
  \vsize 10in
  \singlespace
  \thispagestyle{empty}
%  \ifnum\totalmembers<6 \vspace*{0.8in}
%  \else \vspace*{0.25in} \fi
  \vspace*{0.06in}
  {\centering%
    Office of Graduate Studies\\ % changed MWP
    University of South Florida\\
    Tampa, Florida \\
    \vspace*{2\baselineskip}
    \hbox to 4.1in{\hfil\shortstack{\vrule width 2.2in height 0.4pt}}
    \vspace{0.15in}
    CERTIFICATE OF APPROVAL \\
    \vspace{0.05in}
    \hbox to 4.1in{\hfil\shortstack{\vrule width 2.2in height 0.4pt}}
    \vspace*{2\baselineskip}
    This is to certify that the \reporttypeshort\ of \\
    \vspace*{2\baselineskip}
    \MakeUppercase{\@author}\\
    \vspace*{2\baselineskip}
    in the graduate degree program of \\ \@department\ \\
    was approved on \@presentdate\\ % updated MWP
    for the \@degree\ degree. \\}
  \vspace*{2\baselineskip}
  \noindent Examining Committee:
  \def\and{\par\hrulefill\\[-0.25\baselineskip]\@majorprofname:\space}
  \begin{list}{}{%
      \topsep
      \ifnum\totalmembers<5 2\baselineskip
      \else 1.5\baselineskip \fi
      \parskip 0pt%
      \parsep
      \ifnum\totalmembers<5 2\baselineskip
      \else 1.5\baselineskip \fi
      \leftmargin 1.25in%
      \rightmargin 1.25in}\item[]%
    \and\@majorprofessor
    \def\and{\par\hrulefill\\[-0.25\baselineskip]\membername:\space}
    \and\@members
    \end{list}
%%% jmin
  \noindent Committee Verification:
  \def\and{\par\hrulefill\\[-0.25\baselineskip]Associate Dean\space}
  \begin{list}{}{%
      \topsep
      1.5\baselineskip
      \parskip 0pt%
      \parsep
      1.5\baselineskip
      \leftmargin 1.25in%
      \rightmargin 1.25in}\item[]%
    \and
    \end{list}
%%%
  \newpage\vsize\tempheight}
\newcount\andcount
\newcount\totalmembers
\newcount\majorcount
\newcount\membercount

\def\countands#1{\andcount=0 \expandafter\countand #1\end}
\def\countand#1{%
  \ifx#1\end%
    \let\next=\relax%
  \else%
    \let\next=\countand%
    \ifx#1\and%
      \advance\andcount by 1%
    \fi%
  \fi%
  \next}

\def\abstracttitlepage{%
  \newpage
  \thispagestyle{myotherheadings}
  \addcontentsline{toc}{chapter}{\abstractname}
  \vspace*{0.8in}
  \vspace*{0.25in}
  {\centering%
    \begin{doublespace}\@title\end{doublespace}
    \vspace*{3\baselineskip}
    by\\
    \vspace*{3\baselineskip}
    \MakeUppercase{\@author}\\
    \vspace*{3\baselineskip}
    \textit{An Abstract}\\
    \vspace*{3\baselineskip}
    of a \reporttypeshort\ submitted in partial fulfillment\\ % updated MWP
    of the requirements for the degree of \\
    \@degree \\
    Department of \@department\\
    College of \@college\\
    University of South Florida \\
    \vspace*{3\baselineskip}
    Date of Approval: \\
    \@presentdate\\
    \vspace*{3\baselineskip}
    \def\and{\\\@majorprofname:\ }
    \@majorprofname:\ \@majorprofessor\\
    \newpage}}%\hspace{0.0ex}}

\newlength{\siglinelength}
\newlength{\@majorproftitlelength}
\newlength{\@majorprofnamelength}
\def\abstractsignatures{%
  \settowidth{\@majorprofnamelength}{\@majorprofname:\ %
    \@majorprofessor}%
  \settowidth{\@majorproftitlelength}{\@majorproftitle \hspace{0.6cm}} % updated MWP
  \ifdim\@majorproftitlelength>\@majorprofnamelength%
  \siglinelength\@majorproftitlelength%
  \else%
  \siglinelength\@majorprofnamelength%
  \fi%
  \noindent\parbox{\textwidth}{%
    \singlespace\vspace*{2\baselineskip}
        % Spacing after signature line reduced v1999.4, HJG.
    Abstract Approved: \hrulefill \vspace*{-0.75\baselineskip}
    \begin{flushright}
      \def\and{\@majorprofname:\ }
      \parbox{\siglinelength}{\and\@majorprofessor \\
        \@majorproftitle
        \\[\baselineskip]
        Date Approved: \hrulefill}
    \end{flushright}}}
\def\copyrightpage{%
  \if@copyrightpage%
  \clearpage
  \thispagestyle{empty}
  \null\vfill
  \vspace*{-0.25in}
  \begin{center}
    \copyright\ Copyright by\ \@author\ \@copyrightyear \\
    All rights reserved
  \end{center}
  \vfill
  \fi}
\def\dedicationpage{%
  \ifx\@dedication\@undefined
  \else
  \clearpage\thispagestyle{empty}
  %\null\vspace{1in}%\vfill
  \begin{center}
  ~\\~\\~\\~\\~\\{\bf DEDICATION}
  \end{center}
  \begin{doublespace}
    \@dedication
  \end{doublespace}
  \vfill
  \fi}
\def\acknowledgmentspage{%
  \ifx\@acknowledgments\@undefined
  \else
  \clearpage\thispagestyle{empty}
  %\null%\vfill
  %\vspace{1in}
  \begin{center}
  ~\\~\\~\\~\\~\\{\bf ACKNOWLEDGMENTS}
  \end{center}
  \begin{doublespace}
  \@acknowledgments
  \end{doublespace}
  \vfill
  \fi}


\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}
\@addtoreset{footnote}{chapter}
\long\def\@makefntext#1{%
    \parindent 1em%
    \noindent
    \hbox to 1.8em{\hss\@makefnmark}#1}

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\newcommand{\pcal}{\@fontswitch{\relax}{\mathcal}}
\newcommand{\pmit}{\@fontswitch{\relax}{\mathnormal}}

\newcommand\contentsname{Table of Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\dedicationname{Dedication}
\newcommand\acknowledgmentsname{Acknowledgements}
\newcommand\figurename{Figure}
\newcommand\figurenamesep{.}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\appendicesname{Appendix}
\newcommand\appendixchaptername{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\newcommand\vitaname{ABOUT THE AUTHOR}
\newcommand\majorname{Major Professor}
\newcommand\comajorname{Co-Major Professor}
\newcommand\membername{Member}

\def\vitapage{ % Vita page layout
  \newpage
  \textheight 9.0in
  \pagestyle{empty}
  \null\vfill
  \vspace*{-1.1in}
  \typeout{\vitaname.}
  \addtocontents{toc}{\protect\contentsline{chapter}%
    {\vitaname}{End Page}}
  \begin{center}
  {\bf ABOUT THE AUTHOR} %added 10/2/2000 MWP
  \end{center}
  \begin{doublespace}
  \hspace{3.25ex}
   \raggedbottom\noindent\@vita
  \end{doublespace}
  \vfill
  \newpage
}

% \AtBeginDocument{
\AfterEndPreamble{
  % next four lines add the sheet numbering to page numbering
  \countdef\c@sheet=1
  \def\thesheet{\@arabic\c@sheet}
  \def\cl@page{\stepcounter{sheet}}
  \setcounter{sheet}{1}
  \if@frontmatter\makefrontmatter\clearpage\fi
  \setcounter{page}{1}
  \def\thepage{\hspace*{\fill}\arabic{page}}
  \raggedbottom}

\AtEndDocument{
  \ifvitarequired \vitapage \fi
}

\endinput
%%
%% End of file `usfmanus.cls'.
