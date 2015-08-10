all: html pdf-staging

html:
	pandoc -c style.css --standalone --from markdown --to html+simple_tables -o resume.html resume.md

live:
	ls * | entr make html

pdf-staging:
	pandoc -c style.pdf.css --standalone --from markdown --to html+simple_tables -o resume.pdf.html resume.md
