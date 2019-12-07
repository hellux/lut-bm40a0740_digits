.SUFFIXES: .pdf .tex

OBJDIR = build
FIGDIR = ${OBJDIR}/fig
AUX = .aux .log .toc .fls .fdb_latexmk .bbl .blg .out .lof .lot .bcf .run.xml

LMKOPTS = -pdf -output-directory=${OBJDIR}
LATEXMK = ${LMKVARS} latexmk ${LMKOPTS}

report: plot_rasterized plot_scaled doc/report.pdf

plot_rasterized: doc/generate/rasterized.m 
	mkdir -p ${FIGDIR}
	octave $<
plot_scaled: doc/generate/scaled.m
	mkdir -p ${FIGDIR}
	octave $<

.tex.pdf:
	${LATEXMK} $<

clean:
	for ft in ${AUX}; do rm -rf $$(find . -name "*$$ft"); done

distclean:
	rm -rf ${OBJDIR}
