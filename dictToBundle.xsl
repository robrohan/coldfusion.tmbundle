<?xml version="1.0" encoding="UTF-8" ?>
<!--
	dictToBundle
	Created by Rob Rohan on 2008-11-22.
	Copyright (c) 2008-2009 Rob Rohan. All rights reserved.
-->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:dic="http://www.cfeclipse.org/version1/dictionary"
	xmlns:util="java:java.util.UUID"
	version="2.0"
	exclude-result-prefixes="xsl dic util">
	
	<xsl:output method="xml" indent="yes" />
	<xsl:output method="xml" indent="yes" name="plistxml" 
		exclude-result-prefixes="xsl dic util" />
	
	<!-- <xsl:param name="bundle-dir" select="'ColdFusion.bun'" /> -->
	
	<xsl:variable name="NL">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	
	<xsl:template match="/">
		<!--
		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"> -->
		<plist version="1.0">
		<dict>
			<key>contactEmailRot13</key>
			<string>ebo@qnrzba.pbz.nh</string>

			<key>contactName</key>
			<string>Rob Rohan</string>

			<key>description</key>
			<string>Support for the ColdFusion web development environment.</string>

			<key>mainMenu</key>
			<dict>
				<key>items</key>
				<array>
					<string>C8F9D7A6-D447-4C16-B566-BE46335B1067</string>
					<string>1202B1E1-6A18-4C9E-AB30-70A0E046CDB7</string>
					<string>------------------------------------</string>
					<string>59075941-A690-46FC-BFA6-58B81E1B18B0</string>
					<string>0CA09D51-8DE8-48A0-A178-02D7D8285802</string>
					<string>1519328F-1308-4DC8-9E71-2B7473F9080F</string>
				</array>
				
				<key>submenus</key>
				<dict>
					<key>1202B1E1-6A18-4C9E-AB30-70A0E046CDB7</key>
					<dict>
						<key>items</key>
						<array>
							<xsl:comment>FUNCTIONS</xsl:comment><xsl:value-of select="$NL" />
							<xsl:apply-templates select="/dic:dictionary/dic:functions/dic:function" />
						</array>
						<key>name</key>
						<string>ColdFusion Functions</string>
					</dict>
					<key>C8F9D7A6-D447-4C16-B566-BE46335B1067</key>
					<dict>
						<key>items</key>
						<array>
							<xsl:comment>TAGS</xsl:comment><xsl:value-of select="$NL" />
							<xsl:apply-templates select="/dic:dictionary/dic:tags/dic:tag" />
						</array>
						<key>name</key>
						<string>ColdFusion Tags</string>
					</dict>
				</dict>
			</dict>
			
			<key>name</key>
			<string>ColdFusion</string>
			
			<key>ordering</key>
			<array>
				<!-- <string>00D00AD7-3C05-46E0-B8B9-0F5CCAC04F57</string>
				<string>904C79F1-5730-4D8D-986A-0D71587B2C1F</string> -->
			</array>

			<key>uuid</key>
			<string>1A09BE0B-E81A-4CB7-AF69-AFC845162D1F</string>
		</dict>
		</plist>
	</xsl:template>
	
	<!-- Formats the functions. Writes the plist too. -->
	<xsl:template match="dic:function">
		<xsl:variable name="filename" select="translate(@name,':','-')" />
		
		<xsl:variable name="uid" select="util:randomUUID()"/>
		<string><xsl:value-of select="util:toString($uid)"/></string>
		<xsl:value-of select="$NL" />
		
		<!-- {$bundle-dir}/ -->
		<xsl:result-document 
			href="Snippets/gen-{$filename}.tmSnippet" format="plistxml">
			<!-- <xsl:text><!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"></xsl:text> -->
			<plist version="1.0">
			<dict>
				<key>content</key>
				<string><xsl:value-of select="@name" />
					<xsl:text>(${1:</xsl:text>
					<xsl:for-each select="./dic:parameter">
						<xsl:call-template name="param-with-placement">
							<xsl:with-param name="placement" select="position()+position()" />
							<xsl:with-param name="separator" select="', '" />
							<xsl:with-param name="total-param-count" select="count(../dic:parameter)" />
						</xsl:call-template>
					</xsl:for-each>
					<xsl:text>})</xsl:text></string>
				
				<key>name</key>
				<string><xsl:value-of select="@name"/></string>
				
				<key>scope</key>
				<string>text.html.cfm</string>
				
				<key>tabTrigger</key>
				<string><xsl:value-of select="@name"/></string>
				
				<key>uuid</key>
				<string><xsl:value-of select="util:toString($uid)"/></string>
			</dict>
			</plist>
		</xsl:result-document>
	</xsl:template>
	
	<!-- Formats the tags. Writes out the plist file too -->
	<xsl:template match="dic:tag">
		<xsl:variable name="filename" select="translate(@name,':','-')" /> 
		<!-- <xsl:value-of select="$filename" /> -->
		
		<xsl:variable name="uid" select="util:randomUUID()"/>
		<string><xsl:value-of select="util:toString($uid)"/></string>
		<xsl:value-of select="$NL" />
		
		<!-- {$bundle-dir}/ -->
		<xsl:result-document 
			href="Snippets/gen-{$filename}.tmSnippet" format="plistxml">
			<!-- <xsl:text><!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"></xsl:text> -->
			<plist version="1.0">
			<dict>
				<key>content</key>
				<string><xsl:text>&lt;</xsl:text>
				<xsl:value-of select="@name" />
				<xsl:text> ${1:</xsl:text>
				<xsl:for-each select="./dic:parameter">
					<xsl:call-template name="param-with-placement">
						<xsl:with-param name="placement" select="position()+position()" />
						<xsl:with-param name="separator" select="' '" />
						<xsl:with-param name="total-param-count" select="count(../dic:parameter)" />
						<!-- <xsl:with-param name="element" select="." /> -->
					</xsl:call-template>
				</xsl:for-each>
				<xsl:text>}</xsl:text>

				<xsl:choose>
					<xsl:when test="@single = 'true'">
						<xsl:text>/&gt;$0</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>&gt;$0&lt;</xsl:text>
						<xsl:value-of select="@name" />
						<xsl:text>&gt;</xsl:text>
					</xsl:otherwise>
				</xsl:choose></string>
				
				<key>name</key>
				<string><xsl:value-of select="@name"/></string>
				
				<key>scope</key>
				<string>text.html.cfm</string>
				
				<key>tabTrigger</key>
				<string>
					<xsl:choose>
						<xsl:when test="contains(@name,':')">
							<xsl:value-of select="substring-before(@name,':')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@name" />
						</xsl:otherwise>
					</xsl:choose>
				</string>
				
				<key>uuid</key>
				<string><xsl:value-of select="util:toString($uid)"/></string>
			</dict>
			</plist>
		</xsl:result-document>
	</xsl:template>
	
	<!-- handles doing the tag and function params. Takes 3 params.
		placement = where to start the textmate $N variables from
		separator = what to tack on to the end of each paramenter
		total-param-count = total number of params, so we don't add the
		separator to the last item.
	-->
	<xsl:template name="param-with-placement">
		<xsl:param name="placement" />
		<xsl:param name="separator" />
		<xsl:param name="total-param-count" />
		
		<xsl:text>$</xsl:text>
		<xsl:text>{</xsl:text>
		<xsl:value-of select="$placement" />
		<xsl:text>:</xsl:text>
		<xsl:value-of select="@name" /><xsl:text>="$</xsl:text>
		<xsl:value-of select="$placement+1" />
		<xsl:text>"</xsl:text>
		<xsl:if test="position() != $total-param-count">
			<xsl:value-of select="$separator" />
		</xsl:if>
		<xsl:text>}</xsl:text>
	</xsl:template>
	
	<xsl:template match="text()" />
</xsl:stylesheet>