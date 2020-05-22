<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output encoding="UTF-8" method="html" ></xsl:output>
    <xsl:variable name="textchunk" select="'ab'"/>
    <xsl:variable name="chunkTitle" select="'Priapea'"/>
    <xsl:template match="TEI">
        <html lang="en">
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <!-- Bootstrap CSS -->
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous" />
                <title>Priapea</title>
                <style type="text/css">
                    span { display:inline; }
                    ol.li { }
                    dl.data {
                        display:none;
                    }
                    em {
                    font-style: normal;
                    }
                    .NOM { color: rgb(43, 114, 124); }
                    .ADJ { color: blue; }
                    .VER { color: red; }
                    .PRO { color: purple; }
                    .ADV { color: darkorange; }
                    .PRE { color: green; }
                    .CON { color: darkpink; }
                    section {
                        padding: 1em;
                        margin: 1em;
                        background-color: white;
                        border-radius: 1em;
                    }
                    body {                
                        background-color: #f8f9fa;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <section>
                                <h1>Welcome</h1>
                                <p>This page contains lemmatization and morphosyntactic information compiled by ...</p>
                            </section>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                           <xsl:for-each select=".//*[name() = $textchunk]">
                               <xsl:call-template name="chunk">
                                   <xsl:with-param name="current" select="current()"/>
                                   <xsl:with-param name="title" select="position()"/>
                               </xsl:call-template>
                           </xsl:for-each>
                        </div>
                        <div class="col-md-5 offset-md-1">
                            <div class="sticky-top">
                                <section id="receiver">
                                    <h1></h1>
                                    <div class="content"></div>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                    
                    document.addEventListener("DOMContentLoaded", function() {     
                        const div = document.querySelector("#receiver div");     
                        const h1 = document.querySelector("#receiver h1");
                        const body = document.querySelector('body'); 
                        body.addEventListener('mouseover', function(event) {
                            // find the closest parent of the event target that
                            // matches the selector
                            var em = event.target.closest("em");
                            if (em &amp;&amp; body.contains(em)) {
                                // handle class event
                                div.innerHTML = "<dl><dt>Lemma</dt><dd>"+em.getAttribute("data-lemma")+"</dd><dt>POS</dt><dd>"+em.getAttribute("data-pos")+"</dd><dt>Morphology</dt><dd>"+em.getAttribute("data-morph")+"</dd></dl>";
                                h1.innerHTML = em.innerText;
                            }
                        });// End hover
                    }); // End DOM
                    
                </script>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="chunk">
        <xsl:param name="current" />
        <xsl:param name="title" select="''" />
        <section class="">
            <h1><xsl:value-of select="string-join(($chunkTitle, $title), ' ')" /></h1>
            <xsl:choose>
                <xsl:when test="$current/l">
                    <ol>
                        <xsl:apply-templates select="$current/child::*" />
                    </ol>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <xsl:apply-templates select="$current/child::*" />
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </section>
    </xsl:template>
    <xsl:template match="l">
        <li><xsl:apply-templates/> </li>
    </xsl:template>
    <xsl:template match="w">
        <em>
            <xsl:attribute name="class" select=" substring(@pos, 1, 3)"/>
            <xsl:attribute name="data-lemma" select="@lemma"/>
            <xsl:attribute name="data-morph" select="@msd"/>
            <xsl:attribute name="data-pos" select="@pos"/>
            <xsl:value-of select="text()" />
        </em><xsl:text> </xsl:text>
    </xsl:template>
</xsl:stylesheet>