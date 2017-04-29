<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Initializing file names that we will use to load data. -->
	<xsl:param name="names_file" select="document('./names.xml')"/>

	<xsl:param name="papers_data" select="document('./dblp_ii.xml')"/>

	<xsl:template name="main">

		<!-- Creating homepage document. -->
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
						<!-- For each person/name from file create page and make their official page.  -->

						<xsl:apply-templates select="$names_file/names"/>
					</table>
				</body>
			</html>

		</xsl:result-document>

		<!-- Find names from all conferences and journals. -->
		<xsl:variable name="publisher" select="distinct-values(for $a in distinct-values($papers_data/descendant::node()/@key)
		return (substring-before(substring-after($a, '/'), '/'))
		)"/>

		<!-- For each publisher create page with all papers. -->
		<xsl:for-each select="$publisher">

			<xsl:variable name="publisher_name" select="."/>

			<xsl:result-document method="html" href="{concat('output/', $publisher_name, '.html')}">
				<html lang="en">
					<head>
						<meta charset="UTF-8"/>
						<title>Published info</title>
					</head>
					<body>
						<h2>All publication from

							<xsl:value-of select="$publisher_name"/></h2>
						<table border="1">
							<tr bgcolor="#9acd32">
								<th>Title</th>
								<th>Date</th>
							</tr>
							<!-- From all data from papers_data find all papers publish in current jurnal/conference and sort it by date.  -->
							<!-- We could use template but then data wouldn't be sorted. -->

							<xsl:for-each select="$papers_data/descendant::node()[substring-before(substring-after(@key, '/'), '/') = $publisher_name]">

								<xsl:sort select="@mdate"/>
								<tr>
									<td>
										<a href="{ee}"><xsl:value-of select="title"/></a>
									</td>
									<td><xsl:value-of select="@mdate"/></td>
								</tr>
							</xsl:for-each>
						</table>
					</body>
				</html>
			</xsl:result-document>
		</xsl:for-each>

	</xsl:template>

	<xsl:template match="name">
		<!-- Name of file containg info page for ii personal is name_surname.html -->

		<xsl:variable name="link" select="concat(lower-case(translate(., ' ', '_')), '.html')"/>
		<!-- Fill table from landing (first) page with person name. -->

		<xsl:variable name="name" select="."/>
		<tr>
			<td><xsl:value-of select="."/></td>
			<td><xsl:value-of select="count($papers_data//author[. = $name])"/></td>
			<td>
				<a href="{$link}"><xsl:value-of select="$link"/></a>
			</td>
		</tr>
		<!-- Create unique page for every employee and put it in output file. -->

		<xsl:result-document method="html" href="{concat('output/', $link)}">

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
						<!-- Find all papers in which current person participate and add that paper to table. -->

						<xsl:for-each select="$papers_data/descendant::node()[./author = $name]">

							<xsl:sort select="year"/>
							<tr>

								<xsl:variable name="url" select="ee"/>
								<td>
									<a href="{$url}"><xsl:value-of select="title"/></a>
								</td>
								<td>
									<ul>
										<!-- Find all coauthors and add them to table. -->

										<xsl:for-each select="author">
											<!-- Check if current coauthor is the same as person whose page we are creating. If same don't put him on list.  -->

											<xsl:if test=". != $name">

												<xsl:variable name="coauthor" select="."/>
												<!-- Check if current coauthor is employee of Instytut Informatyki, if yes add link to his page. -->

												<xsl:if test="count($names_file//name[. = $coauthor]) &gt; 0">

													<li>
														<a href="{concat(lower-case(translate(., ' ', '_')), '.html')}"><xsl:value-of select="."/></a>
													</li>
												</xsl:if>
												<!-- If coauthor isn't employee of Instytut Informatyki put just his name (no link). -->

												<xsl:if test="count($names_file//name[. = $coauthor]) &lt; 1">
													<li><xsl:value-of select="."/></li>
												</xsl:if>
											</xsl:if>

										</xsl:for-each>
									</ul>
								</td>
								<td><xsl:value-of select="year"/></td>

								<!-- If paper is from article put jurnal name. -->
								<xsl:if test="name() = 'article'">
									<td>
										<a href="{concat(substring-before(substring-after(@key, '/'), '/'), '.html')}"><xsl:value-of select="journal"/></a>
									</td>
								</xsl:if>
								<!-- If paper is from conference get conference name. -->

								<xsl:if test="name() = 'inproceedings'">

									<xsl:variable name="conf_name" select="substring-before(substring-after(@key, '/'), '/')"/>
									<td>
										<a href="{concat($conf_name, '.html')}"><xsl:value-of select="$conf_name"/></a>
									</td>
								</xsl:if>
							</tr>
						</xsl:for-each>

					</table>
				</body>
			</html>
		</xsl:result-document>

	</xsl:template>

</xsl:stylesheet>
