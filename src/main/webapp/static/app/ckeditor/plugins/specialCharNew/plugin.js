/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

/**
 * @file Special Character plugin
 */

CKEDITOR.plugins.add( 'specialCharNew',
{
	// List of available localizations.
	availableLangs : { en:1 },

	init : function( editor )
	{
		var pluginName = 'specialCharNew',
			plugin = this;

		// Register the dialog.
		CKEDITOR.dialog.add( pluginName, this.path + 'dialogs/specialchar.js' );

		editor.addCommand( pluginName,
			{
				exec : function()
				{
					var langCode = editor.langCode;
					langCode = plugin.availableLangs[ langCode ] ? langCode : 'en';

					CKEDITOR.scriptLoader.load(
							CKEDITOR.getUrl( plugin.path + 'lang/' + langCode + '.js' ),
							function()
							{
								CKEDITOR.tools.extend( editor.lang.specialChar, plugin.lang[ langCode ] );
								editor.openDialog( pluginName );
							});
				},
				modes : { wysiwyg:1 },
				canUndo : false
			});

		// Register the toolbar button.
		editor.ui.addButton( 'SpecialCharNew',
			{
				label : editor.lang.specialChar.toolbar,
				command : pluginName,
				icon : CKEDITOR.getUrl( this.path + 'images/specialchar.gif' )
			});
	}
} );

/**
  * The list of special characters visible in Special Character dialog.
  * @type Array
  * @example
  * config.specialChars = [ '&quot;', '&rsquo;', [ '&custom;', 'Custom label' ] ];
  * config.specialChars = config.specialChars.concat( [ '&quot;', [ '&rsquo;', 'Custom label' ] ] );
  */
