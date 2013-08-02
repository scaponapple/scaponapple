IN = input
OUT = output
TRANS = transforms


all: xccdf tables guide

shorthand:
	xsltproc -o $(OUT)/ios6-shorthand.xml $(IN)/guide.xslt $(IN)/guide.xml
	xmllint --format --output $(OUT)/ios6-shorthand.xml $(OUT)/ios6-shorthand.xml

xccdf: shorthand
	xsltproc -o $(OUT)/ios6-xccdf.xml $(TRANS)/shorthand2xccdf.xslt $(OUT)/ios6-shorthand.xml
	xmllint --format --output $(OUT)/ios6-xccdf.xml $(OUT)/ios6-xccdf.xml

tables: xccdf
	xsltproc -stringparam profile "enterprise" -o $(OUT)/table-ios6-enterprise.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios6-xccdf.xml
	xsltproc -stringparam profile "byod" -o $(OUT)/table-ios6-byod.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios6-xccdf.xml

guide: xccdf
	xsltproc -o $(OUT)/ios6-guide.html $(TRANS)/xccdf2html.xslt $(OUT)/ios6-xccdf.xml

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini


# targets below work if OpenSCAP is installed
validate:
	oscap xccdf validate-xml $(OUT)/ios6-xccdf.xml
