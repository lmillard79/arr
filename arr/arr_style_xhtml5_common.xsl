<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
   xmlns:d="http://docbook.org/ns/docbook"
   xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="d">
   <!-- This stylesheet contains the customisations that are common across -->
   <!-- the XHTML5 (and hence EPUB3) renders. -->
   <!-- Nota Bene: this sheet is common across both single page or chunked -->
   <!-- Peter Brady peter.brady@wmawater.com.au -->
   
   <!-- Import the common global stylesheet -->
   <xsl:import href="arr_style_common.xsl" />
   
   <xsl:param name="make.valid.html">1</xsl:param>
   <xsl:param name="html.cleanup">1</xsl:param>
   <xsl:param name="make.clean.html">1</xsl:param>

   <!-- Common javascript/s to add to all builds: -->
   <!--    -) MathJax                             -->
   <!--    -) Bootstrap                           -->
   <!--    -) JQuery                              -->
   <xsl:param name="html.script">http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js</xsl:param>
   <xsl:param name="html.script.type">text/javascript</xsl:param>

   <!-- Add a common stylesheet -->
   <xsl:param name="html.stylesheet">https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css arr.css</xsl:param>

   <!-- Table of Contents Formatting -->
   <xsl:param name="toc.list.type">ol</xsl:param>
   <xsl:template match="d:book" mode="toc">
      <xsl:param name="toc-context" select="."/>

      <xsl:call-template name="subtoc">
         <xsl:with-param name="toc-context" select="$toc-context"/>
         <xsl:with-param name="nodes" select="EMPTY"/>
      </xsl:call-template>
   </xsl:template>


   <!-- Table Alternate Row Colouring -->
   <xsl:template match="d:table" mode="htmlTable">
      <xsl:element name="table" namespace="http://www.w3.org/1999/xhtml">
         <xsl:attribute name="class">
            <xsl:text>table table-bordered table-hover table-striped</xsl:text>
         </xsl:attribute>
         <xsl:apply-templates select="@*" mode="htmlTableAtt"/>
         <xsl:call-template name="htmlTable"/>
      </xsl:element>
   </xsl:template>

   <!-- Equation title Customisation -->
   <xsl:param name="local.l10n.xml" select="document('')"/>
   <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
      <l:l10n language="en">
         <l:context name="title">
            <l:template name="equation" text="&#40;%n&#41;"/>
         </l:context>    
         <l:context name="xref">
            <l:template name="equation" text="&#40;%n&#41;"/>
         </l:context>
         <l:context name="xref-number">
            <l:template name="equation" text="&#40;%n&#41;"/>
         </l:context>
      </l:l10n>
   </l:i18n>
   
   <!-- Author Arrangements
      Specifically:
      -) drop affiliations
      -) horizontal list
   -->
   <xsl:template name="chapter.titlepage.recto">
      <xsl:choose>
         <xsl:when test="d:chapterinfo/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:chapterinfo/d:title"/>
         </xsl:when>
         <xsl:when test="d:docinfo/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:docinfo/d:title"/>
         </xsl:when>
         <xsl:when test="d:info/d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:info/d:title"/>
         </xsl:when>
         <xsl:when test="d:title">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:title"/>
         </xsl:when>
      </xsl:choose>
      
      <xsl:choose>
         <xsl:when test="d:chapterinfo/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:chapterinfo/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:docinfo/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:docinfo/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:info/d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
         </xsl:when>
         <xsl:when test="d:subtitle">
            <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" select="d:subtitle"/>
         </xsl:when>
      </xsl:choose>
      
      <p class="author">
         <xsl:for-each select=".//d:author">
            <xsl:call-template name="person.name"/>
            <xsl:if test="position() != last()">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:for-each>
      </p>
   </xsl:template>
   
 
</xsl:stylesheet>
