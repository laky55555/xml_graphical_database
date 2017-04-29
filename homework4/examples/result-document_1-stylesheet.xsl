<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:template match="/">
   <xsl:for-each select="products/product">
	 <xsl:result-document method="xml" href="product_{@id}-output.xml">
	   <xsl:copy-of select="."/>
	 </xsl:result-document>
   </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>
