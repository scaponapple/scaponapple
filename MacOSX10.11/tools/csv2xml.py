#!/usr/bin/python

#Read in CSV data and write to XML file

import csv, os, sys



def xml_encode(input):
	output = str.replace(input, '&', '&amp;')
	output = str.replace(output, '>', '&gt;')
	output = str.replace(output, '<', '&lt;')
	output = str.replace(output, '\n', '<p/>')
	return output



#Files to read and write
csvFile = sys.argv[1]

header = '''<?xml version="1.0"?>
<Benchmark xmlns="http://checklists.nist.gov/xccdf/1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/elements/1.1/" id="MacOSX10.11">
<status date="2016-02-02">draft</status>
  <title>DoD Consensus Settings for Mac OS X 10.11</title>
  <description>These security settings for Mac OS X 10.11
  were developed by the DoD Joint Consensus Working Group.
  </description>
  <!-- Many of the XCCDF elements used here 
       are not used in the manner originally intended by
       the XCCDF specification; 
       this is a result of the SRG-based process,
       which mixes requirements about security functionality
       with requirements for security configuration. -->
'''

#Open files for reading and writing
#Set parameters for reader
csvData = csv.reader(open(csvFile, 'r'), delimiter=',', quotechar='"')

#Write initial XML header information to file
sys.stdout.write(header)

severity_from_cat = {'CAT I': 'high', 'CAT II': 'medium', 'CAT III': 'low', '': ''} 

first=1
#iterate over csv file, skipping first row
for row in csvData:
	if first:
		first=0
		continue
	#Begin writing each row of content
	# NIST (0), SRGID (1), STIGID (2), Requirement(3), Title(4), Severity(5), Discussion(6), Check(7), Fix(8), CCI ID(9)
	print '<Rule severity="' + str(severity_from_cat[row[5]])+ '" id="' + row[4] + '">'
	print '<title>' + row[4] + '</title>'
	print '<description>' + xml_encode(row[8]) + '</description>'
	print '<reference href="http://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r4.pdf">' + row[0] + '</reference>'
	print '<reference href="http://iase.disa.mil/cci/index.html">' + row[9][4:] + '</reference>'
	print '<ident srgid="' + row[1] + '" />'
	print '<status>' + 'Applicable - Configurable' + '</status>'
	print '<check system="ocil-transitional"><check-content>' + xml_encode(row[7]) + '</check-content></check>'
	print '<rationale>' + xml_encode(row[6]) + '</rationale>'
	print '</Rule>\n'

sys.stdout.write('</Benchmark>')



