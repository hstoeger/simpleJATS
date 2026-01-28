<?xml version="1.0" encoding="UTF-8"?>
<!-- simpleJATS Stylesheet -->
<!-- Author: Heinz Rosenkranz, heinz.rosenkranz@a7111.com -->
<!-- Date: February 2016, August 2022 -->
<!-- Edit: 2021-06-08 Vittorio Muth: Customized journals with custom.xsl -->
<!-- Edit: 2023-08-28 Vittorio Muth: Compare and sync to Heinz Rosenkranz' version of August 2023-->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:x-on="http://alpinejs.info">

    <!-- Common Style Parameters -->
    <xsl:include href="custom.xsl"/>
    <!-- Contains customized xsl:params of journal like colors, URL of CSS, URL of journalHeader -->


    <!-- ============================================= -->
    <!-- ROOT TEMPLATE     -->
    <!-- prepare HTML-Layout -->
    <!-- ============================================= -->
    <xsl:template match="/">
        <html xmlns:mml="http://www.w3.org/1998/Math/MathML">
            <head>
                <meta name="viewport"
                    content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
                <script src="/_style/Journalpage/js/jquery-3.7.1.min.js" language="javascript"> </script>
				
                <!-- <script src="node_modules/flowbite/dist/flowbite.min.js" language="javascript"> </script>-->
                <xsl:call-template name="makeMetadata"/>
                <xsl:call-template name="makeCSS"/>

                <script type="text/x-mathjax-config">
	MathJax.Hub.Config({
	"HTML-CSS": { linebreaks: { automatic: true } },
         SVG: { linebreaks: { automatic: true } }
	});
	</script>

                <!-- script src="/test/VYPRxml2018test/src/host.js" type="text/javascript"></script -->
                <!--script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"></script -->
                <script>window.MathJax = {chtml: {scale: 1.1}, svg: {scale: 1.1}};</script>
                <script src="https://cdn.jsdelivr.net/npm/js-polyfills@0.1.43/polyfill.min.js"/>
                <script defer="defer" type="text/javascript" id="MathJax-script" src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"/>
                <script type="text/javascript">
	<![CDATA[
                    function openInfo(evt, Name) {
                        // Declare all variables
                        var i, panelSection, infoLink;
                        
                        // Get all elements with class="panelSection" and hide them
                        panelSection = document.getElementsByClassName("panelSection");
                        for (i = 0; i < panelSection.length; i++) {
                            panelSection[i].style.display = "none";
                        }
                        
                        // Get all elements with class="infoLink" and remove the class "active"
                        infoLink = document.getElementsByClassName("infoLink");
                        for (i = 0; i < infoLink.length; i++) {
                            infoLink[i].className = infoLink[i].className.replace(" active", "");
                        }
                        
                        // Show the current tab, and add an "active" class to the button that opened the tab
                        document.getElementById(Name).style.display = "block";
                        evt.currentTarget.className += " active";
                    }
                    function closeInfo(evt, Name) {
                        // Declare all variables
                        var i, panelSection, infoLink;
                        
                        // Get all elements with class="panelSection" and hide them
                        panelSection = document.getElementsByClassName("panelSection");
                        for (i = 0; i < panelSection.length; i++) {
                            panelSection[i].style.display = "none";
                        }
                    }//]]>
	</script>
	<script defer="defer" src="/_navigation/load-top-header-div.js"></script>
            </head>

            <body>
                <div id="centered">
                    <xsl:call-template name="makeTopNavi"/>
                    <!--  Outer Table for centered Content -->
                    <div id="panel">
                        <div>
                            <!--<tr>-->
                            <!--<td> </td>-->

                            <div class="centered">
                                <!--<td width="1060">-->
                                <!-- Header & Topnavigation -->


                                <!-- Inner Table: 2 Columns -->
                                <!-- Content Column - About-Column -->
                                <div id="articleWrapperTable">
                                    <div id="articleMeta">
                                        <xsl:call-template name="makeArticleHeader"/>
                                    </div>
                                    <div id="articleWrapperRow" valign="top">

                                        <!-- Content Column -->
                                        <div id="contents" class="col content">
                                            <div class="pdfBar">
                                                <div class="pdfBarContent">
                                                  <button class="pdfBarContentItem">
												  <xsl:variable name="issueyear">
													<xsl:choose>
														<xsl:when test="contains(//journal-title, //pub-date/year)">
															<xsl:value-of select="//pub-date/year"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="//article-meta/volume"/>
														</xsl:otherwise>
													</xsl:choose>
												  </xsl:variable>
                                                  <xsl:attribute name="onclick"
                                                  >window.location.href=window.location.protocol +
                                                  '//' + window.location.host + '/vypr/<xsl:value-of
                                                  select="$issueyear"/>/<xsl:value-of
                                                  select="//article-meta/issue"/>/<xsl:text/><xsl:value-of
                                                  select="//self-uri/@xlink:href"/>';
                                                  </xsl:attribute> PDF&#160; <xsl:copy-of
                                                  select="$pdfLogo"/>
                                                  </button>
                                                  <button class="pdfBarContentItem">
                                                  <xsl:attribute name="onclick"
                                                  >downloadXML();</xsl:attribute> XML&#160;
                                                  <xsl:copy-of select="$XmlLogo"/>
                                                  </button>
                                                  <!--<button class="pdfBarContentItem" onclick="$('#sharelinks').toggle();">-->
                                                  <button class="pdfBarContentItem"
                                                  onclick="toggleShare();"> Share&#160; <xsl:copy-of
                                                  select="$shareLogo"/>
                                                  </button>

                                                  <div id="sharelinks" class="menu4 display-none">
                                                  <!--social bookmarks-->
                                                  <a href="javascript:openSocBm('bibsonomy');"
                                                  title="Add to bibsonomy" class="menulink1">
                                                  <img src="/prospekte/logo/bibsonomy-logo.png" border="0"
                                                  title="Add to bibsonomy" alt="Add to bibsonomy"/>
                                                  </a>

                                                  <!--Twitter-->
                                                  <a href="javascript:openSocBm('twitter');"
                                                  title="X" class="menulink1">
                                                  <img src="/_style/Journalpage/bilder/X_logo.svg" border="0"
                                                  title="Share on twitter" alt="Share on twitter"/>
                                                  </a>

                                                  <!--Facebook-->
                                                  <a href="javascript:openSocBm('facebook');"
                                                  class="menulink1" title="Share on facebook">
                                                  <img src="/prospekte/logo/facebook-icon.gif" border="0"
                                                  alt="facebook-logo"/>
                                                  </a>

                                                  <!--LinkedIn-->
                                                  <a href="javascript:openSocBm('linkedin');"
                                                  title="Share on linkedin" class="menulink1">
                                                  <img src="/prospekte/logo/linkedin-logo.jpg"
                                                  alt="Share on linkedin" border="0"/>
                                                  </a>
												  
												  <!--bluesky-->
                                                  <a href="javascript:openSocBm('bsky');"
                                                  class="menulink1">
                                                  <img src="/_style/Journalpage/bilder/bsky.svg" border="0"
                                                  title="Share on Bluesky" alt="Share on Bluesky"/>
                                                  </a>
												  
												  <!--mastodon-->
												  <a href="#" rel="noreferrer noopener" target="mastodon" data-prompt="Please tell me your Mastodon instance" 
												  data-edittext="✏️" data-editlabel="Edit your Mastodon instance" class="mastodon-share"><img src="/_style/Journalpage/bilder/Mastodon_logo.svg" border="0" title="Share to Mastodon" alt="Share to Mastodon"/></a>
												  
												  <script src="/prospekte/mastodon-share.js" language="javascript"> </script>
		

                                                  <!--researchgate-->
                                                  <!--<a href="javascript:openSocBm('researchgate');"
                                                  class="menulink1">
                                                  <img src="/prospekte/logo/researchgate-logo.jpg" border="0"
                                                  title="Share on researchgate"
                                                  alt="Share on researchgate"/>
                                                  </a>-->
                                                  <!--xing-->
                                                  <a href="javascript:openSocBm('xing');"
                                                  class="menulink1">
                                                  <img src="/prospekte/logo/xing-logo.jpg" border="0"
                                                  title="Share on xing" alt="Share on xing"/>
                                                  </a>
												  <!--email-->
												  <a class="menulink1">
												  <xsl:attribute name="href">
												  mailto:?subject=<xsl:value-of select="//article-title"></xsl:value-of>&amp;body=Dear%20,%0D%0A%0D%0Aplease%20see%20this%20article:%0D%0A%0D%0A<xsl:value-of
                                                  select="//title-group/article-title"/>, in <xsl:value-of select="//journal-title"/> <xsl:value-of
                                                  select="//pub-date/year"/>%0D%0A%0D%0Ahttps://doi.org/<xsl:value-of
                                                  select="//article-meta[1]/article-id[@pub-id-type = 'doi']"/>
												  </xsl:attribute>
                                                  <span style="font-size: 22px;">@</span>
                                                  </a>
		

                                                  </div>
                                                  <button class="pdfBarContentItem"
                                                  onclick="$('#citelinks').toggle();">
                                                  Cite&#160;as&#160; <xsl:copy-of
                                                  select="$citeAsLogo"/>
                                                  </button>
                                                  <div id="citelinks" class="menu4">
												  Citation: 
                                                  <!-- APA7: AuthorFN, AuthorLN, (YEAR). ArticleTitle. <i>Vienny Yearbook of Population Research, issueNo, StartPage-EndPage.</i> https://doi.org/10.1553/... -->
                                                  <!--<xsl:for-each select="//article-meta//aff">
                                                  <xsl:variable name="index" select="position()"/>
                                                  <xsl:variable name="rid" select="@id"/>
                                                  <xsl:variable name="givenname">
                                                  <xsl:value-of
                                                  select="../contrib[@contrib-type = 'author' and xref/@rid = $rid]/name/given-names"
                                                  />
                                                  </xsl:variable>
                                                  <xsl:variable name="surname">
                                                  <xsl:value-of
                                                  select="../contrib[@contrib-type = 'author' and xref/@rid = $rid]/name/surname"
                                                  />
                                                  </xsl:variable>
                                                  
												  <xsl:if test="(position() = last()) and (position()&gt;1)">&#038; </xsl:if>
                                                  <xsl:value-of select="$surname"/>, <xsl:value-of
                                                  select="$givenname"/>
                                                  <xsl:if test="position() != last()">, </xsl:if>
                                                  <xsl:if test="position() = last()">. </xsl:if>
                                                  </xsl:for-each>-->
												  <xsl:for-each select="//article-meta//contrib">
                                                  <xsl:variable name="index" select="position()"/>
												  <xsl:variable name="rid" select="xref[@id]"/>
												  
												  <xsl:if test="(position() = last()) and (position()&gt;1)">&#038; </xsl:if><!-- note to dev: This is  ampersand! -->
												  <xsl:value-of select="name/surname"/>, 
												  <xsl:value-of select="name/given-names"/><xsl:if test="position() != last()">, </xsl:if>
                                                  <!--<xsl:if test="position() = last()">. </xsl:if>-->
                                                  </xsl:for-each> (<xsl:value-of
                                                  select="//pub-date/year"/>). <xsl:value-of
                                                  select="//title-group/article-title"
                                                  /> <xsl:text/>. <i>
                                                  <xsl:value-of select="//journal-title"/>,
                                                  <xsl:value-of select="//volume"/> <xsl:text/>
                                                  (<xsl:value-of select="//issue"/>), <xsl:text/>
                                                  </i>
                                                  <xsl:value-of select="//fpage"/>–<xsl:value-of
                                                  select="//lpage"/>. <xsl:text/>
                                                  https://doi.org/<xsl:value-of
                                                  select="//article-meta[1]/article-id[@pub-id-type = 'doi']"/>
                                                  <br/><br/>Download Citation File:<br/>
                                                  <a id="createLnk" href="javascript:bibtex();"
                                                  title="BibTeX (ISO-8859-1)" class="menulink2"
                                                  >BibTeX</a><br/>
                                                  <a id="createLnk2" href="javascript:endNote();"
                                                  title="EndNote" class="menulink2">EndNote</a><br/>
                                                  <a id="createLnk3" href="javascript:ris();"
                                                  title="Research Information System/Zotero"
                                                  class="menulink2">RIS/Zotero</a><br/>
                                                  <!-- 
<a href="#" class="menulink2" onclick="document.getElementsByTagName('body')[0].appendChild(document.createElement('script')).setAttribute('src','https://www.mendeley.com/minified/bookmarklet.js');;return false;">Mendeley</a><br/>
 -->
                                                  <div id="bibTexBox" class="citeBox">
                                                  <a href="javascript:hideBibTex();"
                                                  onclick="javascript:hideBibTex();" title="Close"
                                                  ><b>X</b></a><br/>
                                                  <b>BibTEX-Export:</b>
                                                  <br/><br/>
                                                  </div>
                                                  <div id="bibForm" class="citeForm">
                                                  <form name="cgiFeeder"
                                                  action="/vz/epub-labor/epub.oeaw.bib"
                                                  method="get">
                                                  <textarea name="text" rows="2" cols="60"/>
                                                  </form>
                                                  </div>
                                                  <div id="endNoteBox" class="citeBox">
                                                  <a href="javascript:hideEndNote();"
                                                  onclick="javascript:hideEndNote();" title="Close"
                                                  ><b>X</b></a><br/>
                                                  <b>EndNote/Zotero-Export:</b>
                                                  <br/><br/>
                                                  </div>
                                                  <div id="endNoteForm" class="citeForm">
                                                  <form name="cgiFeeder2"
                                                  action="/vz/epub-labor/epub.oeaw.enw"
                                                  method="get">
                                                  <textarea name="text" rows="2" cols="60"/>
                                                  </form>
                                                  </div>
                                                  <div id="risBox" class="citeBox">
                                                  <a href="javascript:hideRis();"
                                                  onclick="javascript:hideRis();" title="Close"
                                                  ><b>X</b></a><br/>
                                                  <b>RIS-Export:</b>
                                                  <br/><br/>
                                                  </div>
                                                  <div id="risForm" class="citeForm">
                                                  <form name="cgiFeeder3"
                                                  action="/vz/epub-labor/epub.oeaw.ris"
                                                  method="get">
                                                  <textarea name="text" rows="2" cols="60"/>
                                                  </form>
                                                  </div>
                                                  </div>

                                                </div>
                                            </div>

                                            <xsl:call-template name="makeContent"/>

                                        </div>
                                        <!-- <div id="spacer2" class="col" width="20"> 
					<div id="menuCtrl" class="bx bx-chevron-right-circle" onclick="toggleArticleMenu();"></div>
					</div> GE -->

                                        <!-- Info Column -->

                                        <div id="about" class="col metatabset">
                                            <div id="aboutCtrl" class="aboutCtrl">
                                                <!-- Cover Image -->
                                                <!--<div style="margin-top:-2.6rem"><img src="../_img/cover.jpg" alt="Issue-Cover"/></div>-->

                                                <!-- Info-Box -->
                                                <div class="infoBox">
												  <button id="default" class="infoLink"
                                                  onclick="openInfo(event, 'Info')">Info</button>
                                                  <button class="infoLink"
                                                  onclick="openInfo(event, 'Index')"
                                                  >Contents</button>
                                                  <button class="infoLink"
                                                  onclick="openInfo(event, 'Figures')"
                                                  >Figures</button>
                                                  <button class="infoLink"
                                                  onclick="openInfo(event, 'Authors')"
                                                  >References</button>
                                                  <button class="infoLink lastPanelButton"
                                                  onclick="openInfo(event, 'Related')"
                                                  >Metrics</button>
                                                </div>
                                                <!-- Info Content -->
                                                <div id="Info" class="panelSection">
                                                  <div class="closeInfo">
                                                  <button class="infoClose"
                                                  onclick="closeInfo(event, 'Info')">
                                                  <xsl:copy-of select="$infoCloseX"/>
                                                  </button>
                                                  </div>
                                                  <div class="info">
                                                  <xsl:call-template name="makeAbout"/>
                                                      <xsl:call-template name="makeAuthors"></xsl:call-template>
                                                  </div>
                                                </div>
                                                <div id="Index" class="panelSection">
                                                  <div class="closeInfo">
                                                  <button class="infoClose"
                                                  onclick="closeInfo(event, 'Index')">
                                                  <xsl:copy-of select="$infoCloseX"/>
                                                  </button>
                                                  </div>
                                                  <div class="panelContent">
                                                  <xsl:call-template name="makeMenu"/>
                                                  </div>
                                                </div>
                                                <div id="Authors" class="panelSection">
                                                  <div class="closeInfo">
                                                  <button class="infoClose"
                                                  onclick="closeInfo(event, 'Authors')">
                                                  <xsl:copy-of select="$infoCloseX"/>
                                                  </button>
                                                  </div>
                                                  <div class="info">
                                                  <xsl:call-template name="makeReferences"/>
                                                  </div>
                                                </div>
                                                <div id="Figures" class="panelSection">
                                                  <div class="closeInfo">
                                                  <button class="infoClose"
                                                  onclick="closeInfo(event, 'Figures')">
                                                  <xsl:copy-of select="$infoCloseX"/>
                                                  </button>
                                                  </div>
                                                  <xsl:for-each select="//fig">
                                                  <div class="info">
                                                  <xsl:apply-templates select="." mode="panel"/>
                                                  </div>
                                                  </xsl:for-each>
                                                </div>
                                                <div id="Related" class="panelSection">
                                                  <div class="closeInfo">
                                                  <button class="infoClose"
                                                  onclick="closeInfo(event, 'Related')">
                                                  <xsl:copy-of select="$infoCloseX"/>
                                                  </button>
                                                  </div>
                                                  <div class="info">
                                                  <xsl:call-template name="makeRelated"/>
                                                  </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--</td>-->
                            <!--<td> </td>-->

                        </div>
                        <!--</tr>-->
                        <!-- 
		<div id="footerbottom">
			Verlag der Österreichischen Akademie der Wissenschaften <br />Austrian Academy of Sciences Press
		</div>
	-->
                    </div>
                    <!--</table>-->

                </div>
                <!-- <script>document.getElementById("default").click(); </script>-->
                <div id="journalHeader" class="invisible"/>
                <div id="commonHeader" class="invisible"/>


            </body>
        </html>
    </xsl:template>
    <!-- end ROOT TEMPLATE -->


    <!-- Make MENU     -->
    <!-- Navi Column leftside -->
    <!-- ============================================= -->
    <xsl:template name="makeMenu">
        <xsl:if test="string-length(//body/sec[1]/title) > 0">
            <h5 class="panelContent">Contents</h5>
        </xsl:if>
        <!-- First Level -->
        <ol class="panelContent">
            <xsl:for-each select="//body/sec">
                <xsl:variable name="style"/>
                <li class="panelContent">
                    <xsl:attribute name="style"> list-style-type:'<xsl:value-of select="label"/>' </xsl:attribute>
                    <a class="panelContent">
                        <xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
                        <xsl:value-of select="title"/>
                    </a>
                    <!-- Second Level -->
                    <ol class="panelContent">
                        <xsl:for-each select="sec">
                            <li class="panelContent">
                                <xsl:attribute name="style"> list-style-type:'<xsl:value-of
                                        select="label"/>' </xsl:attribute>
                                <a class="panelContent">
                                    <xsl:attribute name="href">#<xsl:value-of select="@id"
                                        /></xsl:attribute>
                                    <xsl:value-of select="title"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ol>
                </li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    <!-- end Make Menu -->


    <!-- Make CONTENT -->
    <!-- ============================================= -->

    <!-- Make Article Header -->
    <!-- VYPR-Version - beim Refactorieren auslagern -->
    <xsl:template name="makeArticleHeader">
        <p class="articleHeader"><span class="versalien"><xsl:value-of
                    select="//article-meta[1]/article-categories[1]/subj-group[@subj-group-type = 'heading']/subject"
                /></span>&#160;|&#160; <xsl:call-template name="format-date">
                <xsl:with-param name="date"><xsl:value-of
                        select="//pub-date[@pub-type = 'epub'][1]/@iso-8601-date"/></xsl:with-param>
            </xsl:call-template>
        </p>
        <!-- Titles -->
        <h1 class="articleTitle">
            <xsl:apply-templates select="//title-group/article-title"/>
        </h1>
        <xsl:for-each select="//title-group/subtitle">
            <h2 class="articleSubtitle">
                <xsl:apply-templates select="."/>
            </h2>
        </xsl:for-each>

        <!-- Contributors -->
        <p class="contributors">
            <xsl:for-each select="//contrib">
            <xsl:element name="a">
                <xsl:attribute name="href">#<xsl:value-of select="xref[@ref-type='aff']/@rid"></xsl:value-of></xsl:attribute>
                <xsl:attribute name="onclick"><xsl:text>openInfo(event, 'Info')</xsl:text></xsl:attribute>
            
                <xsl:if test="name/prefix"><xsl:value-of select="name/prefix"/> </xsl:if>
                <xsl:value-of select="name/given-names"/> <xsl:value-of select="name/surname"/>
                <xsl:if test="name/suffix"> <xsl:value-of select="name/suffix"/></xsl:if>
            </xsl:element>
                <xsl:if test="contrib-id[@contrib-id-type='orcid']">
                    <xsl:text>&#160;</xsl:text>
                    <xsl:element name="span">
                        <xsl:attribute name="class">orcidLogo</xsl:attribute>
                        <xsl:element name="a">
                            <xsl:attribute name="target">_new</xsl:attribute>
                            <xsl:attribute name="href"><xsl:value-of select="contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
                            <xsl:copy-of select="$orcidLogo"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                    
                <xsl:if test="position() != last()">, </xsl:if>
                <!-- <span style="cursor:help;">
			<xsl:attribute name="title"> Role: <xsl:value-of select="role"/> </xsl:attribute>
			<xsl:if test="orcid"><a target="_blank">
				<xsl:attribute name="title">ORCID: <xsl:value-of select="orcid"></xsl:value-of></xsl:attribute>
				<xsl:attribute name="href">https://www.orcid.org/<xsl:value-of select="orcid"></xsl:value-of></xsl:attribute>
				<img><xsl:attribute name="src"><xsl:value-of select="$stylePath"/>orcid_16x16.png</xsl:attribute></img>
			</a>&#160;</xsl:if>
			<xsl:if test="name/prefix"><xsl:value-of select="name/prefix"/> </xsl:if>
			<xsl:value-of select="name/given-names"/> <xsl:value-of select="name/surname"/>
			<xsl:if test="name/suffix"> <xsl:value-of select="name/suffix"/></xsl:if>
			<xsl:if test="*/@content-type='orcid' ">
				<a target="_new">
					<xsl:attribute name="href"><xsl:value-of select="uri"/></xsl:attribute>
					<img title=" orcid "><xsl:attribute name="src"><xsl:value-of select="$stylePath"/>orcid.gif</xsl:attribute></img>
				</a>
			</xsl:if>
			<xsl:if test="@corresp = 'yes' ">
				<sup style="cursor:help;" title=" Corresponding author ">✉</sup>
			</xsl:if>
		</span>
		<xsl:for-each select="xref">
			<xsl:choose>
				<xsl:when test="@ref-type = 'corresp' ">
					<sup style="cursor:help;" title=" Corresponding author ">✉</sup>
				</xsl:when>
				<xsl:when test="@ref-type = 'fn' ">
					<sup style="cursor:help; " title=" Authornote ">
						<xsl:value-of select="substring-after(@rid, 'con')"/>
						<xsl:value-of select="substring-after(@rid, 'fn')"/>
					</sup>
				</xsl:when>
				<xsl:when test="@ref-type = 'aff' ">
					<sup style="cursor:help; " title=" Affiliation ">
						[<xsl:value-of select="substring-after(@rid, 'aff')"/>]<xsl:text/>
					</sup>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:if test="position() != last()">, </xsl:if> -->
            </xsl:for-each>
        </p>
        <p class="info">
            <xsl:value-of select="//journal-title-group[1]/journal-title"/> (Vol. <xsl:value-of
                select="//article-meta[1]/volume"
            />),&#160;<!-- Issue <xsl:value-of select="issue"/>--> pp. <xsl:value-of
                select="//article-meta[1]/fpage"/>
            <xsl:if test="//article-meta[1]/lpage">–<xsl:value-of select="//article-meta[1]/lpage"
                /></xsl:if>
            <xsl:if test="//article-meta[1]/page-range">, <xsl:value-of
                    select="//article-meta[1]/page-range"/></xsl:if> &#160;|&#160;<a
                href="https://doi.org/">
                <xsl:attribute name="href">https://doi.org/<xsl:value-of
                        select="//article-meta[1]/article-id[@pub-id-type = 'doi']"
                    /></xsl:attribute> https://doi.org/<xsl:value-of
                    select="//article-meta[1]/article-id[@pub-id-type = 'doi']"/></a>
        </p>
        <xsl:if test="//journal-title-group[1]/journal-subtitle">
            <p class="info"><span class="bold">Special issue:</span>&#160;<xsl:value-of
                    select="//journal-title-group[1]/journal-subtitle"/></p>

        </xsl:if>

        <!--<div class="conditionalBoxes">
		<div class="relative">
			<xsl:attribute name="x-data">{ open1: false, open2: false }</xsl:attribute>
			<p class="abstractModal">
				<button class="buttonSwitch smallArrow" id="relatedButtonSwitch" x-on:click="[open1, open2] = doToggle(open1, 'buttonSwitch')">
					Related content&#160;<svg fill="currentColor" viewBox="0 0 20 20">
						<xsl:attribute name="class">{'rotate-180': open1, 'rotate-0': !open1} naviArrow</xsl:attribute>
					<path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
					
				</button>

				<button class="buttonSwitch smallArrow" id="repliesButtonSwitch" x-on:click="[open2, open1] = doToggle(open2, 'buttonSwitch')">This article replies to&#160;<svg fill="currentColor" viewBox="0 0 20 20">
					<xsl:attribute name="class">naviArrow</xsl:attribute><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg></button>
					<script>function doToggle(one, whichButton) { 
						var elems = document.getElementsByClassName(whichButton);
						[].forEach.call(elems, function(el) {
							el.classList.remove("highlight");
						});
						event.target.classList.toggle("highlight", ! one);
						return [ ! one, false]; 
					}</script>
			</p>
				<div x-show="open1" id="relatedContent">
					related content...
				</div>
				<div x-show="open2" id="articleReplies">
					article replies...
				</div>
		</div>
	</div>-->
    </xsl:template>

    <!-- Resolve Content -->
    <!-- VYPR-Version - beim Refactorieren auslagern -->
    <xsl:template name="makeContent">


        <!-- Abstract -->
        <xsl:if test="//article-meta/abstract">
            <div class="abstractBox">
                <div class="abstractHeadline">Abstract</div>
                <xsl:apply-templates select="//article-meta/abstract/*"/>
                <xsl:if test="//article-meta/kwd-group">
                    
                        <h4>Keywords</h4>
                    <p>
                    <xsl:for-each select="//article-meta/kwd-group/kwd">
                        <xsl:apply-templates/>
                        <xsl:if test="position() != last()"> • </xsl:if>
                    </xsl:for-each>
                    </p>
                </xsl:if>
            </div>
        </xsl:if>


        <div class="contentBox">
            <!-- Body Content -->
            <xsl:apply-templates select="//body"/>

            <!-- Back Content -->
            <hr class="ruler"/>
            <xsl:apply-templates select="//back"/>
            <br/>

            <!-- Make Trailer below -->
            <div align="right">
                <xsl:value-of select="//Autor"/>
            </div>
            <!-- <hr class="ruler"/>
            <div class="comment">
                <b>Cite rule:</b> https://epub.oeaw.ac.at/vypr/<xsl:value-of
                    select="//pub-date/year"/>/<xsl:value-of select="//issue"/>/<xsl:text/>
                <xsl:value-of select="//self-uri/@xlink:href"/>
            </div> -->
        </div>


    </xsl:template>
    <!-- end Make CONTENT -->


    <!-- Make ABOUT      -->
    <!-- ============================================= -->
    <xsl:template name="makeAbout">
        <!-- Predefined Attribute Values-->
        <xsl:variable name="digital"> electronic digital epub ebook e-book online online-only </xsl:variable>
        <xsl:variable name="contribution"> contrib com corresp deceased edited-by supported-by </xsl:variable>
        <xsl:variable name="disclosure"> conflict financial-disclosure </xsl:variable>

        <!-- Journal-Metadata -->
        <h5 class="panelContent">Journal</h5>

        <div class="cover">
            <xsl:variable name="coverImage">
                <xsl:value-of select="//article-id[@pub-id-type = 'doi']"/>
            </xsl:variable>
            <xsl:variable name="coverImageName">
                <xsl:value-of select="//article-id[@pub-id-type = 'doi']"/>
<!--                <xsl:value-of select="substring-before(substring-after($coverImage, '/'), 's')"/>-->
            </xsl:variable>
            <xsl:variable name="coverImageNameTwo">
                <xsl:value-of select="//journal-id[@journal-id-type = 'publisher-id']"/>
				<xsl:value-of select="//article-meta/volume"/>
            </xsl:variable>
			<xsl:variable name="titleyear">
				<xsl:choose>
					<xsl:when test="contains(//journal-title, //pub-date/year)">
						<xsl:value-of select="//pub-date/year"/>
					</xsl:when>
					<xsl:when test="contains(//journal-title, //copyright-year)">
						<xsl:value-of select="//copyright-year"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(//journal-title, string-length(//journal-title) - 3, 4)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			
			<a>
				<xsl:attribute name="href">https://austriaca.at/populationyearbook<xsl:value-of select="$titleyear"/></xsl:attribute>
            <img alt="Issue-Cover" border="0">
                <xsl:attribute name="src"><xsl:value-of select="$coverFolder"/><xsl:value-of
                        select="$coverImageNameTwo"/>.png</xsl:attribute>
                <xsl:attribute name="alt">Cover <xsl:value-of select="$coverImageNameTwo"
                    /></xsl:attribute>
            </img>
			</a>
        </div>

        <xsl:for-each select="//journal-meta">
            <xsl:for-each select="journal-title-group">
				<xsl:variable name="titleyeartwo">
				<xsl:choose>
					<xsl:when test="contains(//journal-title, //pub-date/year)">
						<xsl:value-of select="//pub-date/year"/>
					</xsl:when>
					<xsl:when test="contains(//journal-title, //copyright-year)">
						<xsl:value-of select="//copyright-year"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring(//journal-title, string-length(//journal-title) - 3, 4)" />
					</xsl:otherwise>
				</xsl:choose>
				</xsl:variable>
                <div class="panelContent">
                    <a>
						<xsl:attribute name="href">https://austriaca.at/populationyearbook<xsl:value-of select="$titleyeartwo"/></xsl:attribute>
						<h5 class="panelContent">
							<xsl:value-of select="journal-title"/>
						</h5>
					</a>
                    <xsl:if test="journal-subtitle">
                        <p>
                            <xsl:value-of select="journal-subtitle"/>
                        </p>
                    </xsl:if>
                    <xsl:if test="abbrev-journal-title">
                        <p>
                            <xsl:value-of select="abbrev-journal-title"/>
                        </p>
                    </xsl:if>
                </div>
            </xsl:for-each>
            <p class="panelContent">
                <b><xsl:value-of select="publisher"/></b>
            </p>
            <!--<div class="panelDataTable">
                <xsl:for-each select="journal-id[not(@journal-id-type = 'publisher-id')]">
                    <div class="panelDataRow">
                        <div class="panelDataLabel"><xsl:value-of select="@journal-id-type"
                            />: </div>
                        <div class="panelDataValue">
                            <xsl:value-of select="."/>
                        </div>
                    </div>
                </xsl:for-each>
                <div class="panelDataRow">
                    <div class="panelDataLabel">ISSN: </div>
                    <div class="panelDataValue">
                        <xsl:value-of select="issn"/>
                    </div>
                </div> 
            </div>-->
        </xsl:for-each>
        <xsl:for-each select="//journal-meta/notes">
            <p class="panelText">
                <xsl:apply-templates/>
            </p>
        </xsl:for-each>

        <!-- Article-Metadata -->
        <h5 class="panelContent">Article</h5>
        <xsl:for-each select="//article-meta">
            <div class="panelDataTable">
                <div class="panelDataRow">
                    <div class="panelDataLabel">Volume:&#160; </div>
                    <div class="panelDataValue">
                        <xsl:value-of select="volume"/>
                    </div>
                </div>
                <div class="panelDataRow">
                    <div class="panelDataLabel">Issue: </div>
                    <div class="panelDataValue">
                        <xsl:value-of select="issue"/>
                    </div>
                </div>
                <div class="panelDataRow">
                    <div class="panelDataLabel">Page: </div>
                    <div class="panelDataValue">
                        <xsl:value-of select="fpage"/>
                        <xsl:if test="lpage"> - <xsl:value-of select="lpage"/></xsl:if>
                        <xsl:if test="page-range">, <xsl:value-of select="page-range"/></xsl:if>
                    </div>
                </div>
                <!--<div class="panelDataRow">
                    <div class="panelDataLabel">Print: </div>
                    <div class="panelDataValue">
                        <xsl:value-of select="pub-date[@pub-type = 'print']/@iso-8601-date"/>
                    </div>
                </div>-->
                <div class="panelDataRow">
                    <div class="panelDataLabel">Online: </div>
                    <div class="panelDataValue">
                        <xsl:value-of
                            select="pub-date[contains($digital, @pub-type)]/@iso-8601-date"/>
                    </div>
                </div>
                <xsl:if test="history">
                    <div class="panelDataRow">
                        <div class="panelDataLabel">received: </div>
                        <div class="panelDataValue">
                            <xsl:value-of
                                select="history/date[@date-type = 'received']/@iso-8601-date"/>
                        </div>
                    </div>
                    <div class="panelDataRow">
                        <div class="panelDataLabel">reviewed: </div>
                        <div class="panelDataValue">
                            <xsl:value-of
                                select="history/date[@date-type = 'reviewed']/@iso-8601-date"/>
                        </div>
                    </div>
                    <div class="panelDataRow">
                        <div class="panelDataLabel">accepted: </div>
                        <div class="panelDataValue">
                            <xsl:value-of
                                select="history/date[@date-type = 'accepted']/@iso-8601-date"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:for-each select="article-id[not(@pub-id-type = 'publisher-id')]">
                    <div class="panelDataRow">
                        <div class="panelDataLabel" valign="top"><xsl:value-of select="@pub-id-type"
                            />: </div>
                        <div class="panelDataValue">
                            <xsl:value-of select="."/>
                        </div>
                    </div>
                </xsl:for-each>
                <xsl:for-each select="article-categories/subj-group">
                    <div class="panelDataRow">
                        <div class="panelDataLabel" valign="top">Section: </div>
                        <div class="panelDataValue">
                            <xsl:value-of select="subject"/>
                            <br/>
                            <xsl:for-each select="subj-group/subject">
                                <xsl:value-of select="."/>
                                <br/>
                            </xsl:for-each>
                        </div>
                    </div>
                </xsl:for-each>
                <div class="panelDataRow">
                    <div class="panelDataLabel" valign="top"/>
                    <div class="panelDataValue">
                        <xsl:value-of select="//copyright-statement"/>
                    </div>
                </div>
                <div class="panelDataRow">
                    <div class="panelDataLabel" valign="top"/>
                    <div class="panelDataValue">
                        <b><xsl:value-of select="//custom-meta/meta-value"/>
                            &#160;</b>
                        <xsl:if test="contains(//license-p, '4.0')">
                            <a class="ccby40" href="https://creativecommons.org/licenses/by/4.0/deed.en" target="_blank"><b>CC BY 4.0</b></a>
                        </xsl:if>
                    </div>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    <!-- end: Make ABOUT -->

    <!-- Author-Metadata -->
    <xsl:template name="makeAuthors">
        
        
        
        
        <xsl:variable name="contribution"> contrib com corresp deceased edited-by supported-by </xsl:variable>
        <xsl:variable name="disclosure"/>
        <!-- eingefügt weil nicht definiert -->
        <xsl:for-each select="//article-meta">
            <!-- Affiliations -->
            <xsl:if test="//article-meta//contrib">
                <h5 class="panelContent">Author</h5>

                <!-- <div class="info">
                    <xsl:for-each select="//article-meta//contrib">
                        <xsl:variable name="rid" select="xref[@id]"/>
                        
                        <p class="panelContent jatsRef">
                            <xsl:attribute name="id">author#<xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
                            <b><xsl:if test="name/prefix"><xsl:value-of select="name/prefix"/> </xsl:if>
                            <xsl:value-of select="name/given-names"/> <xsl:value-of select="name/surname"/>
                            <xsl:if test="name/suffix"> <xsl:value-of select="name/suffix"/></xsl:if></b>
                            <xsl:if test="contrib-id[@contrib-id-type='orcid']">
                                <xsl:text>&#160;</xsl:text>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">orcidLogo</xsl:attribute>
                                    <xsl:element name="a">
                                        <xsl:attribute name="target">_new</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
                                        <xsl:copy-of select="$orcidLogo"/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:if>
                            <xsl:text>&#160;</xsl:text>
							
                        <xsl:for-each select="./xref">
							<xsl:variable name="myAff" select="@rid"/>
							<xsl:apply-templates select="//aff[@id = $myAff]"/>
							<br/>
						</xsl:for-each>
						</p>
                    </xsl:for-each>
                </div> -->
				
				<div class="info">
                    <xsl:for-each select="//article-meta//contrib">
                        <!--<xsl:variable name="rid" select="xref[@rid]"/>-->
                        
                        <p class="panelContent jatsRef">
                            <xsl:attribute name="id">author#<xsl:value-of select="position()"></xsl:value-of></xsl:attribute>
                            <b><xsl:if test="name/prefix"><xsl:value-of select="name/prefix"/> </xsl:if>
                            <xsl:value-of select="name/given-names"/><xsl:text>&#160;</xsl:text><xsl:value-of select="name/surname"/>
                            <xsl:if test="name/suffix"> <xsl:value-of select="name/suffix"/></xsl:if></b>
                            <xsl:if test="contrib-id[@contrib-id-type='orcid']">
                                <xsl:text>&#160;</xsl:text>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">orcidLogo</xsl:attribute>
                                    <xsl:element name="a">
                                        <xsl:attribute name="target">_new</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
										<xsl:attribute name="title"><xsl:value-of select="contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
                                        <xsl:copy-of select="$orcidLogo"/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:if>
                            <xsl:text>&#160;</xsl:text>
							
                        <xsl:for-each select="./xref">
							<xsl:variable name="myAff" select="@rid"/>
							<xsl:apply-templates select="//aff[@id = $myAff]"/>
							<br/>
						</xsl:for-each>
						</p>
                    </xsl:for-each>
                </div> 

                <!--<div class="info">
                    <xsl:for-each select="//article-meta//aff"> 
                        <xsl:variable name="rid" select="@id"/>
                        <xsl:variable name="myContrib" select="//contrib[@contrib-type = 'author' and xref/@rid = $rid]"/>
                        <p class="panelContent jatsRef">
                            <xsl:attribute name="id">#<xsl:value-of select="$myContrib/xref/@rid"></xsl:value-of></xsl:attribute>
                            <b><xsl:if test="$myContrib/name/prefix"><xsl:value-of select="$myContrib/name/prefix"/> </xsl:if>
                            <xsl:value-of select="$myContrib/name/given-names"/> <xsl:value-of select="$myContrib/name/surname"/>
                            <xsl:if test="$myContrib/name/suffix"> <xsl:value-of select="$myContrib/name/suffix"/></xsl:if></b>
                            <xsl:if test="$myContrib/contrib-id[@contrib-id-type='orcid']">
                                <xsl:text>&#160;</xsl:text>
                                <xsl:element name="span">
                                    <xsl:attribute name="class">orcidLogo</xsl:attribute>
                                    <xsl:element name="a">
                                        <xsl:attribute name="target">_new</xsl:attribute>
                                        <xsl:attribute name="href"><xsl:value-of select="$myContrib/contrib-id[@contrib-id-type='orcid']"/></xsl:attribute>
                                        <xsl:copy-of select="$orcidLogo"/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:if>
                            <xsl:text>&#160;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:variable name="index" select="position()"/>
                        
                        <xsl:variable name="givenname">
                            <xsl:value-of
                                select="../contrib[@contrib-type = 'author' and xref/@rid = $rid]/name/given-names"
                            />
                        </xsl:variable>
                        <xsl:variable name="surname">
                            <xsl:value-of
                                select="../contrib[@contrib-type = 'author' and xref/@rid = $rid]/name/surname"
                            />
                        </xsl:variable>
                        <div><a href="#" onclick="searchArticlesOfAuthors({$index}, '{$givenname}', '{$surname}')">Search for other articles of <xsl:value-of select="$givenname"></xsl:value-of> <xsl:value-of select="$surname"></xsl:value-of></a></div>

						</p>
                    </xsl:for-each>
                </div>-->
            </xsl:if>
            <!-- Author Notes  -->
            <xsl:if test="author-notes">
                <hr/>
            </xsl:if>
            <xsl:for-each select="author-notes/fn[@fn-type]">
                <xsl:choose>
                    <xsl:when test="contains($contribution, @fn-type)">
                        <xsl:value-of select="substring-after(@id, 'con')"/>
                        <xsl:value-of select="substring-after(@id, 'fn')"/>&#160; <xsl:value-of
                            select="."/>
                    </xsl:when>
                    <xsl:when test="contains($disclosure, @fn-type)">
                        <xsl:apply-templates/>
                    </xsl:when>
                    <!-- warum? -->
                </xsl:choose>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    <!-- end: Make Authors -->

    <!-- Make References -->
    <xsl:template name="makeReferences">
        <xsl:call-template name="makeHeader"/>
        <h5 class="panelContent">References</h5>
        <div class="jatsRefList">
        <xsl:for-each select="//ref-list/ref">
            
            
                
                    <div class="jatsRef">
                        <xsl:attribute name="id"><xsl:value-of select="./@id"/></xsl:attribute>
                        <!--<div class="jatsRefNr">
                            <xsl:choose>
                                <xsl:when test="label">
                                    <xsl:value-of select="label"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="substring-after(@id, 'BR-')"/>
                                    <xsl:value-of select="substring-after(@id, 'ref')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>-->
                        <p class="jatsRefText">
                            <xsl:apply-templates/>
                        </p>
                    </div>
                
            
        </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="source">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <!-- end: Make References -->

    <!-- Related Content -->
    <xsl:template name="makeRelated">
        <!-- PlumX -->
        <script type="text/javascript" src="//cdn.plu.mx/widget-popup.js"></script>
        <xsl:variable name="plumx">https://plu.mx/plum/a/?doi=<xsl:value-of select="//article-id[@pub-id-type='doi']" /></xsl:variable>
        <div>
			<h5 class="panelContent">PlumX Metrics</h5>
            <a class="plumx-plum-print-popup" data-popup="right">
                <xsl:attribute name="href"><xsl:value-of select="$plumx"></xsl:value-of></xsl:attribute>
            </a></div>
        
        <xsl:for-each select="//article-meta">
            <!-- Keywords  
            <xsl:if test="kwd-group">
                <div class="headline">
                    <b>Keywords</b>
                </div>
                <xsl:for-each select="kwd-group/kwd">
                    <xsl:apply-templates/>
                    <xsl:if test="position() != last()"> • </xsl:if>
                </xsl:for-each>
            </xsl:if>-->
            <xsl:if test="related-article">
                <div class="headline">
                    <b>Related Content</b>
                </div>
                <xsl:for-each select="related-article">
                    <a target="_blank">
                        <xsl:attribute name="href">
                            <xsl:value-of select="@xlink:href"/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </a>
                    <br/>
                </xsl:for-each>
            </xsl:if>
        </xsl:for-each>

        <!-- Make recommendation index 
        <div class="headline">
            <b>Links</b>
        </div>
        <a class="menu" href="https://www.oeaw.ac.at/" target="_new">
            <img width="150" alt="vid-logo">
                <xsl:attribute name="src"><xsl:value-of select="$stylePath"
                    />vid-logo.png</xsl:attribute>
            </img>
        </a>
        <br/>
        <a class="menu" href="https://www.oeaw.ac.at/" target="_new">
            <img width="150" alt="oeaw-logo">
                <xsl:attribute name="src"><xsl:value-of select="$stylePath"
                    />oaw-logo.png</xsl:attribute>
            </img>
        </a>
        <br/>
        <br/>
        <a class="menu" href="https://www.oeaw.ac.at/" target="_new" title=" OEAW Publisher ">
            <img alt="">
                <xsl:attribute name="src"><xsl:value-of select="$stylePath"
                    />rightArrow.gif</xsl:attribute>
            </img> ÖAW Verlag </a>
        <br/>
        <a class="menu" href="https://www.oeaw.ac.at/vid/wittgenstein-centre" target="_new">
            <img alt="">
                <xsl:attribute name="src"><xsl:value-of select="$stylePath"
                    />rightArrow.gif</xsl:attribute>
            </img> Wittgenstein Centre </a>
        <br/>
        <br/>-->
    </xsl:template>
    <!-- END: Make Related -->


    <!-- Keyword harvesting  -->
    <xsl:template name="makeKeywords">
        <xsl:for-each select="//subject"><xsl:value-of select="."/>, </xsl:for-each>
    </xsl:template>


    <!-- ============================================= -->
    <!-- Section Heading TEMPLATES -->
    <!--    provide html-anchor for linking -->
    <!--    make sec-title -->
    <!-- ============================================= -->

    <!-- Toplevel Sections -->
    <xsl:template match="sec/title">
        <a class="jatsAnchor">
            <xsl:attribute name="name">
                <xsl:value-of select="parent::sec/@id"/>
            </xsl:attribute>
        </a>
        <!-- sec title -->
        <h2><xsl:value-of select="preceding-sibling::label"/>&#160; <xsl:apply-templates/></h2>
    </xsl:template>

    <!-- 2-level Sections -->
    <xsl:template match="sec/sec/title">
        <a class="jatsAnchor">
            <xsl:attribute name="name">
                <xsl:value-of select="parent::sec/@id"/>
            </xsl:attribute>
        </a>
        <!-- sec title -->
        <h3><xsl:value-of select="preceding-sibling::label"/>&#160; <xsl:apply-templates/></h3>
    </xsl:template>

    <!-- 3-level Sections -->
    <xsl:template match="sec/sec/sec/title">
        <p/>
        <h4><xsl:value-of select="preceding-sibling::label"/>&#160;
            <xsl:apply-templates/>
        </h4>
    </xsl:template>
    <!-- make first p-element inline with title 
    <xsl:template match="sec/sec/sec/p[1]">
        <xsl:apply-templates/>
    </xsl:template>-->

    <!-- Copy ID from JATS to HTML to enable xref-linking -->
    <xsl:template name="copyID">
        <xsl:if test="@id">
            <a class="jatsAnchor">
                <xsl:attribute name="name">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
            </a>
        </xsl:if>
    </xsl:template>
    <!-- end Section Heading TEMPLATES -->



    <!-- ============================================= -->
    <!-- Text &amp; Object LIBRARY -->
    <!-- ============================================= -->

    <!-- Text Production -->
    <!--    produce html-markup for emphasized text  -->
    <!--    produce css-styles for different paragraps  -->
    <!-- ============================================= -->

    <!-- Emphasized Text -->
    <xsl:template match="bold">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="italic">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <xsl:template match="monospace">
        <code>
            <xsl:apply-templates/>
        </code>
    </xsl:template>
    <xsl:template match="underline">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="overline">
        <span style="text-decoration:overline">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="strike">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    <xsl:template match="roman">
        <span style="font-family:Cambria, Times New Roman;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="sans-serif">
        <span style="font-family:NotoSans-Regular, Arial Unicode MS, Arial;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="sub">
        <sub>
            <xsl:apply-templates/>
        </sub>
    </xsl:template>
    <xsl:template match="sup">
        <sup>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    <xsl:template match="sc">
        <span style="text-transform: capitalize">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!-- fixed-case: not supported -->

    <xsl:template match="hr">
        <hr/>
    </xsl:template>
    <xsl:template match="break">
        <br/>
    </xsl:template>


    <!-- Paragraph Templates -->
    <!-- simple paragraphs -->
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- quotes -->
    <xsl:template match="disp-quote">
        <p class="disp-quote">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- dev-list paragraphs (prevent padding-top) -->
    <xsl:template match="def/p">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- produce hoverhelp to show content-type -->
    <xsl:template match="p[@content-type]">
        <p style="cursor:help">
            <xsl:attribute name="class">
                <xsl:value-of select="@content-type"/>
            </xsl:attribute>
            <xsl:attribute name="title">  <xsl:value-of select="@content-type"/>  </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- styled paragraphs (weak, strong, alert) -->
    <xsl:template match="p[@specific-use = 'weak']">
        <p style="margin-top:3px; margin-bottom:3px; color:gray">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="p[@specific-use = 'strong']">
        <p style="margin-top:3px; margin-bottom:3px; color:darkBlue">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="p[@specific-use = 'alert']">
        <p style="margin-top:3px; margin-bottom:3px; color:darkRed">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Page break, used to control the html-printout -->
    <xsl:template match="p[@specific-use = 'page-break']">
        <div style="page-break-after:always;"/>
    </xsl:template>


    <!-- Content Objects Production  -->
    <!--    provide html-anchor for (possible) xref         -->
    <!--    produce relevant and filter irrelevant content -->
    <!-- ============================================= -->

    <!-- Code, Preformat and Verse-->
    <xsl:template match="code | preformat | verse-line">
        <xsl:call-template name="copyID"/>
        <xsl:choose>
            <xsl:when test="@xml:space = 'default'">
                <code>
                    <xsl:apply-templates/>
                </code>
            </xsl:when>
            <xsl:otherwise>
                <pre><xsl:apply-templates/></pre>
            </xsl:otherwise>
        </xsl:choose>
        <!-- ToDo:  catch ext-link, simple-link ?-->
    </xsl:template>


    <!-- Mathematics -->
    <!-- Formula -->
    <xsl:template match="disp-formula-group">
        <xsl:call-template name="copyID"/>
        <div style="margin-top:12px">
            <b><xsl:value-of select="label"/>  <xsl:value-of select="caption"/></b>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="disp-formula">
        <!-- ToDo:  catch label, abstract, keyword-group, alt-text, address-link -->
        <xsl:call-template name="copyID"/>
        <table width="100%" border="0">
            <tbody>
                <tr>
                    <td class="formula">
                        <xsl:attribute name="title">  <xsl:value-of select="alt-text"/>
                             </xsl:attribute>
                        <div style="width: 600px; font-size:0.9rem; overflow-x: auto; ">
                            <xsl:apply-templates/>
                        </div>
                    </td>
                    <xsl:if test="(//counts) and not(//counts/*)">
                        <td width="40" align="right">
                            <b>[<xsl:number level="any"/>]</b>
                        </td>
                    </xsl:if>
                    <xsl:if test=".//label">
                        <td width="40" align="right">
                            <b><xsl:value-of select=".//label"/></b>
                        </td>
                    </xsl:if>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <!-- Tex-Math Implementation for Math-Jax Javascript -->
    <xsl:template match="tex-math">
        <xsl:value-of
            select="substring-after(substring-before(., '\end{document}'), '\begin{document}')"/>
    </xsl:template>
    <!-- MML-Math Implementation for HTML5 -->
    <xsl:template match="mml:math">
        <xsl:copy-of select="."/>
    </xsl:template>


    <!-- Array -->
    <xsl:template match="array">
        <xsl:call-template name="copyID"/>
        <xsl:call-template name="makeHeader"/>
        <table cellpadding="2">
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <!-- Boxed Text -->
    <xsl:template match="boxed-text">
        <xsl:call-template name="copyID"/>
        <div style="margin-top:12px; padding:3px; border:solid 1px gray">
            <b><xsl:value-of select="label"/>  <xsl:value-of select="caption"/></b>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Chemical Structure -->
    <xsl:template match="chem-struct-wrap">
        <xsl:call-template name="copyID"/>
        <xsl:call-template name="makeHeader"/>
        <xsl:apply-templates/>
        <!-- ToDo:  catch alt-text -->
    </xsl:template>


    <!-- Figure -->
    <xsl:template match="fig-group">
        <xsl:call-template name="copyID"/>
        <div style="margin-top:12px">
            <b><xsl:value-of select="label"/>  <xsl:value-of select="caption"/></b>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="fig">
        <!-- ToDo:  catch abstract, keyword-group, alt-text, ext-link -->
        <xsl:call-template name="copyID"/>
        <xsl:call-template name="makeHeader"/>
        <xsl:apply-templates select="graphic | media"/>
        <xsl:call-template name="makeFooter"/>
    </xsl:template>

    <xsl:template match="fig" mode="panel">
        <!-- ToDo:  catch abstract, keyword-group, alt-text, ext-link -->
        <!-- xsl:call-template name="copyID"/ -->
        <xsl:call-template name="makeHeaderPanel"/>
        <xsl:apply-templates select="graphic | media" mode="panel"/>
        <xsl:call-template name="makeFooter"/>
    </xsl:template>

    <!-- Graphic -->
    <xsl:template match="graphic | media">
        <!-- Create img-attributes   -->
		
		
		<xsl:variable name="imgPathOne"><xsl:value-of select="$issuesPath"/></xsl:variable>
		<xsl:variable name="imgPathTwo"><xsl:value-of select="translate(//journal-title,' ','_')"></xsl:value-of>/</xsl:variable>
		<xsl:variable name="imgPathThree"><xsl:value-of select="substring-before(//self-uri/@xlink:href,'.pdf')"/>/</xsl:variable>
		<xsl:variable name="imgPath">
			<xsl:value-of select="$imgPathOne"/>
			<xsl:value-of select="$imgPathTwo"/>
			<xsl:value-of select="$imgPathThree"/>
		</xsl:variable>
        <xsl:variable name="src">
			<xsl:value-of select="$imgPath"/>
            <xsl:if test="not(contains(@xlink:href, 'files/'))">files/</xsl:if>
            <xsl:value-of select="@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="class">
            <xsl:if test="@specific-use = 'border'">hasBorder </xsl:if> imgClass </xsl:variable>
        <!-- Create ref-ID -->
        <xsl:call-template name="copyID"/>
        <!-- Center Image -->
        <div style="width:90%; margin-top:1em; margin-left:auto; margin-right:auto;">
            <a target="_blank">
                <xsl:attribute name="href">
                    <xsl:value-of select="$src"/>
                </xsl:attribute>
                <img>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$src"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">img-JATS <xsl:value-of select="$class"
                        /></xsl:attribute>
                    <xsl:attribute name="alt">  <xsl:value-of select="alt-text"/>   </xsl:attribute>
                </img>
            </a>
        </div>
    </xsl:template>
    <xsl:template match="graphic | media" mode="panel">
        <!-- Create img-attributes   -->
		<xsl:variable name="imgPathOne"><xsl:value-of select="$issuesPath"/></xsl:variable>
		<xsl:variable name="imgPathTwo"><xsl:value-of select="translate(//journal-title,' ','_')"></xsl:value-of>/</xsl:variable>
		<xsl:variable name="imgPathThree"><xsl:value-of select="substring-before(//self-uri/@xlink:href,'.pdf')"/>/</xsl:variable>
		<xsl:variable name="imgPath">
			<xsl:value-of select="$imgPathOne"/>
			<xsl:value-of select="$imgPathTwo"/>
			<xsl:value-of select="$imgPathThree"/>
		</xsl:variable>
        <xsl:variable name="src">
			<xsl:value-of select="$imgPath"/>
            <xsl:if test="not(contains(@xlink:href, 'files/'))">files/</xsl:if>
            <xsl:value-of select="@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="class">
            <xsl:if test="@specific-use = 'border'">hasBorder </xsl:if> imgClass </xsl:variable>
        <!-- 
		No ref-ID
		<xsl:call-template name="copyID"/> 
		-->
        <!-- Center Image -->
        <div style="width:90%; margin-top:1em; margin-left:auto; margin-right:auto;">
            <a target="_blank">
                <xsl:attribute name="href">
                    <xsl:value-of select="$src"/>
                </xsl:attribute>
                <img>
                    <xsl:attribute name="src">
                        <xsl:value-of select="$src"/>
                    </xsl:attribute>
                    <xsl:attribute name="class">img-JATS <xsl:value-of select="$class"
                        /></xsl:attribute>
                    <xsl:attribute name="alt">  <xsl:value-of select="alt-text"/>   </xsl:attribute>
                </img>
            </a>
        </div>
    </xsl:template>
    <!-- Inline-Graphic -->
    <xsl:template match="inline-graphic">
		<xsl:variable name="imgPathOne"><xsl:value-of select="$issuesPath"/></xsl:variable>
		<xsl:variable name="imgPathTwo"><xsl:value-of select="translate(//journal-title,' ','_')"></xsl:value-of>/</xsl:variable>
		<xsl:variable name="imgPathThree"><xsl:value-of select="substring-before(//self-uri/@xlink:href,'.pdf')"/>/</xsl:variable>
		<xsl:variable name="imgPath">
			<xsl:value-of select="$imgPathOne"/>
			<xsl:value-of select="$imgPathTwo"/>
			<xsl:value-of select="$imgPathThree"/>
		</xsl:variable>
        <xsl:variable name="src">
			<xsl:value-of select="$imgPath"/>
            <xsl:if test="not(contains(@xlink:href, 'files/'))">files/</xsl:if>
            <xsl:value-of select="@xlink:href"/>
        </xsl:variable>
        <img alt="" class="inlineImg">
            <xsl:attribute name="src">
                <xsl:value-of select="$src"/>
            </xsl:attribute>
        </img>
    </xsl:template>


    <!-- List -->
    <xsl:template match="list">
        <xsl:variable name="ul"> disc circle square none </xsl:variable>
        <xsl:variable name="ol"> decimal lower-roman upper-roman lower-alpha upper-alpha </xsl:variable>
        <xsl:call-template name="copyID"/>
        <xsl:call-template name="makeHeader"/>
        <xsl:choose>
            <xsl:when test="not(@list-type)">
                <ul style="margin-top:6px">
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="contains($ul, @list-type)">
                <ul>
                    <xsl:attribute name="style">list-style-type:<xsl:value-of select="@list-type"
                        />;</xsl:attribute>
                    <xsl:apply-templates/>
                </ul>
            </xsl:when>
            <xsl:when test="contains($ol, @list-type)">
                <ol>
                    <xsl:attribute name="style">list-style-type:<xsl:value-of select="@list-type"
                        />;</xsl:attribute>
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:when test="contains(@list-type, 'roman-upper')">
                <ol style="list-style-type:upper-roman">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:when test="contains(@list-type, 'roman-lower')">
                <ol style="list-style-type:lower-roman">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:when test="contains(@list-type, 'alpha-upper')">
                <ol style="list-style-type:upper-alpha">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:when test="contains(@list-type, 'alpha-lower')">
                <ol style="list-style-type:lower-alpha">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:when test="contains(@list-type, 'order')">
                <ol style="list-style-type:decimal">
                    <xsl:apply-templates/>
                </ol>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="list-item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <!-- Definition List -->
    <xsl:template match="def-list">
        <xsl:call-template name="copyID"/>
        <p>
            <xsl:call-template name="makeHeader"/>
        </p>
        <table>
            <xsl:if test="term-head | def-head">
                <tr>
                    <td>   </td>
                    <th>   <xsl:apply-templates select="term-head"/>   </th>
                    <th>   <xsl:apply-templates select="def-head"/>   </th>
                </tr>
            </xsl:if>
            <xsl:apply-templates select="def-item"/>
        </table>
        <div style="margin-left:18px">
            <xsl:apply-templates select="def-list"/>
        </div>
    </xsl:template>
    <xsl:template match="def-item">
        <tr valign="top">
            <td align="right">
                <xsl:choose>
                    <xsl:when test="../../def-list/@list-type = 'decimal'"><xsl:number format="1"
                            level="single"/>.</xsl:when>
                    <xsl:when test="../../def-list/@list-type = 'lower-alpha'"><xsl:number
                            format="a" level="single"/>.</xsl:when>
                    <xsl:when test="../../def-list/@list-type = 'lower-roman'"><xsl:number
                            format="i" level="single"/>.</xsl:when>
                    <xsl:otherwise>•   </xsl:otherwise>
                </xsl:choose>
            </td>
            <td>
                <xsl:apply-templates select="term"/>
            </td>
            <td>
                <xsl:apply-templates select="def"/>
            </td>
        </tr>
    </xsl:template>


    <!-- Table: (always inside table-wrap) -->
    <xsl:template match="table-wrap">
        <xsl:call-template name="copyID"/>
        <xsl:call-template name="makeHeader"/>
        <div class="_table_div">
            <xsl:attribute name="id" value="@id"/>  
        <p style="_table-wrap">
            <xsl:apply-templates/>
        </p>
        </div>
    </xsl:template>
    <!-- table -->
    <xsl:template match="table | thead | tbody | tfoot | colgroup | tr | th | td">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <!-- Heading and Trailer Production -->
    <!-- ============================================= -->
    <xsl:template match="title">
        <p class="jatsTitle">
            <!--<xsl:value-of select="."/>-->
			<xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Conditional Label, Capture and Title production -->
    <xsl:template name="makeHeader">
        <xsl:variable name="lab">
            <xsl:value-of select="translate(label, ' ', '&#160;')"/>
        </xsl:variable>
        <xsl:if test="label | title | caption/title">
        <p class="jatsHeader">
            <xsl:if test="label">
                <div class="jatsHeaderLabel"><xsl:value-of select="$lab"/>&#160;</div>
            </xsl:if>
            <!--<div class="jatsHeaderTitle">
                <xsl:value-of select="title"/>
                <xsl:value-of select="caption/title"/>
            </div>-->
            <div class="jatsHeaderTitle">
                <xsl:apply-templates select="title"/>
                <xsl:apply-templates select="caption/title"/>
            </div>	
        </p>
        </xsl:if>
    </xsl:template>
    <xsl:template name="makeHeaderPanel">
        <xsl:variable name="lab">
            <xsl:value-of select="translate(label, ' ', '&#160;')"/>
        </xsl:variable>
        <p class="jatsHeader">
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="ancestor-or-self::fig/@id"/>
                </xsl:attribute>
                <xsl:if test="label">
                    <div class="jatsHeaderLabel"><xsl:value-of select="$lab"/>&#160;</div>
                </xsl:if>
                <div class="jatsHeaderTitle">
                    <xsl:value-of select="title"/>
                    <xsl:value-of select="caption/title"/>
                </div>
            </a>
        </p>
    </xsl:template>
    <xsl:template name="makeFooter">
        <p class="jatsFooter">
            <!-- different notations possible -->
            <xsl:apply-templates select="p"/>
            <xsl:apply-templates select="caption/p"/>
            <xsl:apply-templates select="attrib"/>
        </p>
    </xsl:template>

    <!-- Filter template: catch label, caption, title and others,
	  (they will always be produced directly) -->
    <xsl:template
        match="
            label | caption | list/title | list-item/title | def-list/title
            | object-id | author-notes | alt-text | abstract | kwd-group"/>



    <!-- References and Link Production -->
    <!-- ============================================= -->

    <!-- External link -->
    <xsl:template match="ext-link">
        <!-- xsl:choose>
		<xsl:when test="@ext-link-type = 'pdf' "><img src="/test/VYPRxml2018test/img/pdf.gif" alt=""/> </xsl:when>
		<xsl:when test="@ext-link-type = 'word' "><img src="/test/VYPRxml2018test/img/word.gif" alt=""/> </xsl:when>
		<xsl:when test="@ext-link-type = 'ppt' "><img src="/test/VYPRxml2018test/img/ppt.gif" alt=""/> </xsl:when>
		<xsl:when test="@ext-link-type = 'excel' "><img src="/test/VYPRxml2018test/img/excel.gif" alt=""/></xsl:when>
		<xsl:when test="@ext-link-type = 'image' "><img src="/test/VYPRxml2018test/img/image.gif" alt=""/></xsl:when>
		<xsl:otherwise><img src="img/pfeil.gif" alt=""/> </xsl:otherwise>
	</xsl:choose -->
        <a target="_blank">
            <xsl:choose>
                <xsl:when test="@ext-link-type = 'doi'">
                    <xsl:attribute name="class">jatsDoi</xsl:attribute>
                    <xsl:attribute name="href">https://dx.doi.org/<xsl:value-of select="@xlink:href"
                        /></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">jatsLink</xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::ref-list"><!--<xsl:text>→</xsl:text>--><span class="textXs"><xsl:value-of select="."/></span></xsl:when>
                <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
            
            <xsl:if test=". = ''">
                <xsl:value-of select="@xlink:href"/>
            </xsl:if>
        </a>
    </xsl:template>

    <xsl:template match="pub-id[@pub-id-type = 'doi']">
        <a target="_blank">
            <xsl:attribute name="class">jatsDoi</xsl:attribute>
            <xsl:attribute name="href">https://dx.doi.org/<xsl:value-of select="."/></xsl:attribute>
            <xsl:value-of select="."/>
        </a>
    </xsl:template>


    <!-- Internal link (xref) -->
    <xsl:template match="xref">
        <xsl:param name="rid" select="@rid"/>
        <xsl:choose>
            <xsl:when test="(@ref-type = 'fn')">
                <sup class="helpFn">
                    <!-- xsl:attribute name="title"> <xsl:value-of select="normalize-space(//node()[@id = $rid])"/> </xsl:attribute -->
                    <xsl:attribute name="title"> <xsl:apply-templates
                            select="//node()[@id = $rid]/*" mode="short"/> </xsl:attribute>
                    <xsl:value-of select="."/>
                </sup>
            </xsl:when>
            <xsl:when test="(@ref-type = 'bibr')">
                <a class="helpXref">
                    <!-- xsl:attribute name="title"> <xsl:value-of select="normalize-space(//node()[@id = $rid])"/> </xsl:attribute -->
                    <xsl:attribute name="title"> <xsl:apply-templates
                            select="//node()[@id = $rid]/*" mode="short"/> </xsl:attribute>
                    <xsl:attribute name="href">#<xsl:value-of select="$rid"/></xsl:attribute>
                    <xsl:attribute name="onclick">openInfo(event, 'Authors')</xsl:attribute>
                    <!-- Verlinken mit Quellenangabe -->
                    <xsl:value-of select="."/>
                    <!--<xsl:value-of select="substring-after($rid, 'ref')"/><xsl:text/>-->
                    <!-- xsl:value-of select="."/ -->
                    <!-- VYPR -->
                </a>
            </xsl:when>
            <xsl:when test="(@ref-type = 'kwd')">
                <span>
                    <xsl:attribute name="class">jatsXref</xsl:attribute>
                    <xsl:attribute name="title"> <xsl:value-of select="//back//p[@id = $rid]"
                        /> </xsl:attribute>
                    <xsl:value-of select="."/>
                </span>
            </xsl:when>
            <!-- xsl:when test="@ref-type = 'other' " -->
            <xsl:when test="contains('fig table other', @ref-type)">
                <a>
                    <xsl:attribute name="class">jatsXref</xsl:attribute>
                    <xsl:attribute name="href">#<xsl:value-of select="@rid"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- Back-Content Production -->
    <!-- ============================================= -->

    <!-- Acknowledgements -->
    <xsl:template match="ack">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Footnotes -->
    <xsl:template match="notes">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="fn-group">
        <xsl:call-template name="makeHeader"/>
        <div class="jatsFnGroup">
            <xsl:for-each select="fn">
                <div class="jatsFn">
                    <div class="jatsFnNr">
                        <xsl:choose>
                            <xsl:when test="label">
                                <xsl:value-of select="label"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-after(@id, 'FN-')"/>
                                <xsl:value-of select="substring-after(@id, 'fn-')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <div class="jatsFnText">
                        <xsl:apply-templates/>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="//title-group//fn">
        <div class="jatsFn">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Bibliography -->
    <xsl:template match="ref-list">
        <!--<xsl:call-template name="makeHeader"/>
        <div class="jatsRefList">
            <xsl:for-each select="p | ref">
                <div class="jatsRef">
                    <div class="jatsRefNr">
                        <xsl:choose>
                            <xsl:when test="label">
                                <xsl:value-of select="label"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="substring-after(@id, 'BR-')"/>
                                <xsl:value-of select="substring-after(@id, 'ref')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <div class="jatsRefText">
                        <xsl:apply-templates/>
                    </div>
                </div>
            </xsl:for-each>
        </div>-->
    </xsl:template>

    <!-- Shortform of citation for hoverhelp -->
    <xsl:template match="p" mode="short">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="element-citation | mixed-citation" mode="short">
        <xsl:for-each select=".//surname">
            <xsl:value-of select="."/><xsl:text/>
            <xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
        <xsl:value-of select=".//collab"/> <xsl:text/> (<xsl:value-of select="year"/>) <xsl:value-of
            select="article-title"/> <xsl:text/>
        <xsl:value-of select="source"/><xsl:text/>
        <xsl:value-of select="volume"/> <xsl:text/>
        <xsl:value-of select="fpage"/>–<xsl:value-of select="lpage"/>
    </xsl:template>
    <!-- Filter Template -->
    <xsl:template match="label" mode="short"/>

    <!-- Longform of citation -->
    <xsl:template match="element-citation">
        <xsl:variable name="lowercase">abcdefghijklmnopqrstuvwxyz</xsl:variable>
        <xsl:for-each select="person-group/name | person-group/etal | collab">
            <xsl:choose>
                <!-- Is it a name ? -->
                <xsl:when test="surname">
                    <xsl:value-of select="surname"/>, <xsl:choose>
                        <!-- Are there a @initials? Full stop between letters assumed -->
                        <xsl:when test="@initials"><xsl:value-of select="@initials"/></xsl:when>
                        <!-- Is there only one initial in given-names? -->
                        <xsl:when test="string-length(normalize-space(given-names)) = '1'">
                            <xsl:value-of select="given-names"/>.<xsl:text/>
                        </xsl:when>
                        <!-- Are there lowercase letters in given-names? -->
                        <xsl:when test="contains($lowercase, substring(given-names, 2, 1))">
                            <xsl:value-of select="given-names"/>
                        </xsl:when>
                        <!-- Are there two initials in given-names? -->
                        <xsl:when test="string-length(normalize-space(given-names)) = '2'">
                            <xsl:value-of select="substring(given-names, 1, 1)"/>. <xsl:value-of
                                select="substring(given-names, 2, 1)"/>.<xsl:text/>
                        </xsl:when>
                        <!-- Are there three initials in given-names? -->
                        <xsl:when test="string-length(normalize-space(given-names)) = '3'">
                            <xsl:value-of select="substring(given-names, 1, 1)"/>. <xsl:value-of
                                select="substring(given-names, 2, 1)"/>. <xsl:value-of
                                select="substring(given-names, 3, 1)"/>.<xsl:text/>
                        </xsl:when>
                        <!-- ??? -->
                        <xsl:otherwise>
                            <xsl:value-of select="given-names"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:when>
                <!-- otherwise it is a collaboration or etal -->
                <xsl:otherwise>
                    <xsl:if test="../etal"><i>et al.</i>, </xsl:if>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:if test="year"> (<xsl:value-of select="year"/>) </xsl:if>
        <xsl:if test="source"> <i><xsl:value-of select="source"/></i> </xsl:if>
        <xsl:if test="publisher-name"> (<xsl:value-of select="publisher-name"/>
            <xsl:if test="publisher-loc">, <xsl:value-of select="publisher-loc"/></xsl:if>)</xsl:if>
        <xsl:if test="volume"> <b><xsl:value-of select="volume"/></b>, </xsl:if>
        <xsl:if test="issue"> <b><xsl:value-of select="issue"/></b>, </xsl:if>
        <xsl:if test="fpage">
            <xsl:if test="../element-citation/@publication-type = 'book'"> pp.</xsl:if>
                 <xsl:value-of select="fpage"/>
        </xsl:if>
        <xsl:if test="lpage">–<xsl:value-of select="lpage"/></xsl:if>. </xsl:template>

    <!-- Glossary -->
    <xsl:template match="glossary">
        <xsl:call-template name="makeHeader"/>
        <div class="jatsGlossary">
            <xsl:apply-templates select="p | glossary"/>
        </div>
    </xsl:template>



    <!-- =============================================   -->
    <!--  HTML Preparation (Metadata, CSS-Styles, Website-Navigation) -->
    <!-- =============================================   -->

    <!--  HTML Metadata  -->
    <xsl:template name="makeMetadata">
        <xsl:variable name="description">
            <xsl:value-of select="//article-meta/title-group/article-title"/>. <xsl:value-of
                select="//article-meta/title-group/subtitle"/>
        </xsl:variable>
        <title>JATS <xsl:value-of select="//article-meta/title-group/alt-title"/></title>
        <!-- meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta -->
        <meta name="description">
            <xsl:attribute name="content">
                <xsl:value-of select="$description"/>
            </xsl:attribute>
        </meta>
        <meta name="keywords">
            <xsl:attribute name="content">
                <xsl:call-template name="makeKeywords"/>
            </xsl:attribute>
        </meta>
        <!-- Dublin-Core Metatags -->
        <meta name="DC.Type" content="text"/>
        <meta name="DC.Title">
            <xsl:attribute name="content">
                <xsl:value-of select="$description"/>
            </xsl:attribute>
        </meta>
        <meta name="DC.Subject">
            <xsl:attribute name="content">
                <xsl:call-template name="makeKeywords"/>
            </xsl:attribute>
        </meta>
        <meta name="DC.Description">
            <xsl:attribute name="content">
                <xsl:value-of select="$description"/>
            </xsl:attribute>
        </meta>
        <meta name="DC.Format" content="text/html"/>
        <meta name="DC.Identifier">
            <xsl:attribute name="content"> https://doi.org/<xsl:value-of
                    select="//article-meta[1]/article-id[@pub-id-type = 'doi']"/>
            </xsl:attribute>
        </meta>
        <meta name="DC.Language" content="en"/>
        <meta name="DC.Creator" content="Verlag der Österreichischen Akademie der Wissenschaften"/>
        <meta name="DC.Publisher" content="Verlag der Österreichischen Akademie der Wissenschaften"/>
        <meta name="DC.Rights" content="Österreichische Akademie der Wissenschaften"/>
        <meta name="DC.Relation" content="Elektronische Publikation"/>
    </xsl:template>

    <!--  CSS  -->
    <xsl:template name="makeCSS">
        <style type="text/css">
	:root {
	--Text: <xsl:value-of select="$Text"/>;
	--iText: <xsl:value-of select="$iText"/>;
	--menu: <xsl:value-of select="$menu"/>;
	--title: <xsl:value-of select="$title"/>;
	--navi: <xsl:value-of select="$navi"/>;
	--media: <xsl:value-of select="$media"/>;
	--kernfarbe: <xsl:value-of select="$kernfarbe"/>;
	--stylePath: <xsl:value-of select="$stylePath"/>;
	--journalHeader: <xsl:value-of select="$journalHeader"/>;
	
	}
</style>

        <style>
            .citeBox,
            .citeForm {
                visibility: hidden;
            }</style>

        <link rel="stylesheet" type="text/css">
            <xsl:attribute name="href">
                <xsl:value-of select="$simpleJATSresponsiveCSS"/>
            </xsl:attribute>
        </link>
        <script language="javascript">
		<xsl:attribute name="src"><xsl:value-of select="$simpleJATSresponsiveJS"/></xsl:attribute>
	</script>
        <script language="javascript" src="/buecher/files/Vienna_Yearbook_of_Population_Research_/_style/journal-cite.js"/>

    </xsl:template>


    <!--  OEAW Top Navigation  -->
    <xsl:template name="makeTopNavi">
        <!--  
<div id="topNavi">
	<a href="https://www.oeaw.ac.at/vid/publications/serial-publications/vienna-yearbook-of-population-research">Home</a> | 
	<a href="https://www.oeaw.ac.at/vid/research/research-projects">Research Projects</a> | 
	<a href="https://www.oeaw.ac.at/vid/publications/annual-publication-lists">Publications</a> | 
</div>
	-->
    </xsl:template>

    <xsl:template name="format-date">
        <!-- Quelle: https://stackoverflow.com/questions/57615867 -->
        <xsl:param name="date"/>
        <!-- day -->
        <xsl:value-of select="number(substring($date, 9, 2))"/>
        <xsl:text>&#160;</xsl:text>
        <!-- month -->
        <xsl:variable name="m" select="substring($date, 6, 2)"/>
        <xsl:value-of
            select="translate(substring('January..February.March....April....May......June.....July.....August...SeptemberOctober..November.December.', 9 * ($m - 1) + 1, 9), '.', '')"/>
        <xsl:text>&#160;</xsl:text>
        <!-- year -->
        <xsl:value-of select="substring($date, 1, 4)"/>
    </xsl:template>

    <xsl:template name="dropDownBox">
        <xsl:param name="title"/>
        <xsl:param name="myController"/>
        <xsl:param name="myId"/>
        <xsl:text disable-output-escaping="yes">&lt;button @click="</xsl:text>
        <xsl:copy-of select="$myController"/>
        <xsl:text disable-output-escaping="yes"> = !</xsl:text>
        <xsl:copy-of select="$myController"/>
        <xsl:text disable-output-escaping="yes">" class="dropDownBoxButton"&gt;
          &lt;span&gt;</xsl:text>
        <xsl:copy-of select="$title"/>
        <xsl:text disable-output-escaping="yes">&lt;/span&gt;
          &lt;svg fill="currentColor" viewBox="0 0 20 20" :class="{'rotate-180': </xsl:text>
        <xsl:copy-of select="$myController"/>
        <xsl:text disable-output-escaping="yes">, 'rotate-0': !</xsl:text>
        <xsl:copy-of select="$myController"/>
        <xsl:text disable-output-escaping="yes">}" class="naviArrow"&gt;&lt;path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"&gt;&lt;/path&gt;&lt;/svg&gt;
        &lt;/button&gt;&lt;/div&gt;
        &lt;div  class="dropDownBox" x-show="</xsl:text>
        <xsl:copy-of select="$myController"/>
        <xsl:text disable-output-escaping="yes">" x-transition:enter="transition ease-out duration-100" x-transition:enter-start="transform opacity-0 scale-95" x-transition:enter-end="transform opacity-100 scale-100" x-transition:leave="transition ease-in duration-75" x-transition:leave-start="transform opacity-100 scale-100" x-transition:leave-end="transform opacity-0 scale-95"&gt;
			&lt;div id="</xsl:text>
        <xsl:copy-of select="$myId"/>
        <xsl:text disable-output-escaping="yes">"&gt;&lt;/div&gt;
	</xsl:text>
    </xsl:template>


    <xsl:template match="title[parent::abstract]"/>

</xsl:stylesheet>
