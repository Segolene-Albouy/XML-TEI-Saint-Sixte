<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <!-- TEMPLATE PAGES HTML -->
    <xsl:template match="/">
        <!-- DEFINITION DES VARIABLES DE NOMS DE FICHIERS DE SORTIE -->
        <xsl:variable name="path-index">
            <xsl:text>index.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-edition">
            <xsl:text>edition.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-facsimile">
            <xsl:text>facsimile-interactif.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-textometry">
            <xsl:text>textometrie.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-catalogue-record">
            <xsl:text>notice.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-biblio">
            <xsl:text>bibliographie.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-about">
            <xsl:text>a-propos.html</xsl:text>
        </xsl:variable>

        <!-- DEFINITION DES VARIABLES UTILES -->
        <xsl:variable name="jumbotron">
            <xsl:value-of select="//surface[1]/graphic/@url"/>
        </xsl:variable>
        <xsl:variable name="title">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="shelfmark">
            <xsl:value-of select="//msIdentifier/idno"/>
        </xsl:variable>
        <xsl:variable name="library">
            <xsl:value-of select="//msIdentifier/repository"/>
        </xsl:variable>

        <!-- PAGE D'ACCUEIL -->
        <xsl:result-document href="{$path-index}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Accueil')"/>
                    </title>
                    <style type="text/css">
                        .jumbotron {
                            background-position: center -180px;
                            background-size: 120%, auto;
                            color: white;
                            text-shadow: black 1px 0 10px;
                        }</style>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                        <div class="jumbotron" style="background-image:  url({$jumbotron})">
                            <h1 class="display-4">
                                <xsl:value-of select="$title"/>
                            </h1>
                            <p class="lead">
                                <em><xsl:value-of select="//msItem/incipit"/></em>
                            </p>
                        </div>
                        <div class="offset-md-3 col-md-6 offset-sm-2 col-sm-8 text-center">
                            <p class="lead text-muted container">Bienvenue sur l'édition numérique
                                de la <xsl:value-of select="$title"/> issu du manuscrit
                                    <xsl:value-of select="$shelfmark"/>, conservé à la <xsl:value-of
                                    select="$library"/></p>
                        </div>

                        <div class="container">
                            <div class="row text-center" style="place-content: center; padding: 1em">
                                <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-edition}" style="color: black;">Transcription du manuscrit</a>
                                </button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-facsimile}" style="color: black;">Fac-similé
                                        interactif</a>
                                </button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-textometry}" style="color: black;">Analyse
                                        textométrique</a>
                                </button>
                            </div>
                            </div>
                            <div class="row text-center" style="place-content: center; padding: 1em">
                                <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-catalogue-record}" style="color: black;">Notice du manuscrit</a>
                                </button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-biblio}" style="color: black;">Bibliographie sélective</a>
                                </button>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-light">
                                    <a href="{$path-about}" style="color: black;">À propos du projet</a>
                                </button>
                            </div>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- PAGE ÉDITION -->
        <xsl:result-document href="{$path-edition}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Édition')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container p-4">
                        <div class="row">
                            <div class="col-md-6">
                                <h2>Transcription diplomatique</h2>
                                <xsl:apply-templates select="TEI//body//p" mode="original-version"/>
                            </div>
                            <div class="col-md-6">
                                <h2>Transcription modernisée</h2>
                                <xsl:apply-templates select="TEI//body//p" mode="normalised-version"/>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!--  PAGE TEXTOMETRIE -->
        <xsl:result-document href="{$path-textometry}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"/>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"/>
                    
                    <!-- Tentative de faire des super popUp :'( -->
                    <!--<style>
                        /* Popup container */
                        .popup {
                        position: relative;
                        display: inline-block;
                        cursor: pointer;
                        -webkit-user-select: none;
                        -moz-user-select: none;
                        -ms-user-select: none;
                        user-select: none;
                        }
                        
                        /* The actual popup */
                        .popup .popuptext {
                        visibility: hidden;
                        width: auto;
                        background-color: rgb(92, 112, 112, 0.85);
                        color: #fff;
                        text-align: center;
                        border-radius: 6px;
                        position: absolute;
                        z-index: 1;
                        bottom: 125%;
                        left: 50%;
                        margin-left: -80px;
                        padding: 1em;
                        }
                        
                        /* Popup arrow */
                        .popup .popuptext::after {
                        content: "";
                        position: absolute;
                        top: 100%;
                        left: 50%;
                        margin-left: -5px;
                        border-width: 5px;
                        border-style: solid;
                        border-color:  rgb(92, 112, 112, 0.85) transparent transparent transparent;
                        }
                        
                        /* Toggle this class - hide and show the popup */
                        .popup .show {
                        visibility: visible;
                        -webkit-animation: fadeIn 1s;
                        animation: fadeIn 1s;
                        }
                        
                        /* Add animation (fade in the popup) */
                        @-webkit-keyframes fadeIn {
                        from {opacity: 0;} 
                        to {opacity: 1;}
                        }
                        
                        @keyframes fadeIn {
                        from {opacity: 0;}
                        to {opacity:1 ;}
                        }
                    </style>
                    <xsl:apply-templates select="TEI//body//persName" mode="script"/>-->
                    
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Index textométrique')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="perso-tab" data-toggle="tab"
                                    href="#perso" role="tab" aria-controls="home"
                                    aria-selected="true">Personnages</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="place-tab" data-toggle="tab" href="#place"
                                    role="tab" aria-controls="profile" aria-selected="false"
                                    >Lieux</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="talk-tab" data-toggle="tab" href="#talk"
                                    role="tab" aria-controls="contact" aria-selected="false">Prise
                                    de parole</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="perso" role="tabpanel"
                                aria-labelledby="perso-tab">
                                <div class="col-md-10 col-md-offset-2">
                                    <xsl:call-template name="textometry-perso"/>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="place" role="tabpanel"
                                aria-labelledby="place-tab">
                                <div class="col-md-10 col-md-offset-2">
                                    <xsl:call-template name="textometry-place"/>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="talk" role="tabpanel"
                                aria-labelledby="talk-tab">
                                    <xsl:call-template name="textometry-parole"/>
                            </div>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!--  PAGE DE FACSIMILE INTERACTIF -->
        <xsl:result-document href="{$path-facsimile}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Facsimile interactif')"/>
                    </title>
                    <style>
                        .section-wrapper {
                            position: relative;
                        }
                        
                        .zone {
                            position: absolute;
                        }
                        
                        .zone span {
                            position: relative;
                            display: block;
                            overflow-y: auto;
                            visibility: hidden;
                            background-color: white;
                            padding: 0px 5px 0px 5px;
                        }
                        
                        .zone:hover span {
                            visibility: visible;
                        }
                        
                        /* Original version (ov) */
                        
                        span.choice.orig,
                        span.choice.sic,
                        span.choice.abbr {
                            color: crimson;
                            display: none;
                            padding: 0px 0px 0px 0px;
                        }
                        
                        /* Regularized version (rv) */
                        
                        span.choice.reg,
                        span.choice.expan,
                        span.choice.corr {
                            color: mediumseagreen;
                            padding: 0px 0px 0px 0px;
                            display: inline;
                        }
                        
                        /* Not shown */
                        
                        span.certainty {
                            display: none;
                        }</style>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                        <xsl:call-template name="interfaxim"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- PAGE DE NOTICE BIBLIOGRAPHIQUE -->
        <xsl:result-document href="{$path-catalogue-record}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Notice bibliographique')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                            <xsl:call-template name="catalogue-record"/>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- PAGE DE LA BIBLIOGRAPHIE -->
        <xsl:result-document href="{$path-biblio}" method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'Références bibliographiques')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div class="container">
                        <div class="col-md-10 col-md-offset-2">
                            <xsl:call-template name="biblio"/>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- À PROPOS -->
        <xsl:result-document href="{$path-about}">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <title>
                        <xsl:value-of select="concat($title, ' | ', 'À propos')"/>
                    </title>
                </head>
                <body>
                    <xsl:call-template name="navbar"/>
                    <div style="height: 50px;"/>
                    <div class="offset-md-2 col-md-8 text-center">
                        <p class="lead container">Ce site a été fait dans le cadre de l'évaluation
                            XSLT du Master 2 « Technologies numériques appliquées à l'histoire » l'École nationale des chartes. Vous trouverez le fichier XML TEI
                            de départ, le fichier de transformation XSL ainsi que le code HTML de
                            sortie sur <a href="https://github.com/Segolene-Albouy/Edition_numerique_saint-Sixte">GitHub</a>. De plus, il est possible de trouvez
                            les informations relatives à la mise en place de facsimilés interactifs
                            sur le <em>repository </em>
                            <a href="https://github.com/TimotheAlbouy/Interfaxim">Interfaxim</a>.</p>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- NAVBAR -->
    <xsl:template name="navbar">
        <xsl:variable name="path-edition">
            <xsl:text>edition.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-facsimile">
            <xsl:text>facsimile-interactif.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-textometry">
            <xsl:text>textometrie.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-catalogue-record">
            <xsl:text>notice.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-biblio">
            <xsl:text>bibliographie.html</xsl:text>
        </xsl:variable>
        <xsl:variable name="path-about">
            <xsl:text>a-propos.html</xsl:text>
        </xsl:variable>

        <nav class="navbar navbar-expand-md navbar-dark bg-dark justify-content-between">
            <a class="navbar-brand" href="/">Accueil</a>

            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="{$path-edition}">Transcription</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path-facsimile}">Fac-similé</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path-textometry}">Analyse textuelle</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path-catalogue-record}">Notice</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path-biblio}">Bibliographie</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{$path-about}">À propos</a>
                </li>
            </ul>
        </nav>
    </xsl:template>
    
    <!-- HEADER HTML -->
    <xsl:template name="meta-header">
        <xsl:variable name="title">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        <xsl:variable name="shelfmark">
            <xsl:value-of select="//msIdentifier/idno"/>
        </xsl:variable>
        <xsl:variable name="library">
            <xsl:value-of select="//msIdentifier/repository"/>
        </xsl:variable>
        
        <link rel="stylesheet"
            href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
            crossorigin="anonymous"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta charset="UTF-8"/>
        <meta name="author" content="Ségolène &amp; Timothé ALBOUY"/>
        <meta name="description" content="Édition numérique de la {$title} dans le manuscrit {$shelfmark} de la {$library}"/>
        <meta name="keywords" content="XSLT,XML,TEI"/>
        
        <link rel="icon" type="image/png" href="IMAGE/favicon.png" />
        <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet"></link>
        
        <style>
            @font-face{
            font-family : "symbolaregular";
            src : url('FONT/Symbola.ttf');
            }
            
            body {
                font-family: 'symbolaregular';
            }
            
            nav {
                font-family: 'Ubuntu', serif;
            }
            
            .btn-light {
                font-family: 'Ubuntu', serif;
                padding: 1em;
                border: 1em;
            }
            
        </style>

    </xsl:template>

    <!-- Séparateur de liste -->
    <xsl:template name="comma-point">
        <xsl:choose>
            <xsl:when test="position() != last()">
                <xsl:text>, </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>.</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="TEI//body//seg" mode="edited-text">
        <xsl:value-of select="./text() |
            .//reg/text() |
            .//expan/text() |
            .//corr/text() |
            .//persName/text() |
            .//said/text() |
            .//placeName/text() |
            .//seg//text() |
            .//g/text()|
            .//roleName/text()"/>
    </xsl:template>
    
    <!-- TEXTE TRANSCRIT -->
    <!-- - - - -VERSION MODERNISÉE - - - - -->
    <xsl:template match="TEI//body//p" mode="normalised-version">
        <p class="paragraph">
            <xsl:choose>
                <xsl:when test="contains(@rend, 'color:red')">
                    <span class="font-weight-bold" style="color: #c63939">
                        <xsl:apply-templates mode="normalised-version"/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="normalised-version"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//body//p/seg" mode="normalised-version">
        <!-- Numérotation des lignes -->
        <xsl:variable name="line-number">
            <xsl:value-of select="replace(@facs, '#l', '')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($line-number) = 1">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 2em">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 2em">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($line-number) = 2">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 25px">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 25px">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($line-number) = 3">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 1em">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 1em">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="normalised-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//body//persName" mode="normalised-version">
        <span class="badge badge-light badge-pill">
            <xsl:apply-templates mode="normalised-version"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI//body//placeName" mode="normalised-version">
        <span class="badge badge-light badge-pill">
            <xsl:apply-templates mode="normalised-version"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI//body//g" mode="normalised-version">
        <xsl:if test="@type = 'initiale'">
            <xsl:if test="contains(@rend, 'color:red')">
                <span class="font-weight-bold" style="font-size: large; color: #c63939">
                    <xsl:apply-templates mode="normalised-version"/>
                </span>
            </xsl:if>
            <xsl:if test="contains(@rend, 'color:blue')">
                <span class="font-weight-bold" style="font-size: large; color: #3939c6">
                    <xsl:apply-templates mode="normalised-version"/>
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <!-- Contenu à ne pas afficher -->
    <xsl:template match="TEI//body//abbr" mode="normalised-version"/>
    <xsl:template match="TEI//body//orig" mode="normalised-version"/>
    <xsl:template match="TEI//body//sic" mode="normalised-version"/>
    <xsl:template match="TEI//body//certainty" mode="normalised-version"/>
    
    <!-- - - - -VERSION DIPLOMATIQUE - - - - -->
    <xsl:template match="TEI//body//p" mode="original-version">
        <p class="paragraph">
            <xsl:choose>
                <xsl:when test="contains(@rend, 'color:red')">
                    <span class="font-weight-bold" style="color: #c63939">
                        <xsl:apply-templates mode="original-version"/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="original-version"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//body//p/seg" mode="original-version">
        <!-- Numérotation des lignes -->
        <xsl:variable name="line-number">
            <xsl:value-of select="replace(@facs, '#l', '')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="string-length($line-number) = 1">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 2em">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 2em">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($line-number) = 2">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 25px">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 25px">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="string-length($line-number) = 3">
                <xsl:choose>
                    <xsl:when test="ends-with($line-number, '0')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 1em">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:when test="ends-with($line-number, '5')">
                        <small class="text-muted" style="margin-left: -3em">
                            <xsl:value-of select="$line-number"/>
                        </small>
                        <span class="line" style="margin-left: 1em">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="line">
                            <xsl:apply-templates mode="original-version"/>
                        </span>
                        <br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//body//persName" mode="original-version">
        <span class="badge badge-light badge-pill">
            <xsl:apply-templates mode="original-version"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI//body//placeName" mode="original-version">
        <span class="badge badge-light badge-pill">
            <xsl:apply-templates mode="original-version"/>
        </span>
    </xsl:template>
    
    <xsl:template match="TEI//body//g" mode="original-version">
        <xsl:if test="@type = 'initiale'">
            <xsl:if test="contains(@rend, 'color:red')">
                <span class="font-weight-bold" style="font-size: large; color: #c63939">
                    <xsl:apply-templates mode="original-version"/>
                </span>
            </xsl:if>
            <xsl:if test="contains(@rend, 'color:blue')">
                <span class="font-weight-bold" style="font-size: large; color: #3939c6">
                    <xsl:apply-templates mode="original-version"/>
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <!-- Contenu à ne pas afficher -->
    <xsl:template match="TEI//body//expan" mode="original-version"/>
    <xsl:template match="TEI//body//reg" mode="original-version"/>
    <xsl:template match="TEI//body//corr" mode="original-version"/>
    <xsl:template match="TEI//body//certainty" mode="original-version"/>
    
    <!-- OCCURRENCES PERSONNAGES -->
    <xsl:template name="textometry-perso">
        <h1>Listes de personnages</h1>
        <small class="text-muted">Cliquez sur le numéro de ligne d'une occurrence pour afficher le
            contexte textuel où elle appararaît.</small>

        <xsl:apply-templates select="//listPerson//person" mode="perso"/>

    </xsl:template>
    
    <xsl:template match="//listPerson//person" mode="perso">
        <xsl:variable name="idPerson">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <xsl:variable name="nb-occurrence">
            <xsl:value-of
                select="count(ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson])"
            />
        </xsl:variable>
        
        
        <xsl:if test="ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson]">
            <div class="card p-3">
                <!-- Si ce personnage est cité dans le texte -->
                <h5 class="card-title">
                    <xsl:value-of select="./persName//text()"/>
                    <xsl:text>  </xsl:text>
                    <span class="badge badge-light">
                        <xsl:value-of select="$nb-occurrence"/>
                        <xsl:choose>
                            <xsl:when test="$nb-occurrence = 1">
                                <xsl:text> occurrence</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> occurrences</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </h5>
                <small class="card-subtitle mb-2 text-muted">
                    <xsl:value-of select="./note//text()"/>
                </small>
                
                
                <p class="card-text">
                    <xsl:apply-templates
                        select="ancestor::TEI//body//persName[replace(@ref, '#', '') = $idPerson]" mode="perso"/>
                    <!-- pour chaque balise persName dont l'attribut ref référence le même identifiant -->
                </p>
            </div>
            
        </xsl:if>
    </xsl:template>
    
    <!--<xsl:template match="TEI//body//persName" mode="script">
        <xsl:variable name="persId" select="replace(@ref, '#', '')"/>
        <xsl:variable name="line-number" select="ancestor-or-self::seg/replace(@facs, '#l', '')"/>
        <xsl:variable name="tagId" select="concat($persId, $line-number)"/>
        
        <script>
            var placeId = <xsl:value-of select="$tagId"/>
            function popUp() {
                var popup = document.getElementById(placeId);
                popup.classList.toggle("show");
            }
        </script>
    </xsl:template>-->
    
    <xsl:template match="TEI//body//persName" mode="edited-text">
        <xsl:apply-templates mode="normalised-version"/>
    </xsl:template>
    
    <xsl:template match="TEI//body//persName" mode="perso">
        <xsl:variable name="occurrence">
            <xsl:value-of>
                <xsl:apply-templates select="." mode="edited-text"/>
            </xsl:value-of>
        </xsl:variable>
        
        <!-- premiere partie du mot à cheval sur 2 lignes -->
        <xsl:variable name="name-part1">
            <xsl:value-of select="replace($occurrence, '-', '')"/>
        </xsl:variable>
        
        <xsl:variable name="name-part2-id">
            <xsl:value-of select="replace(./@next, '#', '')"/>
        </xsl:variable>
        <xsl:variable name="name-part2">
            <xsl:value-of select="ancestor::TEI//body//persName[@xml:id = $name-part2-id]"/>
        </xsl:variable>
        
        <xsl:variable name="line">
            <!-- ancestor-or-self:: permet d'avoir le plus proche parent correspondant à ce noeud -->
            <xsl:value-of>
                <xsl:apply-templates select=" ancestor-or-self::seg" mode="normalised-version"/>
            </xsl:value-of>
        </xsl:variable>
        
        <!-- Correction d'un bug que je n'explique pas bloquant l'affichage -->
        <xsl:variable name="line-bug">
            <xsl:value-of select="replace($line, '&#xA;                  ', ' ')"/>
        </xsl:variable>
        
        <xsl:variable name="line-number">
            <xsl:value-of select="ancestor-or-self::seg/@facs"/>
        </xsl:variable>
        
        <!-- Tant pis pour le super popUp :'( -->
        <!--<xsl:variable name="persId" select="replace(@ref, '#', '')"/>
        <xsl:variable name="line-number" select="ancestor-or-self::seg/replace(@facs, '#l', '')"/>
        <xsl:variable name="tagId" select="concat($persId, $line-number)"/>-->
        
        <!--<span class="badge badge-light popup" onclick="popUp()">-->
        <span class="badge badge-light" onclick="alert('{$line-bug}')">
            <xsl:text> (l. </xsl:text>
            <xsl:value-of select="replace($line-number, '#l', '')"/>
            <xsl:text>)</xsl:text>
            <!--<xsl:if test="@ref">
                <span class="popuptext" id="{$tagId}">
                    <xsl:value-of select="$line"/>
                </span>
            </xsl:if>-->
        </span>
        
        <xsl:choose>
            <xsl:when test="./@next">
                <!-- si la balise persName possède un attribut next (càd si le nom est à cheval sur deux lignes) -->
                <xsl:text> « </xsl:text>
                <xsl:value-of select="[concat($name-part1, $name-part2)]"/>
                <xsl:text> »</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> « </xsl:text>
                <xsl:value-of select="$occurrence"/>
                <xsl:text> »</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:call-template name="comma-point"/>
        
    </xsl:template>

    <!-- OCCURRENCES LIEUX -->
    <xsl:template name="textometry-place">
        <h1>Listes de lieux</h1>
        <small class="text-muted">Cliquez sur le numéro de ligne d'une occurrence pour afficher le
            contexte textuel où elle apparaît.</small>

        <xsl:apply-templates select="//listPlace//place"/>

    </xsl:template>
    
    <xsl:template match="//listPlace//place">
        <xsl:variable name="idPlace">
            <!-- je récupère son id -->
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        <xsl:variable name="nb-occurrence">
            <xsl:value-of
                select="count(ancestor::TEI//body//placeName[replace(@ref, '#', '') = $idPlace])"
            />
        </xsl:variable>
        
        <div class="card p-3">
            <xsl:if test="ancestor::TEI//body//placeName[replace(@ref, '#', '') = $idPlace]">
                <!-- Si ce lieu est cité dans le texte -->
                <h5 class="card-title">
                    <xsl:value-of select="./placeName//text()"/>
                    <xsl:text>  </xsl:text>
                    <span class="badge badge-light">
                        <xsl:value-of select="$nb-occurrence"/>
                        <xsl:choose>
                            <xsl:when test="$nb-occurrence = 1">
                                <xsl:text> occurrence</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> occurrences</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </h5>
                <small class="card-subtitle mb-2 text-muted">
                    <xsl:value-of select="./note[1]//text()"/>
                </small>
            </xsl:if>
            
            <p class="card-text">
                <xsl:apply-templates
                    select="ancestor::TEI//body//placeName[replace(@ref, '#', '') = $idPlace]" mode="place"/>
                    <!-- pour chaque balise placeName dont l'attribut ref référence le même identifiant -->
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI//body//placeName" mode="edited-text">
        <xsl:apply-templates mode="normalised-version"/>
    </xsl:template>
    
    <xsl:template match="TEI//body//placeName" mode="place">
        <xsl:variable name="occurrence">
            <xsl:value-of>
                <xsl:apply-templates select="." mode="edited-text"/>
            </xsl:value-of>
        </xsl:variable>
        
        <!-- premiere partie du mot à cheval sur 2 lignes -->
        <xsl:variable name="name-part1">
            <xsl:value-of select="replace($occurrence, '-', '')"/>
        </xsl:variable>
        
        <xsl:variable name="name-part2-id">
            <xsl:value-of select="replace(./@next, '#', '')"/>
        </xsl:variable>
        <xsl:variable name="name-part2">
            <xsl:value-of select="ancestor::TEI//body//persName[@xml:id = $name-part2-id]"/>
        </xsl:variable>
        
        <xsl:variable name="line">
            <xsl:value-of>
                <xsl:apply-templates select=" ancestor-or-self::seg" mode="edited-text"/>
            </xsl:value-of>
        </xsl:variable>
        
        <!-- Correction d'un bug bloquant l'affichage -->
        <xsl:variable name="line-bug">
            <xsl:value-of select="replace($line, '&#xA;                  ', ' ')"/>
        </xsl:variable>
        
        <xsl:variable name="line-number">
            <xsl:value-of select="ancestor-or-self::seg/@facs"/>
        </xsl:variable>
        
        <span class="badge badge-light" onclick="alert('{$line-bug}')">
            <xsl:text> (l. </xsl:text>
            <xsl:value-of select="replace($line-number, '#l', '')"/>
            <xsl:text>)</xsl:text>
        </span>
        
        <xsl:choose>
            <xsl:when test="./@next">
                <!-- si la balise placeName possède un attribut next (càd si le nom est à cheval sur deux lignes) -->
                <xsl:text> « </xsl:text>
                <xsl:value-of select="[concat($name-part1, $name-part2)]"/>
                <xsl:text> »</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> « </xsl:text>
                <xsl:value-of select="$occurrence"/>
                <xsl:text> »</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        
        <xsl:call-template name="comma-point"/>
    </xsl:template>

    <!-- OCCURRENCES PRISE DE PAROLES -->
    <xsl:template name="textometry-parole">
        <h1>Prises de paroles</h1>
        <xsl:apply-templates select="//listPerson//person" mode="speaking"/>
    </xsl:template>
    
    <xsl:template match="//listPerson//person" mode="speaking">
        <xsl:variable name="idPerson">
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        
        <xsl:variable name="nb-occurrence">
            <xsl:value-of
                select="count(ancestor::TEI//body//said[replace(@who, '#', '') = $idPerson])"/>
        </xsl:variable>
        
        <!-- Si ce personnage est prend la parole dans le texte -->
        <xsl:if test="ancestor::TEI//body//said[replace(@who, '#', '') = $idPerson]">
            <div class="card p-3">
                
                <!-- NOM DU LOCUTEUR -->
                <h5 class="card-title">
                    <xsl:value-of select="./persName//text()"/>
                    <xsl:text>  </xsl:text>
                    <span class="badge badge-light">
                        <xsl:value-of select="$nb-occurrence"/>
                        <xsl:choose>
                            <xsl:when test="$nb-occurrence = 1">
                                <xsl:text> prise de parole</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text> prises de parole</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </span>
                </h5>
                <small class="card-subtitle mb-2 text-muted">
                    <xsl:value-of select="./note//text()"/>
                </small>
                
                <!-- PRISES DE PAROLES -->
                <xsl:apply-templates select="ancestor::TEI//body//said[replace(@who, '#', '') = $idPerson]" mode="speaking"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI//body//said" mode="speaking">
        <p class="card-text">
            <xsl:variable name="first-line">
                <xsl:value-of
                    select="ancestor-or-self::seg/[replace(@facs, '#l', '')]"/>
            </xsl:variable>
            <xsl:variable name="last-line">
                <xsl:value-of>
                    <xsl:apply-templates select="." mode="line-number"/>
                </xsl:value-of>
            </xsl:variable>
            
            <xsl:text>« </xsl:text>
            <xsl:apply-templates select="." mode="edited-text"/>
            <xsl:text> »</xsl:text>
            
            <span class="badge badge-light">
                <xsl:value-of
                    select="concat('(l. ', $first-line, ' - ', $last-line, ')')"
                />
            </span>
            
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//body//said" mode="line-number">
        <xsl:choose>
            <xsl:when test="./@next">
                <xsl:variable name="next-said-id">
                    <xsl:value-of select="replace(./@next, '#', '')"/>
                </xsl:variable>
                <xsl:apply-templates select="ancestor::TEI//body//said[@xml:id=$next-said-id]" mode="line-number"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="ancestor-or-self::seg/replace(@facs, '#l', '')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="TEI//body//said" mode="edited-text">
        <xsl:variable name="said-text">
            <xsl:value-of select="./text() |
                .//reg/text() |
                .//expan/text() |
                .//corr/text() |
                .//persName/text() |
                .//placeName/text() |
                .//seg/text() |
                .//g/text()|
                .//roleName/text()"/>
        </xsl:variable>

        <xsl:choose>
            <!-- si la chaine de caractère se termine par un tiret, càd si elle est tronquée -->
            <xsl:when test="ends-with($said-text, '-')">
                <xsl:value-of select="replace($said-text, '-', '')"/>
            </xsl:when>
            <!-- sinon je rajoute une espace pour ne pas que la prochaine ligne soit collée -->
            <xsl:otherwise>
                <xsl:value-of select="concat($said-text, ' ')"/>
            </xsl:otherwise>
        </xsl:choose>
        
            <xsl:if test="./@next">
                <xsl:variable name="next-said-id">
                    <xsl:value-of select="replace(./@next, '#', '')"/>
                </xsl:variable>
                <xsl:apply-templates select="ancestor::TEI//body//said[@xml:id=$next-said-id]" mode="edited-text"/>
            </xsl:if>
    </xsl:template>
    
    <!-- NOTICE -->
    <xsl:template name="catalogue-record">
        <h1 class="p-3">
            <xsl:text>Manuscrit </xsl:text>
            <em>
                <xsl:value-of select="TEI//msIdentifier/idno"/>
            </em>
        </h1>
        <div class="row">
            <!-- Informations générales du manuscrit -->
            <div class="card col-md-4 col-sm-5 p-3">
                <div id="general" class="text-center">
                    <p>
                        <xsl:value-of select="TEI//msIdentifier/repository"/>
                    </p>
                </div>
                <hr/>
                <div id="id" class="p-1">
                    <h5>Identifiants</h5>
                    <p>
                        <b>Cote : <xsl:value-of select="TEI//msIdentifier/idno"/></b>
                    </p>
                    <xsl:apply-templates select="TEI//altIdentifier"/>
                </div>
                <hr/>
                <div id="summary" class="p-1">
                    <h5>Sommaire</h5>
                    <div class="container">
                        <xsl:apply-templates select="TEI//summary/locus"/>
                    </div>
                </div>
            </div>

            <!-- Informations spécifiques aux vies de saints -->
            <div class="container col-md-8 col-sm-7">
                <h3>
                    <xsl:value-of select="TEI/teiHeader//head/title"/>
                </h3>
                <div class="container">
                    <p>
                        <xsl:value-of select="TEI//textLang"/>
                        <xsl:text> - </xsl:text>
                        <b>
                            <xsl:value-of select="TEI/teiHeader//head/origDate"/>
                        </b>
                        <br/>
                    </p>
                    <hr/>
                    <div id="resp" class="p-1">
                        <h5>Intervenants</h5>
                        <div class="container">
                            <xsl:apply-templates select="TEI//msItem/respStmt"/>
                        </div>
                    </div>
                    <hr/>
                    <div id="colophon" class="p-1">
                        <h5>Colophon</h5>
                        <div class="container">
                            <em>
                                <xsl:value-of select="TEI//colophon"/>
                            </em>
                        </div>
                    </div>
                    <hr/>
                    <div id="physDesc" class="p-1">
                        <h3>Description matérielle</h3>
                        <div class="container">
                            <b>Support</b>
                            <xsl:value-of select="concat(' : ', TEI//support)"/>
                            <br/>
                            <b>Dimension</b>
                            <xsl:value-of
                                select="concat(' : largeur : ', TEI//extent/width/@unit, ' ; longueur : ', TEI//extent/height/@unit)"/>
                            <br/>
                            <b>Foliotation</b>
                            <xsl:value-of select="concat(' : ', TEI//physDesc//foliation)"/>
                            <br/>
                            <b>Mise en page</b>
                            <xsl:choose>
                                <xsl:when test="TEI//physDesc//layout/@columns > 1">
                                    <xsl:value-of
                                        select="concat(' : colonnes : ', TEI//physDesc//layout/@columns)"
                                    />
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="concat(' : colonne : ', TEI//physDesc//layout/@columns)"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:value-of
                                select="concat(' ; lignes par colonne : ', TEI//physDesc//layout/@writtenLines)"/>
                            <br/>
                            <xsl:value-of select="TEI//physDesc//layout"/>
                            <hr/>
                            <b>Description des mains</b>
                            <xsl:value-of select="concat(' : ', TEI//handNote//p)"/>
                            <xsl:if test="TEI//handNote//list">
                                <xsl:apply-templates select="TEI//handNote//list/item"/>
                            </xsl:if>
                            <hr/>
                            <b>Description de l'écriture</b>
                            <xsl:value-of select="concat(' : ', TEI//scriptNote)"/>
                            <hr/>
                            <b>Description de l'ornement</b>
                            <xsl:text> :</xsl:text>
                            <xsl:apply-templates select="TEI//decoDesc//decoNote"/>
                            <hr/>
                            <b>Description de l'ornement</b>
                            <xsl:text> :</xsl:text>
                            <br/>
                            <xsl:apply-templates select="TEI//bindingDesc//decoNote"/>
                            <hr/>
                            <b>Provenance géographique</b>
                            <xsl:text> :</xsl:text>
                            <br/>
                            <xsl:apply-templates select="TEI//history/origin/p"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI//altIdentifier">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//summary/locus">
        <p>
            <span class="badge badge-light">
                <xsl:value-of select="concat('ff.', ./@from, '-', ./@to)"/>
            </span>
            <xsl:value-of select="concat(' : ', ./text())"/>
            <xsl:if test="./locus">
                <xsl:for-each select="./locus">
                    <ol>
                        <span class="badge badge-light">
                            <xsl:value-of
                                select="concat('ff.', ./@from, '-', ./@to)"/>
                        </span>
                        <xsl:value-of select="concat(' : ', ./text())"/>
                    </ol>
                </xsl:for-each>
            </xsl:if>
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//msItem/respStmt">
        <div class="col-md-6">
            <b>
                <xsl:value-of select="./resp"/>
            </b>
            <xsl:text> : </xsl:text>
            <xsl:value-of select="./name/text() | ./name/persName/text()"/>
        </div>
    </xsl:template>

    <xsl:template match="TEI//handNote//list/item">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>
    
    <xsl:template match="TEI//decoDesc//decoNote">
        <p>
            <xsl:if test="./@xml:id">
                <xsl:variable name="initiale-id" select="./@xml:id"/>
                <xsl:variable name="initiale-line">
                    <xsl:value-of
                        select="ancestor::TEI//body//g[replace(@ref, '#', '') = $initiale-id]/ancestor-or-self::seg/@facs"
                    />
                </xsl:variable>
                <span class="badge badge-light">
                    <xsl:value-of select="replace($initiale-line, '#l', 'l. ')"/>
                </span>
            </xsl:if>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    
    <xsl:template match="TEI//bindingDesc//decoNote">
        <u>
            <xsl:value-of select="./@type"/>
        </u>
        <xsl:value-of select="concat(' : ', .)"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="TEI//history/origin/p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="TEI//bibl[@corresp]">
        <xsl:variable name="id-bibl" select="replace(./@corresp, '#', '')"/>
        <xsl:variable name="title-bibl">
            <xsl:value-of select="ancestor::TEI//bibl[@xml:id=$id-bibl]/title[1]"/>
        </xsl:variable>
        <span class="badge badge-light" onclick="alert('{$title-bibl}')">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    <!-- BIBLIOGRAPHIE -->
    <xsl:template name="biblio">
        <h2 class="p-3">
            <xsl:value-of select="TEI/teiHeader//listBibl/head"/>
        </h2>
        <div class="container">
            <xsl:apply-templates select="TEI/teiHeader//listBibl/bibl"/>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI/teiHeader//listBibl/bibl">
        <div class="card p-3">
            <p>
                <xsl:apply-templates select=".//author"/>
                <xsl:apply-templates select=".//title"/>
                <xsl:if test=".//pubPlace">
                    <xsl:value-of select="concat(.//pubPlace, ', ')"/>
                </xsl:if>
                <xsl:apply-templates select=".//editor"/>
                <xsl:if test=".//publisher">
                    <xsl:value-of select="concat(.//publisher, ', ')"/>
                </xsl:if>
                <xsl:if test=".//date">
                    <xsl:value-of select=".//date"/>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test=".//biblScope">
                        <xsl:apply-templates select=".//biblScope"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>.</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//author">
        <xsl:choose>
            <xsl:when test="./persName">
                <span style="font-weight: 500;">
                    <xsl:apply-templates select="./persName"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span style="font-weight: 500;">
                    <xsl:value-of select="."/>
                </span>
                <xsl:text>, </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//author/persName">
        <xsl:value-of select="concat(., ', ')"/>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//editor">
        <xsl:choose>
            <xsl:when test="./persName">
                <xsl:apply-templates select="./persName"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(., ', ')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//editor/persName">
        <xsl:value-of select="concat(., ', ')"/>
    </xsl:template>
    
    <xsl:template match="TEI//bibl//title">
        <xsl:if test=".[@level='a']">
            <xsl:text>« </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text> », </xsl:text>
        </xsl:if>
        <xsl:if test=".[@level='m']">
            <em><xsl:value-of select="."/></em>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test=".[@level='j']">
            <xsl:value-of select="."/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test=".[@level='s']">
            <xsl:value-of select="."/>
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="TEI//bibl//biblScope">
        <xsl:value-of select="concat(', ', .)"/>
        <xsl:if test="position() = last()">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- FACSIMLE INTERACTIF -->
    <xsl:template name="interfaxim">
        <h1>
            <xsl:value-of select="//teiHeader/fileDesc/titleStmt/title"/>
        </h1>
        <div class="row p-2">
            <div class="col-sm-3 col-md-3">
                <h4>Transcription : </h4>
            </div>
            <div class="col-sm-5">
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-secondary">
                        <input type="radio" name="version" onchange="changeVersion('rv')"
                            checked="checked"/>
                        <xsl:text>Modernisée</xsl:text>
                    </label>
                    <label class="btn btn-secondary">
                        <input type="radio" name="version" onchange="changeVersion('ov')"/>
                        <xsl:text>Diplomatique</xsl:text>
                    </label>
                </div>
            </div>
        </div>
        <div class="row p-2">
            <div class="col-sm-3 col-md-2">
                <h4>Feuillet :</h4>
            </div>
            <div class="tabs col-sm-3">
                <div class="btn-group btn-group-toggle">
                    <xsl:for-each select="//facsimile/surface">
                        <label class="btn btn-secondary">
                            <input type="radio"
                                onclick="{concat('changeSection(', position(), ')')}"/>
                            <xsl:value-of select="position()"/>
                        </label>
                    </xsl:for-each>
                </div>
            </div>
        </div>
        <xsl:for-each select="//facsimile/surface">
            <xsl:variable name="url" select="graphic/@url"/>
            <div class="section-wrapper" data-section="{position()}">
                <img src="{$url}"/>
                <div class="zone-list">
                    <xsl:for-each select="zone">
                        <xsl:variable name="left" select="@ulx"/>
                        <xsl:variable name="top" select="@uly"/>
                        <xsl:variable name="width" select="number(@lrx) - number(@ulx)"/>
                        <xsl:variable name="height" select="number(@lry) - number(@uly)"/>
                        <xsl:variable name="id" select="@xml:id"/>
                        <xsl:variable name="facs" select="concat('#', $id)"/>
                        <div class="zone"
                            style="top: {$top}px; left: {$left}px; height: {$height}px; width: {$width}px;">
                            <span style="top: {$height}px;">
                                <xsl:apply-templates select="//seg[@facs = $facs]"/>
                            </span>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:for-each>
        <script>
                    function changeVersion(ver) {
                    var ovnodes = document.querySelectorAll(".sic, .orig, .abbr");
                    var rvnodes = document.querySelectorAll(".reg, .expan, .corr");
                    if (ver === "ov") {
                    for (var i = 0; i &lt; ovnodes.length; i++) {
                    var el = ovnodes[i];
                    el.style.display = "inline";
                    }
                    for (var i = 0; i &lt; rvnodes.length; i++) {
                    var el = rvnodes[i];
                    el.style.display = "none";
                    }
                    } else if (ver === "rv") {
                    for (var i = 0; i &lt; ovnodes.length; i++) {
                    var el = ovnodes[i];
                    el.style.display = "none";
                    }
                    for (var i = 0; i &lt; rvnodes.length; i++) {
                    var el = rvnodes[i];
                    el.style.display = "inline";
                    }
                    }
                    }
                    
                    function changeSection(sec) {
                    var sections = document.querySelectorAll(".section-wrapper");
                    for (var i = 0; i &lt; sections.length; i++) {
                    var el = sections[i];
                    if (el.dataset.section == sec)
                    el.style.display = "inline-block";
                    else el.style.display = "none";
                    }
                    }
                    
                    changeSection(1);
                </script>
    </xsl:template>

    <!-- Original version -->

    <xsl:template match="abbr">
        <span class="choice abbr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="orig ">
        <span class="choice orig">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="sic ">
        <span class="choice sic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Regularized version -->

    <xsl:template match="reg ">
        <span class="choice reg">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="expan">
        <span class="choice expan">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="corr">
        <span class="choice corr">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Not shown -->

    <xsl:template match="certainty">
        <span class="certainty">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

</xsl:stylesheet>
