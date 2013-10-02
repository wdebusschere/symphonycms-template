<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="create-page-url">
	<xsl:param name="page" />
	<xsl:call-template name="create-page-url-by-id">
		<xsl:with-param name="id" select="$page/page/@id" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="create-page-url-by-id">
	<xsl:param name="id" />
	<xsl:apply-templates select="/data/pages//page [@id = $id]" mode="url" />
</xsl:template>

<xsl:template match="page" mode="url">
	<xsl:param name="url" />
	<xsl:choose>
		<xsl:when test="count(./parent::page) &gt; 0">
			<xsl:apply-templates select="./parent::page" mode="url" >
				<xsl:with-param name="url">
					<!--xsl:value-of select="item [@lang = $url-language]/@handle" />/<xsl:value-of select="$url" /-->
					<xsl:value-of select="$url" />
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:when>
		<xsl:otherwise>
			<!--xsl:text>/</xsl:text><xsl:value-of select="$url-language" />/<xsl:value-of select="item [@lang = $url-language]/@handle" />/<xsl:value-of select="$url" /-->
			<xsl:text>/</xsl:text><xsl:value-of select="@handle" />/<xsl:value-of select="$url" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>