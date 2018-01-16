all: html pdf-staging

html:
	pandoc -c style.css --standalone --from markdown --to html+simple_tables -o resume.html resume.md

live:
	ls * | entr make html

pdf-staging:
	pandoc -c style.pdf.css --standalone --from markdown --to html+simple_tables -o resume.pdf.html resume.md

# Manually print/generate from browser to remove header/footer
# TODO https://www.npmjs.com/package/simple-headless-chrome#printtopdf displayHeaderFooter=false
#   or https://github.com/GoogleChrome/puppeteer
pdf: pdf-staging
	$(chrome-bin) \
	--headless \
	--displayHeaderFooter=false \
	--print-to-pdf=$(dst) \
	$(src)

# e.g.
# make live-pdf \
#   chrome-bin='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome' \
#   src=file://$(pwd)/resume.pdf.html \
#   dst=$(pwd)/resume.2.pdf
live-pdf:
	ls * | entr make pdf
