IN = input
OUT = output
TRANS = transforms


all: xccdf tables

shorthand:
	xsltproc -o $(OUT)/ios6-shorthand.xml $(IN)/guide.xslt $(IN)/guide.xml
	xmllint --format --output $(OUT)/ios6-shorthand.xml $(OUT)/ios6-shorthand.xml

xccdf: shorthand
	xsltproc -o $(OUT)/ios6-xccdf.xml $(TRANS)/shorthand2xccdf.xslt $(OUT)/ios6-shorthand.xml
	xsltproc -stringparam profile "allprofiles" -o $(OUT)/ios6-xccdf.xml \
		$(TRANS)/xccdf-addprofiles.xslt $(OUT)/ios6-xccdf.xml

tables: xccdf
	xsltproc -stringparam profile "enterprise" -o $(OUT)/table-ios6-enterprise.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios6-xccdf.xml
	xsltproc -stringparam profile "byod" -o $(OUT)/table-ios6-byod.html \
        $(TRANS)/xccdf2table-profilenistrefs.xslt $(OUT)/ios6-xccdf.xml

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini

# targets below work if OpenSCAP is installed
guide: xccdf
	oscap xccdf generate guide --profile allrules $(OUT)/ios6-xccdf.xml > $(OUT)/ios6-guide.html

validate:
	oscap xccdf validate-xml $(OUT)/ios6-xccdf.xml
