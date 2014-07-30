<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cdf="http://checklists.nist.gov/xccdf/1.1" xmlns:xhtml="http://www.w3.org/1999/xhtml">


<xsl:include href="constants.xslt"/>
<xsl:include href="table-style.xslt"/>

<xsl:param name="printonly" select="''"/>

	<xsl:template match="/">
		<html>
		<head>
			<title><xsl:value-of select="/cdf:Benchmark/cdf:title" /></title>
		</head>
		<body>
			<div class="tabletitle">
			<xsl:value-of select="/cdf:Benchmark/cdf:title" />
			</div>
			<!-- <xsl:value-of select="/cdf:Benchmark/cdf:description" /> -->
			<xsl:apply-templates select="cdf:Benchmark"/>
		</body>
		</html>
	</xsl:template>


	<xsl:template match="cdf:Benchmark">
		<xsl:call-template name="table-style" />
		<table>
			<thead>
				<td>NIST<p/>Control</td>
				<td>CCI</td>
				<td>SRGID</td>
				<td>Requirement</td>
				<td>VulDiscussion</td>
				<td>Status</td>
				<td>Check</td>
				<td>Fix</td>
				<td>Severity</td>
			</thead>

		<xsl:apply-templates select="//cdf:Rule" /> 

		</table>
	</xsl:template>


	<xsl:template match="cdf:Rule">
		<xsl:if test="(cdf:status='Applicable - Configurable' and $printonly='configurable') or $printonly=''">
		<tr>
			<td> <xsl:value-of select="cdf:ident/@nist" /></td>
			<td> <xsl:value-of select="cdf:ident/@cci" /></td>
			<td> <xsl:value-of select="cdf:ident/@srgid" /></td>
			<td> <xsl:apply-templates select="cdf:description"/> </td>
			<td> <xsl:apply-templates select="cdf:rationale"/> </td>
			<td> <xsl:apply-templates select="cdf:status"/> </td>
			<td> <xsl:apply-templates select="cdf:check"/> </td>
			<td> <xsl:apply-templates select="cdf:fixtext"/> </td>
			<td> <xsl:value-of select="@severity" /></td>
		</tr>
		</xsl:if>
	</xsl:template>


	<!-- getting rid of XHTML namespace -->
	<xsl:template match="xhtml:*">
		<xsl:element name="{local-name()}">
 			<xsl:apply-templates select="node()|@*"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cdf:description">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>

	<xsl:template match="cdf:rationale">
		<xsl:apply-templates select="@*|node()" />
	</xsl:template>

</xsl:stylesheet>
