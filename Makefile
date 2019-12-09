.SUFFIXES: .pdf .tex

OBJDIR = build
FIGDIR = ${OBJDIR}/fig
AUX = .aux .log .toc .fls .fdb_latexmk .bbl .blg .out .lof .lot .bcf .run.xml

LMKOPTS = -pdf -output-directory=${OBJDIR}
LATEXMK = ${LMKVARS} latexmk ${LMKOPTS}

STNUM = stnum

report: plots doc/report.pdf

network.mat:
	octave src/scripts/create_classifier.m
test_run:
	octave src/scripts/run_classifier.m

zip: report network.mat
	rm -rf ${OBJDIR}/${STNUM}
	mkdir -p ${OBJDIR}/${STNUM}
	cp -r src ${OBJDIR}/${STNUM}
	cp -r training_data/ ${OBJDIR}/${STNUM}/
	cp readme.md ${OBJDIR}/${STNUM}/
	cp network.mat ${OBJDIR}/${STNUM}/
	cp digit_classify.m ${OBJDIR}/${STNUM}/
	cp ${OBJDIR}/report.pdf ${OBJDIR}/${STNUM}
	cd ${OBJDIR} && zip -r ${STNUM}.zip ${STNUM}

plots: plot_scaled plot_rasterized plot_incorrect network.mat
plot_scaled: doc/generate/scaled.m
	mkdir -p ${FIGDIR}
	octave $<
plot_rasterized: doc/generate/rasterized.m
	mkdir -p ${FIGDIR}
	octave $<
plot_incorrect: doc/generate/incorrect.m
	mkdir -p ${FIGDIR}
	octave $<

.tex.pdf:
	${LATEXMK} $<

clean:
	for ft in ${AUX}; do rm -rf $$(find . -name "*$$ft"); done

distclean:
	rm -rf ${OBJDIR}
