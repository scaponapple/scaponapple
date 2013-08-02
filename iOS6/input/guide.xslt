<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xccdf="http://checklists.nist.gov/xccdf/1.1" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:dc="http://purl.org/dc/elements/1.1/">

<!-- This transform assembles all fragments into one "shorthand" XCCDF document -->

  <xsl:template match="Benchmark">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />

       <!-- add profiles -->
       <xsl:apply-templates select="document('profiles/byod.xml')" />
       <xsl:apply-templates select="document('profiles/enterprise.xml')" /> 
       <Value id="conditional_clause" type="string" operator="equals">
                 <title>A conditional clause for check statements.</title>
                 <description>A conditional clause for check statements.</description>
                 <value>This is a placeholder.</value>
       </Value>

       <!-- add toplevel sections -->
      <xsl:apply-templates select="document('intro/intro.xml')" />
      <xsl:apply-templates select="document('deployment/deployment.xml')" />
      <xsl:apply-templates select="document('settings/settings.xml')" />
      <xsl:apply-templates select="document('handling/handling.xml')" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='deployment']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('deployment/mdm-overview.xml')" />
       <xsl:apply-templates select="document('deployment/profiles.xml')" />
   </xsl:copy>
  </xsl:template>

  <xsl:template match="Group[@id='settings']">
    <xsl:copy>
      <xsl:copy-of select="@*|node()" />
      <xsl:apply-templates select="document('settings/deployable/passcode.xml')" />
      <xsl:apply-templates select="document('settings/deployable/restrictions.xml')" />
      <xsl:apply-templates select="document('settings/deployable/wifi.xml')" />
      <xsl:apply-templates select="document('settings/deployable/vpn.xml')" />
      <xsl:apply-templates select="document('settings/deployable/email.xml')" />
      <xsl:apply-templates select="document('settings/deployable/activesync.xml')" />
      <xsl:apply-templates select="document('settings/deployable/ldap.xml')" />
      <xsl:apply-templates select="document('settings/deployable/webdav.xml')" />
      <xsl:apply-templates select="document('settings/deployable/certs.xml')" />
      <xsl:apply-templates select="document('settings/deployable/mdm-settings.xml')" />
      <xsl:apply-templates select="document('settings/manual/restrictions-man.xml')" />
   </xsl:copy>
  </xsl:template>


  <!-- copy everything else through to final output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