CKEDITOR.config.specialChars =
	[
		'!','&quot;','#','$','%','&amp;',"'",'(',')','*','+','-','.','/',
		'0','1','2','3','4','5','6','7','8','9',':',';',
		'&lt;','=','&gt;','?','@',
		'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
		'P','Q','R','S','T','U','V','W','X','Y','Z',
		'[',']','^','_','`',
		'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',
		'q','r','s','t','u','v','w','x','y','z',
		'{','|','}','~',
		"&euro;", "&lsquo;", "&rsquo;", "&ldquo;", "&rdquo;", "&ndash;", "&mdash;", "&iexcl;", "&cent;", "&pound;", "&curren;", "&yen;", "&brvbar;", "&sect;", "&uml;", "&copy;", "&ordf;", "&laquo;", "&not;", "&reg;", "&macr;", "&deg;", "&", "&sup2;", "&sup3;", "&acute;", "&micro;", "&para;", "&middot;", "&cedil;", "&sup1;", "&ordm;", "&", "&frac14;", "&frac12;", "&frac34;", "&iquest;", "&Agrave;", "&Aacute;", "&Acirc;", "&Atilde;", "&Auml;", "&Aring;", "&AElig;", "&Ccedil;", "&Egrave;", "&Eacute;", "&Ecirc;", "&Euml;", "&Igrave;", "&Iacute;", "&Icirc;", "&Iuml;", "&ETH;", "&Ntilde;", "&Ograve;", "&Oacute;", "&Ocirc;", "&Otilde;", "&Ouml;", "&times;", "&Oslash;", "&Ugrave;", "&Uacute;", "&Ucirc;", "&Uuml;", "&Yacute;", "&THORN;", "&szlig;", "&agrave;", "&aacute;", "&acirc;", "&atilde;", "&auml;", "&aring;", "&aelig;", "&ccedil;", "&egrave;", "&eacute;", "&ecirc;", "&euml;", "&igrave;", "&iacute;", "&icirc;", "&iuml;", "&eth;", "&ntilde;", "&ograve;", "&oacute;", "&ocirc;", "&otilde;", "&ouml;", "&divide;", "&oslash;", "&ugrave;", "&uacute;", "&ucirc;", "&uuml;", "&uuml;", "&yacute;", "&thorn;", "&yuml;", "&OElig;", "&oelig;", "&#372;", "&#374", "&#373", "&#375;", "&sbquo;", "&#8219;", "&bdquo;", "&hellip;", "&trade;", "&#9658;", "&bull;", "&rarr;", "&rArr;", "&hArr;", "&diams;", "&asymp;",
		"&copy","&reg","&iexcl;","&cent;","&pound;","&curren;","&yen;","&brvbar;","&sect;","&uml;","&copy;","&ordf;","&laquo;", "&not;","&shy;", 				
		"&reg;", "&macr;","&deg;","&plusmn;","&sup2;","&sup3;","&acute;","&micro;","&para;","&middot;",	"&cedil;", 			
		"&sup1;","&ordm;","&raquo;","&frac14;",	"&frac12;", "&frac34;", "&iquest;","&Agrave;", "&Aacute;", 		
		"&Acirc;", "&Atilde;", "&Auml;","&Aring;","&AElig;","&Ccedil;","&Egrave;", "&Eacute;","&Ecirc;",		 
		"&Euml;", "&Igrave;","&Iacute;","&Icirc;","&Iuml;","&ETH;", "&Ntilde;","&Ograve;","&Oacute;","&Ocirc;",		 
		"&Otilde;", "&Ouml;", "&times;","&Oslash;",	"&Ugrave;","&Uacute;","&Ucirc;","&Uuml;","&Yacute;",		 
		"&THORN;", "&szlig;","&agrave;","&aacute;", "&acirc;","&atilde;","&auml;","&aring;","&aelig;", 		 
		"&ccedil;", "&egrave;",	"&eacute;", "&ecirc;", "&euml;","&igrave;",	"&iacute;","&icirc;",		 
		"&iuml;","&eth;","&ntilde;","&ograve;", "&oacute;","&ocirc;","&otilde;","&ouml;", "&divide;",		 
		"&oslash;", "&ugrave;","&uacute;","&ucirc;","&uuml;","&yacute;","&thorn;","&yuml;", "&fnof;",			 
		"&Alpha;","&Beta;","&Gamma;", "&Delta;","&Epsilon;","&Zeta;","&Eta;","&Theta;",	"&Iota;","&Kappa;",		 
		"&Lambda;","&Mu;","&Nu;","&Xi;","&Omicron;","&Pi;","&Rho;","&Sigma;","&Tau;",			 
		"&Upsilon;","&Phi;","&Chi;","&Psi;","&Omega;","&alpha;","&beta;","&gamma;",	"&delta;", 		 
		"&epsilon;","&zeta;","&eta;","&theta;","&iota;","&kappa;","&lambda;","&mu;","&nu;","&xi;", 			 
		"&omicron;","&pi;","&rho;","&sigmaf;","&sigma;","&tau;","&upsilon;","&phi;","&chi;", 			 
		"&psi;","&omega;", "&thetasym;","&upsih;","&piv;","&bull;","&hellip;","&prime;","&Prime;",		 
		"&oline;","&frasl;","&weierp;",	"&image;","&real;","&trade;","&alefsym;","&larr;","&uarr;",		   
		"&rarr;","&darr;", "&harr;","&crarr;","&lArr;","&uArr;","&rArr;","&dArr;","&hArr;","&forall;",    
		"&part;","&exist;","&empty;","&nabla;","&isin;","&notin;","&ni;","&prod;","&sum;", "&minus;",	   
		"&lowast;","&radic;","&prop;","&infin;","&ang;","&and;","&or;","&cap;","&cup;", "&int;", 		   
		"&there4;","&sim;","&cong;","&asymp;","&ne;","&equiv;","&le;","&ge;","&sub;","&sup;","&nsub;",		   
		"&sube;","&supe;","&oplus;","&otimes;","&perp;","&sdot;","&lceil;","&rceil;","&lfloor;","&rfloor;",	   
		"&lang;","&rang;","&loz;","&spades;","&clubs;","&hearts;","&diams;","&quot;","&amp;","&lt;","&gt;", 		   
		"&OElig;","&oelig;","&Scaron;","&scaron;","&Yuml;","&circ;","&tilde;","&emsp;","&thinsp;","&zwnj;",		   
		"&zwj;","&lrm;", "&rlm;","&ndash;","&mdash;","&lsquo;","&rsquo;","&sbquo;","&ldquo;","&rdquo;", "&bdquo;",	   
		"&dagger;",	"&Dagger;","&permil;","&lsaquo;"   	
	];
