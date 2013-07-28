<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xccdf="http://checklists.nist.gov/xccdf/1.1" xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <!-- this operates on a pre-XCCDF document that is free of namespaces -->

  <xsl:template match="Benchmark/version">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:copy-of select="node()" />
    </xsl:copy>
    <xsl:if test="'allprofiles'=$profile">
          <xsl:apply-templates select="document('../input/profiles/byod.xml')" />
          <xsl:apply-templates select="document('../input/profiles/enterprise.xml')" />
    </xsl:if>
  </xsl:template>

  <!-- add attribute selected=false so that Profiles
       can activate Rules as needed -->
  <xsl:template match="Rule">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
      <xsl:attribute name="selected">false</xsl:attribute>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>


  <!-- copy everything else through to final output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
