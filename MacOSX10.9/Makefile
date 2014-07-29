IN = input
OUT = output
TRANS = transforms


all: tables


xccdf:
	xsltproc -o $(OUT)/macosx10.9-xccdf.xml $(TRANS)/settings2xccdf.xslt $(OUT)/settings.xml
	xmllint --format --output $(OUT)/macosx10.9-xccdf.xml $(OUT)/macosx10.9-xccdf.xml

tables: 
	xsltproc -o $(OUT)/macosx10.9-table.html $(TRANS)/settings2table.xslt $(IN)/settings.xml

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini


