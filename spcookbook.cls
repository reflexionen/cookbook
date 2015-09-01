\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{spcookbook}[2015/05/24]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\LoadClass{scrartcl}

% Load Standard Packages
%---------------------------------------------------------------------------
\RequirePackage{color}                          % Color (not xcolor!)
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{eso-pic}
\RequirePackage{graphicx}
\RequirePackage{titling}
  \providecommand{\LenToUnit}[1]{#1\@gobble}
  \newlength{\cwpXoffset}
  \setlength{\cwpXoffset}{-\hoffset-3cm}
  \newlength{\cwpYoffset}
  \setlength{\cwpYoffset}{+2.2cm}
  \newlength{\cwpMaxHeight}
  \setlength{\cwpMaxHeight}{0.4\paperheight}    % Maximale Hoehe des Rezeptbildes
  \newlength{\cwpMaxWidth}
  \setlength{\cwpMaxWidth}{0.4\paperwidth}      % Maximale Breite des Bildes
\usepackage{cmap}           % to make the PDF files "searchable and copyable" in pdf viewer
\usepackage{lmodern}        % skalierbare Schriftfamilie "Latin Modern"
\usepackage{graphicx}       % Einbinden von Grafiken
\usepackage{rotating}       % Text drehen
\usepackage{amsmath}        % Matheumgebung
\usepackage{amssymb}        % Zusatzsymbole zB Square Vartriangle etc
\usepackage{moreverb}       % erweiterte verbatim Umgebung
\usepackage{listings}       % Listings -> Quellcodedarstellung fuer viele verschiedene Sprachen
\usepackage{subfigure}      % Unterbilder
\usepackage{xcolor}         % Farbdefinitionen moeglich
\usepackage{pdfpages}       % Einbinden von PDF Seiten aus PDF Dokument
\usepackage{nicefrac}       % Darstellung eines Bruchs im Fliesstext; Aussehen zB 1/4
\usepackage{acronym}        % Abkuerzungsverzeichnis --> nur verwendete Abkuerzungen listen [printonlyused]
\usepackage{bibgerm}        % deutsches Literaturverzeichnis
\usepackage{caption}        % viele caption Formatierungsmoeglichkeiten
\usepackage{setspace}       % Zeilenabstand festlegen
\usepackage{microtype}      % Verbessert Textsatz
\usepackage{fixltx2e}       % Verbessert einige Kernkompetenzen von LaTeX2e
\usepackage{ellipsis}       % Korrigiert den Weissraum um Auslassungspunkte
\usepackage{units}          % Einheiten komfortabel darstellen
\usepackage{textcomp}       % einige Text-Mode Mathe Symbole, wie zB Mal-Zeichen x (siehe The Comprehensive LaTeX Symbol List)
\usepackage{gensymb}        % celsius, micro, ohm, perthousand, degree in Mathe und Textmodus
\usepackage{ifthen}         % stellt ifthenelse Befehl zur Verfuegung
\usepackage{keyval}         % mehrere optionale Parameter in Befehlen
\usepackage[clock]{ifsym}   % Symbolpackage zB \Interval, \Wecker etc
\usepackage{forloop}        % fuer for-schleifen
%\parindent0cm              % verhindert Absatzeinrueckung
\usepackage{pstricks}       % Einbindung von ps grafiken und pstricks
\usepackage{pst-pdf}        % pstricks und ps grafiken in pdf-latex
\usepackage{float}          % fuer Fliessumgebungen; \begin{figure}[H] -> figure wirklich an dieser Stelle
\restylefloat{figure}
\usepackage{wallpaper}
\usepackage{aurical}
\usepackage{calligra}
\usepackage{yfonts}
\usepackage{uncial}
\usepackage{rustic}
%---------------------------------------------------------------------------

% Definition of Colors
%---------------------------------------------------------------------------
%\definecolor{darkblue}{rgb}{0,0.08,0.45}
\definecolor{darkblue}{rgb}{0,0,.6}
\definecolor{darkgreen}{rgb}{0,.6,0}
\definecolor{darkred}{rgb}{.6,0,0}
%\definecolor{red}{rgb}{0.776,0,0.066}
\definecolor{red}{rgb}{.98,0,0}
\definecolor{brickred}{cmyk}{0,0.89,0.94,0.28}
\definecolor{violet}{rgb}{.61,.125,.95}
\definecolor{darkviolet}{rgb}{.40,0,.70}
\definecolor{ocker}{rgb}{.73,.56,.56}
\definecolor{darkocker}{rgb}{.48,.31,.31}

\definecolor{linkblue}{rgb}{0,0,0.8}            % Blue for the web- and cd-version!
\definecolor{linkblack}{rgb}{0,0,0}             % Black for the print-version!
%---------------------------------------------------------------------------

% Set up page dimension
%---------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{
  left=10mm,
  right=8mm,
  top=10mm,
  bottom=10mm,
}
%---------------------------------------------------------------------------

% hyperref package
%---------------------------------------------------------------------------
\RequirePackage[
  colorlinks=true,
  urlcolor=darkblue,
  linkcolor=darkblue,
  bookmarksopen = {true},
]{hyperref}
%---------------------------------------------------------------------------

% Einstellungen von KOMA-script
%---------------------------------------------------------------------------
\usekomafont{section}
\addtokomafont{section}{
	\newpage
	\centering
	\vspace*{0cm}
	\rmfamily
	\Huge
	\color{\recipecolorset}
}
%---------------------------------------------------------------------------

% Counterdefinitionen
%---------------------------------------------------------------------------
\newcounter{com}        % Steuercounter, erkennt ob verschiedene Befehle schon einmal ausgefuehrt wurden
\newcounter{steps}      % zaehlt die Rezeptschritte
\newcounter{recipes}    % zaehlt die Rezepte
\newcounter{recipepages}
\newcounter{spicect}

\setcounter{recipepages}{1}
\setcounter{recipes}{0}

\setcounter{secnumdepth}{-1}
%---------------------------------------------------------------------------

% Command todo
%---------------------------------------------------------------------------
\newcommand{\todo}[1]
{
  \textcolor{red}
  {
    \textbf{\Large{TODO: }}
    #1
  }
}
%---------------------------------------------------------------------------

% Separator over the whole site
%---------------------------------------------------------------------------
\newcommand\trennstrich
{
  \nopagebreak[4]
  \vskip 1.5ex
  \noindent\makebox[\textwidth]{\rule{4cm}{0.4pt}}
  \vskip 2.5ex
}
%---------------------------------------------------------------------------

% Properties
%---------------------------------------------------------------------------
\newif\ifperson\personfalse         % return true, if count of persons is given
\newif\iftimerecipe\timerecipefalse % return true, if time is given
\newif\ifspice\spicefalse           % return true, if spice is given

% provide count of persons
\newcommand{\person}{0}
\newcommand{\persontext}{Personen}

% provide spice
\newcommand{\spicevariable}{0}
\newcommand{\spicetext}{Sch\"arfe}

\newcommand{\spicepic}[1]{
  \forloop{spicect}{0}{\value{spicect} < #1}%
  {
    \includegraphics[scale=0.40]{Feuer.png}
  }
}

% provide time
\newcommand{\timerec}{0}
\newcommand{\timetext}{Stunden}

% set twosided
\newcommand{\twosided}{\renewcommand{\twosidedbool}{1}}
\newcommand{\twosidedbool}{0}

% recipe title
\newcommand{\recipecolorset}{darkblue}
\newcommand{\recipecolor}[1]{\renewcommand{\recipecolorset}{#1}}
\newcommand{\recipefontset}{\texttt}
\newcommand{\recipefont}[1]{\renewcommand{\recipefontset}{#1}}

% \Version - change with \setVersion
\providecommand{\Version}{Version \today}
\newcommand{\setVersion}[1]{\renewcommand{\Version}{#1}}

% \Titlecolor - change with \setTitlecolor
\providecommand{\Titlecolor}{darkblue}
\newcommand{\setTitlecolor}[1]{\renewcommand{\Titlecolor}{#1}}
%---------------------------------------------------------------------------

% Settings
%---------------------------------------------------------------------------
\newcommand{\personcount}[2][Personen]{\renewcommand{\person}{#2}\persontrue \renewcommand{\persontext}{#1}}
\newcommand{\timerecipe}[2][Stunden]{\renewcommand{\timerec}{#2}\timerecipetrue \renewcommand{\timetext}{#1}}
\newcommand{\spice}[2][\spicetext]{\renewcommand{\spicevariable}{#2}\spicetrue \renewcommand{\spicetext}{#1}}
%---------------------------------------------------------------------------

% other commands
%---------------------------------------------------------------------------
\newcommand{\toc}{1}% beinhaltet bei jedem Rezept den Inhaltsverzeichniseintrag

% Add a recipe picture - parameter is the picture name
\newcommand{\graphic}[1]{
  \end{list}\end{minipage} % beendet die Rezeptbeschreibung

    \AddToShipoutPicture*{\put(\LenToUnit{\cwpXoffset},\LenToUnit{\cwpYoffset}){
      \AtStockLowerLeft{
        \parbox[b]{\paperwidth}{
          \vfill
          \hfill \includegraphics[width=\cwpMaxWidth,height=\cwpMaxHeight,keepaspectratio]{#1}
          \hfill
          \vfill
        }
      }
    }}

  % Steuercounter auf 3 setzen, damit wird gekennzeichnet, dass eine Grafik eingefuegt wurde
  \setcounter{com}{3}
}
%---------------------------------------------------------------------------

% Create a cook step
%---------------------------------------------------------------------------
% beschreibt einen Zubereitungsschritt, Parameter ist der Listenanstrich (default: arabische Zahlen)
% Bsp:  step Hallo  -->  1  Hallo
%   step[10] Hallo  --> 10  Hallo
%   step[] Hallo    -->     Hallo --> wird fuer Tippboxen verwendet
\newcommand{\step}[1][\arabic{steps}]{%
  \ifnum\value{com}=1% Abfrage ob es sich um den ersten Zubereitungsschritt handelt
    %\end{flushright}% Zutatenumgebung muss geschlossen werden
    \end{minipage}%
    %
    \setcounter{com}{2}% Counter auf 2, damit wird gekennzeichnet, dass der Abschnitt Zutaten beendet ist
    \hspace*{0.5cm}% Abstand zwischen Zutaten und Anleitungsteil
    %\addtolength{\textwidth}{-1cm}%
    \begin{minipage}[t]{0.6\textwidth}% Minipage fuer die Zubereitungsschritte wird erzeugt

    \vspace{.5cm}
  \fi%

  \ifnum\value{steps}>1% fuer jeden Schritt existiert eine eigene List-Umgebung - ab dem ersten muss die Liste
    \ifthenelse{\equal{\value{recipepages}}{1}}
      {\end{list}}% hinzufuegen zum Inhaltsverzeichnis
      {\setcounter{recipepages}{1}}%

    %ifnum\value{recipepages}=0%
      %\end{list}% mit dem End-Tag geschlossen werden
    %\fi%
    %\setcounter{recipepages}{0}%
  \fi%
  %
  \begin{list}{% Liste fuer jeden Schritt neu beginnen
    \textcolor{\recipecolorset}{{\huge #1}}% Listenanstrich (Aussehen frei definierbar)
  }%
  \item% Beginn des Zubereitungsschrittes (Listenanstrich)
  \stepcounter{steps}% zaehlt den Zaehler nach oben
}

% umrahmte Box fuer Tipps, Nutzung: \step[]\tippbox{Tipp: Das ist ein Tipp!}
\newcommand{\tippbox}[1]{%
  \vspace{.3cm}
  \fbox{\parbox{0.89\textwidth}{#1}}%
}%

% umrahmte Box fuer Tipps, Nutzung: \step[]\tippboxtip{Tipp: Das ist ein Tipp!}
\newcommand{\tippboxtip}[1]{%
  \vspace{.3cm}
  \fbox{\parbox{0.89\textwidth}{{\normalfont \bfseries Tipp:} #1}}%
}%
%---------------------------------------------------------------------------

% Create a new ingredient
%---------------------------------------------------------------------------
% beschreibt Zutat, Uebergabeparameter ist die Zutatenbeschreibung
\newcommand{\ingredient}[1]{%
  \ifnum\value{com}=0% bei der ersten Zutat muss Umgebung aufgemacht werden (Minipage), Counter ist auf 0
    \begin{minipage}[t]{0.27\textwidth}%
    %\begin{flushright}% rechtsbuendig

    \vspace{.5cm}
    \iftimerecipe% Abfrage, ob Zubereitungszeit angegeben wurde
      \Interval\ \mbox{\timerec} \timetext% \\[0.3cm]% Zubereitungszeit -> \Interval gibt das Symbol an. (siehe Doku Latex Symbole)
      \vspace{.3cm}

    \fi%
    \ifperson%
      Zutaten f\"ur \mbox{\person} \persontext% \\[0.3cm]% Personenanzahl
      \vspace{.4cm}

    \fi%
    \ifspice%
      %\spicetext: \mbox{\spicevariable} \\[0.3cm]% schaerfe mit text beschrieben
      \spicepic{\spicevariable} %\\[0.3cm]% schaerfe mit bildchen
      \vspace{.4cm}

    \fi%
    \setcounter{com}{1}% Counter auf 1 setzen, das heisst Zutatenbereich wurde begonnen
  \fi%
  \hangindent 1em \textit{#1}%\\[.2cm]
  \vspace{.2cm}

  %\underline{\textit{#1}}\\[.2cm]% Zutat kursiv und unterstrichen hinzufuegen
  % underline fuehrt dazu, dass keine zeilenumbrueche mehr gemacht werden!
}

\newcommand{\ingredientpart}[1]{\ingredient{\textbf{#1}}}

\newcommand{\recipenewpage}{%
  \end{list}%
  \end{minipage}%
  \newpage~%
  \setcounter{com}{0}%
  \subsection*{}\vspace*{-0.9cm}
  {\centering\textcolor{recipecolor}{{\recipefontset{\Huge}\\[0.4cm]}}}%
  \ingredient{Fortsetzung:}%
  \setcounter{recipepages}{10}
}
%---------------------------------------------------------------------------

% Environment recipe
%---------------------------------------------------------------------------
% recipe Umgebung, beschreibt ein Rezept, neue Seite fuer jedes Rezept
% 3 optionale Parameter (siehe oben), ein fester Parameter fuer Rezeptueberschrift
\newenvironment{recipe}[4][]{%
  \setcounter{com}{0}% Counter zuruecksetzen
  \setcounter{steps}{1}%
  \addtocounter{recipes}{1}
  \setkeys{recipe}{#1}% einlesen der optionalen Parameter
  \if \twosidedbool 1
    \newpage~
    \ifodd \thepage
    \else
      \newpage~
    \fi
    \subsection*{}\vspace*{-1.9cm}
  \else
    \newpage
    \subsection*{}\vspace*{-0.9cm}
  \fi
  %\newpage~% neue Seite fuer jedes Rezept
  % Name des Rezepts, zentriert, gross, mit Abstand zur Rezeptbeschreibung
  {\begin{center} \textcolor{\recipecolorset}{\recipefontset{\huge #2}}\,\footnote{\ \,Rezeptquelle: #3 \\Fotoquelle: #4}\\[0.9cm]
  \end{center}
  }

  \ifthenelse{\equal{\toc}{1}}% schauen, ob optionaler Name gesetzt
    %{\addcontentsline{toc}{subsection}{\arabic{recipes} #2}}% hinzufuegen zum Inhaltsverzeichnis
    %{\addcontentsline{toc}{subsection}{\arabic{recipes} \toc}}%
    {\addcontentsline{toc}{subsection}{#2}}% hinzufuegen zum Inhaltsverzeichnis
    {\addcontentsline{toc}{subsection}{\toc}}%
}%
{% dieser Teil wird bei \end{recipe} ausgefuehrt
\ifnum\value{com}<3% schauen, ob Rezept ein Bild hat, wenn nicht, dann wird Rezept beendet
  \end{list}\end{minipage}%
  \if \twosidedbool 1
    \ifodd \thepage
      \newpage~
    \fi
  \fi
\fi%


}%
%---------------------------------------------------------------------------

% Titlepage
%---------------------------------------------------------------------------
\newcommand{\Titlepage}{
\begin{titlepage}
  \begin{center}
    \vspace*{3cm}

    \fontsize{50pt}{32pt}\selectfont
    \textcolor{\Titlecolor}{\textbf{\@title}}
    \vspace*{1cm}

    \fontsize{32pt}{30pt}\selectfont
    \@subtitle

    \vspace*{4cm}
    \fontsize{15pt}{32pt}\selectfont
    \copyright~\@date~\@author \\
    \Version
  \end{center}
\end{titlepage}}
%---------------------------------------------------------------------------

% Einheiten
%---------------------------------------------------------------------------
\newcommand{\g}{\,g }
\newcommand{\kg}{\,kg }
\newcommand{\ml}{\,ml }
\newcommand{\cl}{\,cl }
\newcommand{\dl}{\,dl }
\renewcommand{\l}{\,l }
\newcommand{\TL}{\,TL }
\newcommand{\EL}{\,EL }
\newcommand{\cm}{\,cm }
\newcommand{\m}{\,m }
\renewcommand{\min}{\,min }
\newcommand{\pkg}{\,P\"ackchen }
%---------------------------------------------------------------------------

% Abkuerzungen
%---------------------------------------------------------------------------
\newcommand{\bzw}{bzw.\@\xspace}
\newcommand{\bzgl}{bzgl.\@\xspace}
\newcommand{\ca}{ca.\@\xspace}
\newcommand{\dah}{d.\thinspace{}h.\@\xspace}
\newcommand{\Dah}{D.\thinspace{}h.\@\xspace}
\newcommand{\ds}{d.\thinspace{}sind\@\xspace}
\newcommand{\evtl}{evtl.\@\xspace}
\newcommand{\ua}{u.\thinspace{}a.\@\xspace}
\newcommand{\Ua}{U.\thinspace{}a.\@\xspace}
\newcommand{\usw}{usw.\@\xspace}
\newcommand{\va}{vor allem\@\xspace}
\newcommand{\vgl}{vgl.\@\xspace}
\newcommand{\zB}{z.\thinspace{}B.\@\xspace}
\newcommand{\ZB}{Zum Beispiel\xspace}
\newcommand{\sa}{s.\ auch\@\xspace}
\newcommand{\ia}{i.\thinspace{}Allg.\@\xspace}
\newcommand{\su}{s.\ unten\@\xspace}
\newcommand{\uvm}{u.\thinspace{}v.\thinspace{}m.\@\xspace}
\newcommand{\uva}{u.\thinspace{}v.\thinspace{}a.\@\xspace}
%---------------------------------------------------------------------------
