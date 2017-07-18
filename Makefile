.DEFAULT_GOAL := help

PDF := CookBook.pdf
BUILDDIR := _build

help:  ## display this help
	@cat $(MAKEFILE_LIST) | grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' | \
		sort -k1,1 | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: $(PDF)  ## create pdf

%.pdf: %.tex
	mkdir -p $(BUILDDIR)
	pdflatex -output-directory=$(BUILDDIR) -jobname=$* $<
	bibtex $* || true
	pdflatex -output-directory=$(BUILDDIR) -jobname=$* $<

clean:  ## Get rid of pdflatex files
	rm -f *.pdf *.aux *.bbl *.blg *.log *.nav *.out *.snm *.toc
