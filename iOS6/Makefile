IN = input
OUT = output
TRANS = transforms


all: shorthand-guide guide 

shorthand-guide:
	xsltproc -o $(OUT)/ios6-shorthand.xml $(IN)/guide.xslt $(IN)/guide.xml
	xmllint --format --output $(OUT)/ios6-shorthand.xml $(OUT)/ios6-shorthand.xml

guide:  
	xsltproc -o $(OUT)/ios6-xccdf.xml $(TRANS)/shorthand2xccdf.xslt $(OUT)/ios6-shorthand.xml
# oscap xccdf generate guide --profile allrules $(OUT)/unlinked-ios6-xccdf-guide.xml > $(OUT)/ios6-guide.html

clean:
	rm -f $(OUT)/*.xml $(OUT)/*.html $(OUT)/*.pdf  $(OUT)/*.tar $(OUT)/*.gz $(OUT)/*.ini

#validate:
#	oscap xccdf validate-xml $(OUT)/unlinked-ios6-xccdf-guide.xml
