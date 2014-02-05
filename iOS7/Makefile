IN = input
OUT = output
TRANS = transforms


all: xccdf tables guide

shorthand:
	xsltproc -o $(OUT)/ios7-shorthand.xml $(IN)/guide.xslt $(IN)/guide.xml
	xmllint --format --output $(OUT)/ios7-shorthand.xml $(OUT)/ios7-shorthand.xml

xccdf: shorthand
	xsltproc -o $(OUT)/ios7-xccdf.xml $(TRANS)/shorthand2xccdf.xslt $(OUT)/ios7-shorthand.xml
	xmllint --format --output $(OUT)/ios7-xccdf.xml $(OUT)/ios7-xccdf.xml

tables: xccdf
	xsltproc -stringparam profile "enterprise" -o $(OUT)/table-ios7-enterprise.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios7-xccdf.xml
	xsltproc -stringparam profile "byod" -o $(OUT)/table-ios7-byod.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios7-xccdf.xml

guide: xccdf
	xsltproc -o $(OUT)/ios7-guide.html $(TRANS)/xccdf2html.xslt $(OUT)/ios7-xccdf.xml

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini


# targets below work if OpenSCAP is installed
validate:
	oscap xccdf validate-xml $(OUT)/ios7-xccdf.xml
