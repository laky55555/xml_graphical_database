<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="file1" select="document('./names.xml')"/>
	<xsl:param name="file2" select="document('./dblp_ii.xml')"/>

	<xsl:template name="main">

		<xsl:result-document method="html" href="output/index.html">

			<html lang="en">
				<head>
					<meta charset="UTF-8"/>
				    <title>Instytut Informatyki</title>
				</head>
			    <body>
			    <h2>Table of employees</h2>
			    <table border="1">
		    		<tr bgcolor="#9acd32">
						<th>Name</th>
						<th>Number of publications</th>
						<th>Link to publications</th>
					</tr>
					<xsl:apply-templates select="$file1/names"/>
			 		<!-- <xsl:for-each select="$file1//name">
						<tr>
							<xsl:variable name="link" select="concat(lower-case(translate(., ' ', '_')), '.html')" />
							<xsl:variable name="name" select="." />
							<td><xsl:value-of select="."/></td>
							<td><xsl:value-of select="count($file2//author[. = $name])"/></td>
							<td><a href="{$link}"><xsl:value-of select="$link"/></a></td>
						</tr>
						<xsl:result-document method="html" href="section{position()}">
							<xsl:copy-of select="."/>
						</xsl:result-document>
					</xsl:for-each> -->
			    </table>
		    	</body>
		    </html>

		</xsl:result-document>


		<xsl:variable name="publisher" select="distinct-values(for $a in distinct-values($file2/descendant::node()/@key)
		return (substring-before(substring-after($a, '/'), '/'))
		)" />
		<xsl:for-each select="$publisher">
			<xsl:variable name="publisher_name" select="." />
			<xsl:result-document method="html" href="{concat('output/', ., '.html')}">
				<html lang="en">
					<head>
						<meta charset="UTF-8"/>
					    <title>Published info</title>
					</head>
				    <body>
				    <h2>All publication from <xsl:value-of select="$publisher_name"/></h2>
				    <table border="1">
			    		<tr bgcolor="#9acd32">
							<th>Title</th>
							<th>Date</th>
						</tr>
						<!-- <xsl:apply-templates select="$file2/descendant::node()[substring-before(substring-after(@key, '/'), '/') = $publisher_name]"/> -->
						<xsl:for-each select="$file2/descendant::node()[substring-before(substring-after(@key, '/'), '/') = $publisher_name]">
							<xsl:sort select="@mdate"/>
							<tr>
								<td><a href="{ee}"><xsl:value-of select="title"/></a></td>
								<td><xsl:value-of select="@mdate"/></td>
							</tr>
						</xsl:for-each>
					</table>
			    	</body>
			    </html>
			</xsl:result-document>
		</xsl:for-each>

	</xsl:template>

<xsl:template match="article | inproceedings">
	<tr>
		<td><a href="{ee}"><xsl:value-of select="title"/></a></td>
		<td><xsl:value-of select="@mdate"/></td>
	</tr>
</xsl:template>

<xsl:template match="name">
	<xsl:variable name="link" select="concat(lower-case(translate(., ' ', '_')), '.html')" />
	<xsl:variable name="link2" select="concat('output/', lower-case(translate(., ' ', '_')), '.html')" />
	<xsl:variable name="name" select="." />
	<tr>
		<td><xsl:value-of select="."/></td>
		<td><xsl:value-of select="count($file2//author[. = $name])"/></td>
		<td><a href="{$link}"><xsl:value-of select="$link"/></a></td>
	</tr>

	<xsl:result-document method="html" href="{$link2}">

		<html lang="en">
			<head>
				<meta charset="UTF-8"/>
			    <title>Employee</title>
			</head>
			<body>
			<h1><xsl:value-of select="$name"/></h1>
			<h4>Table of publications</h4>
			<table border="1">
				<tr bgcolor="#9acd32">
					<th>Title</th>
					<th>Co authors</th>
					<th>Year</th>
					<th>conference/journal</th>
				</tr>
				<!-- <xsl:apply-templates select="$file2/descendant::node()[./author = $name]"/> -->
				<xsl:for-each select="$file2/descendant::node()[./author = $name]">
					<xsl:sort select="year"/>
					<tr>
						<xsl:variable name="url" select="ee" />
						<td><a href="{$url}"><xsl:value-of select="title"/></a></td>
						<td><ul>
							<xsl:for-each select="author">
								<xsl:if test=". != $name">

								<xsl:variable name="coauthor" select="." />
								<xsl:if test="count($file1//name[. = $coauthor]) &gt; 0">
									<xsl:variable name="link" select="concat(lower-case(translate(., ' ', '_')), '.html')" />
									<li><a href="{$link}"><xsl:value-of select="."/></a></li>
								</xsl:if>
								<xsl:if test="count($file1//name[. = $coauthor]) &lt; 1">
									<li><xsl:value-of select="."/></li>
								</xsl:if>
							</xsl:if>

							</xsl:for-each>
						</ul></td>
						<td><xsl:value-of select="year"/></td>
						<xsl:if test="name() = 'article'">
							<td><a href="{concat(substring-before(substring-after(@key, '/'), '/'), '.html')}"><xsl:value-of select="journal"/></a></td>
						</xsl:if>
						<xsl:if test="name() = 'inproceedings'">
							<xsl:variable name="conf_name" select="substring-before(substring-after(@key, '/'), '/')" />
							<td><a href="{concat($conf_name, '.html')}"><xsl:value-of select="$conf_name"/></a></td>
						</xsl:if>
						<!-- <xsl:variable name="coauthor" select="." /> -->
					</tr>
				</xsl:for-each>

			</table>
			</body>
		</html>
	</xsl:result-document>

</xsl:template>

<!-- <xsl:template match="inproceedings">
<xsl:template match="article | inproceedings">
	<tr>
		<xsl:variable name="url" select="ee" />
		<td><a href="{$url}"><xsl:value-of select="title"/></a></td>
		<td><ul><li><xsl:value-of select="year"/></li></ul></td>
		<td><xsl:value-of select="year"/></td>
		<td><xsl:value-of select="crossref|journal|booktitle"/></td>
	</tr>
</xsl:template> -->


</xsl:stylesheet>
