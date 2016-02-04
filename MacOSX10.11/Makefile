IN = input
OUT = output
TRANS = transforms


all: tables xccdf


xccdf:
#	xsltproc -o $(OUT)/macosx10.11-xccdf.xml $(TRANS)/settings2xccdf.xslt $(OUT)/settings.xml
#	xmllint --format --output $(OUT)/macosx10.11-xccdf.xml $(OUT)/macosx10.11-xccdf.xml
	xsltproc -o $(OUT)/prettyprint.html transforms/xccdf2html.xslt input/settings.xml

tables: 
	xsltproc -o $(OUT)/macosx10.11-table.html $(TRANS)/settings2table.xslt $(IN)/settings.xml
	xsltproc -o $(OUT)/macosx10.11-table-configurable.html --stringparam printonly configurable \
		$(TRANS)/settings2table.xslt $(IN)/settings.xml

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini


