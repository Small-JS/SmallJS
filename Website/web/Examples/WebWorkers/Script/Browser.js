import { BlockReturn } from './Runtime.js';
import { stNil, stTrue, stFalse } from './Core.js';
import { StObject, StObject$class, stObject$class } from './Core.js';
import { StClass, StClass$class, stClass$class } from './Core.js';
import { StString, StString$class, stString$class } from './Core.js';
import { StBlock, StBlock$class, stBlock$class } from './Core.js';
import { StInteger, StInteger$class, stInteger$class } from './Core.js';
import { StRequestOptions, StRequestOptions$class, stRequestOptions$class } from './Core.js';
import { StResponse, StResponse$class, stResponse$class } from './Core.js';
import { StError, StError$class, stError$class } from './Core.js';
import { StJsObject, StJsObject$class, stJsObject$class } from './Core.js';
import { StBoolean, StBoolean$class, stBoolean$class } from './Core.js';
import { StArray, StArray$class, stArray$class } from './Core.js';
import { StFloat, StFloat$class, stFloat$class } from './Core.js';
import { StPoint, StPoint$class, stPoint$class } from './Core.js';
import { StPoint3d, StPoint3d$class, stPoint3d$class } from './Core.js';
import { StUint8Array, StUint8Array$class, stUint8Array$class } from './Core.js';
import { StEventTarget, StEventTarget$class, stEventTarget$class } from './Core.js';
import { StConsole, StConsole$class, stConsole$class } from './Core.js';
import { StRect, StRect$class, stRect$class } from './Core.js';
import { StBlob, StBlob$class, stBlob$class } from './Core.js';
import { StDate, StDate$class, stDate$class } from './Core.js';
import { StFile, StFile$class, stFile$class } from './Core.js';

export class StBrowserApp extends StObject
{
	$class()
	{
		return stBrowserApp$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$testMode()
	{
		return stWindow$class.$default().$location().$search().$toLowerCase().$$equeals( stString$class.$fromJs$( '?test' ) );
	}

	$navigateTo$( url )
	{
		stWindow$class.$default().$location().$replace$( url.$$comma( stWindow$class.$default().$location().$search() ) );
		return this;
	}

	$stop()
	{
		stWindow$class.$default().$close();
		return this;
	}

	$url()
	{
		return stWindow$class.$default().$location().$hostPath();
	}

}

export class StComponent extends StObject
{
	app = stNil;
	parent = stNil;

	$class()
	{
		return stComponent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$app()
	{
		return this.app;
	}

	$app$( aApp )
	{
		this.app = aApp;
		return this;
	}

	$parent()
	{
		return this.parent;
	}

	$parent$( aParent )
	{
		this.parent = aParent;
		return this;
	}

	$htmlPath()
	{
		this.$subclassReponsibility();
		return this;
	}

	$start()
	{
	}

	$loadIntoElement$then$( elementId, block )
	{
		this.$loadIntoElement$append$then$( elementId, stFalse, block );
		return this;
	}

	$appendToElement$then$( elementId, block )
	{
		this.$loadIntoElement$append$then$( elementId, stTrue, block );
		return this;
	}

	$loadIntoElement$append$then$( elementId, append, block )
	{
		let element = stNil;
		element = stDocument$class.$getElementById$( elementId );
		this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return element.$notNil();
			} ) );
		stFetch$class.$text$then$catch$( this.$htmlPath(), stBlock$class.$fromJs$( ( html ) => {
				append.$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return element.$insertAdjacentHtml$position$( html, stString$class.$fromJs$( 'beforeEnd' ) );
			} ), stBlock$class.$fromJs$( (  ) => {
				return element.$innerHtml$( html );
			} ) );
				this.$start();
				return block.$value$( this );
			} ), stBlock$class.$fromJs$( ( error ) => {
				return this.$log$( stString$class.$fromJs$( 'Failed to fetch component HTML: ' ).$$comma( this.$htmlPath() ).$$comma( stString$class.$fromJs$( ': ' ) ).$$comma( error.$message() ) );
			} ) );
		return this;
	}

}

export class StLanguage extends StObject
{
	current = stNil;
	supported = stNil;
	translations = stNil;

	$class()
	{
		return stLanguage$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$current()
	{
		return this.current;
	}

	$currentIndex()
	{
		return this.supported.$indexOf$( this.current );
	}

	$supported()
	{
		return this.supported;
	}

	$supported$( aSupported )
	{
		this.supported = aSupported;
		return this;
	}

	$translations()
	{
		return this.translations;
	}

	$load$( code )
	{
		let fileName = stNil;
		this.current = this.$matchCode$( code );
		fileName = stString$class.$fromJs$( 'Language/' ).$$comma( this.current ).$$comma( stString$class.$fromJs$( '.json' ) );
		stFetch$class.$object$then$catch$( fileName, stBlock$class.$fromJs$( ( object ) => {
				return this.$onLoad$( object );
			} ), stBlock$class.$fromJs$( ( error ) => {
				return this.$log$( stString$class.$fromJs$( 'Failed to load language: ' ).$$comma( fileName ).$$comma( stString$class.$fromJs$( ': ' ) ).$$comma( error.$message() ) );
			} ) );
		return this;
	}

	$matchCode$( matchCode )
	{
		let best = stNil;
		let matchLanguageCode = stNil;
		try {
		this.supported.$isNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$error$( stString$class.$fromJs$( 'No suported languages' ) );
			} ) );
		matchLanguageCode = stLanguageCode$class.$fromCode$( matchCode );
		this.supported.$do$( stBlock$class.$fromJs$( ( code ) => {
				matchLanguageCode.$match$( code ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( code );
			} ) );
				return matchLanguageCode.$matchLanguage$( code ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return best.$notNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return best = code;
			} ) );
			} ) );
			} ) );
		return best.$notNil().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return best;
			} ), stBlock$class.$fromJs$( (  ) => {
				return this.supported.$first();
			} ) );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$onLoad$( aTranslations )
	{
		let element = stNil;
		let translation = stNil;
		this.translations = aTranslations;
		this.translations.$entries().$do$( stBlock$class.$fromJs$( ( entry ) => {
				element = stDocument$class.$getElementById$( entry.$at$( stInteger$class.$fromJs$( 0 ) ) );
				return element.$notNil().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return this.$setTranslationOn$to$( element, entry.$at$( stInteger$class.$fromJs$( 1 ) ) );
			} ) );
			} ) );
		return this;
	}

	$setTranslationOn$to$( element, translation )
	{
		element.$textContent$( translation );
		return this;
	}

}

export class StLanguageCode extends StObject
{
	language = stNil;
	country = stNil;

	$class()
	{
		return stLanguageCode$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$language()
	{
		return this.language;
	}

	$country()
	{
		return this.country;
	}

	$fromCode$( code )
	{
		let dashPos = stNil;
		dashPos = code.$indexOf$( stString$class.$fromJs$( '-' ) );
		this.language = dashPos.$$gt( stInteger$class.$fromJs$( 0 ) ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return code.$substring$to$( stInteger$class.$fromJs$( 0 ), dashPos ).$toLocaleLowerCase();
			} ), stBlock$class.$fromJs$( (  ) => {
				return code;
			} ) );
		this.country = dashPos.$$gt$equeals( stInteger$class.$fromJs$( 0 ) ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return code.$substring$to$( stInteger$class.$fromJs$( 0 ), dashPos ).$toUpperCase();
			} ), stBlock$class.$fromJs$( (  ) => {
				return stNil;
			} ) );
		return this;
	}

	$toString()
	{
		return this.country.$isNil().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return this.language;
			} ), stBlock$class.$fromJs$( (  ) => {
				return this.language.$$comma( stString$class.$fromJs$( '-' ) ).$$comma( this.country );
			} ) );
	}

	$match$( code )
	{
		let match = stNil;
		match = stLanguageCode$class.$fromCode$( code );
		return this.$language().$$equeals( match.$language() ).$$amp( this.$country().$$equeals( match.$country() ) );
	}

	$matchLanguage$( code )
	{
		return this.$language().$$equeals( stLanguageCode$class.$fromCode$( code ).$language() );
	}

}

export class StFetch extends StObject
{
	$class()
	{
		return stFetch$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StAbstractRange extends StJsObject
{
	$class()
	{
		return stAbstractRange$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$collapsed()
	{
		return stBoolean$class.$fromJs$( this.js.collapsed );
	}

	$startContainer()
	{
		return stNode$class.$fromJsSubNode$( this.js.startContainer );
	}

	$endContainer()
	{
		return stNode$class.$fromJsSubNode$( this.js.endContainer );
	}

	$startOffset()
	{
		return stInteger$class.$fromJs$( this.js.startOffset );
	}

	$endOffset()
	{
		return stInteger$class.$fromJs$( this.js.endOffset );
	}

}

export class StCustomElementRegistry extends StJsObject
{
	$class()
	{
		return stCustomElementRegistry$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StDomImplementation extends StJsObject
{
	$class()
	{
		return stDomImplementation$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$createDocumentType$publicId$systemId$( name, publicId, systemId )
	{
		return stDocumentType$class.$fromJs$( this.js.createDocumentType( name.js, publicId.js, systemId.js ) );
	}

	$createHtmlDocument()
	{
		return stDocument$class.$fromJs$( this.js.createHTMLDocument() );
	}

}

export class StDomTokenList extends StJsObject
{
	$class()
	{
		return stDomTokenList$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( value )
	{
		this.js.value = value.js;
		return this;
	}

	$add$( token )
	{
		this.js.add( token.js );
		return this;
	}

	$contains$( token )
	{
		return stBoolean$class.$fromJs$( this.js.contains( token.js ) );
	}

	$entries()
	{
		return stArray$class.$fromJs$elementClass$( this.js.entries(), stString$class );
	}

	$item$( index )
	{
		return stString$class.$fromJs$( this.js.item( index.js ) );
	}

	$keys()
	{
		return stArray$class.$fromJs$elementClass$( this.js.keys(), stInteger$class );
	}

	$remove$( token )
	{
		this.js.remove( token.js );
		return this;
	}

	$replace$with$( oldToken, newToken )
	{
		this.js.replace( oldToken.js, newToken.js );
		return this;
	}

	$supports$( token )
	{
		return stBoolean$class.$fromJs$( this.js.supports( token.js ) );
	}

	$toggle$( token )
	{
		return stBoolean$class.$fromJs$( this.js.toggle( token.js ) );
	}

	$values()
	{
		return stArray$class.$fromJs$elementClass$( this.js.values(), stString$class );
	}

}

export class StLocation extends StJsObject
{
	$class()
	{
		return stLocation$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$host()
	{
		return stString$class.$fromJs$( this.js.host );
	}

	$hostPath()
	{
		return this.$protocol().$$comma( stString$class.$fromJs$( '//' ) ).$$comma( this.$host() );
	}

	$hostname()
	{
		return stString$class.$fromJs$( this.js.hostname );
	}

	$href()
	{
		return stString$class.$fromJs$( this.js.href );
	}

	$href$( href )
	{
		this.js.href = href.js;
		return this;
	}

	$origin()
	{
		return stString$class.$fromJs$( this.js.origin );
	}

	$pathname()
	{
		return stString$class.$fromJs$( this.js.pathname );
	}

	$protocol()
	{
		return stString$class.$fromJs$( this.js.protocol );
	}

	$search()
	{
		return stString$class.$fromJs$( this.js.search );
	}

	$assign$( url )
	{
		this.js.assign( url.js );
		return this;
	}

	$reload()
	{
		this.js.reload();
		return this;
	}

	$replace$( url )
	{
		this.js.replace( url.js );
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

}

export class StNamedNodeMap extends StJsObject
{
	$class()
	{
		return stNamedNodeMap$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$getNamedItem$( name )
	{
		return stAttr$class.$fromJs$( this.js.getNamedItem( name.js ) );
	}

	$setNamedItem$( attr )
	{
		this.js.setNamedItem( attr.js );
		return this;
	}

	$removeNamedItem$( attrName )
	{
		this.js.removeNamedItem( attrName.js );
		return this;
	}

	$item$( index )
	{
		return stAttr$class.$fromJs$( this.js.item( index.js - 1 ) );
	}

}

export class StSelection extends StJsObject
{
	$class()
	{
		return stSelection$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$anchorNode()
	{
		return stNode$class.$fromJsSubNode$( this.js.anchorNode );
	}

	$anchorOffset()
	{
		return stInteger$class.$fromJs$( this.js.anchorOffset );
	}

	$focusNode()
	{
		return stNode$class.$fromJsSubNode$( this.js.focusNode );
	}

	$focusOffset()
	{
		return stInteger$class.$fromJs$( this.js.focusOffset );
	}

	$isCollapsed()
	{
		return stBoolean$class.$fromJs$( this.js.isCollapsed );
	}

	$rangeCount()
	{
		return stInteger$class.$fromJs$( this.js.rangeCount );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$addRange$( range )
	{
		this.js.addRange( range.js );
		return this;
	}

	$collapse$( node )
	{
		this.js.collapse( node.js );
		return this;
	}

	$collapseToEnd()
	{
		this.js.collapseToEnd();
		return this;
	}

	$collapseToStart()
	{
		this.js.collapseToStart();
		return this;
	}

	$containsNode$( node )
	{
		return stBoolean$class.$fromJs$( this.js.containsNode( node.js ) );
	}

	$deleteFromDocument()
	{
		this.js.deleteFromDocument();
		return this;
	}

	$extend$( node )
	{
		this.js.extend( node.js );
		return this;
	}

	$getRangeAt$( index )
	{
		return stRange$class.$fromJs$( this.js.getRangeAt( index.js ) );
	}

	$removeAllRanges()
	{
		this.js.removeAllRanges();
		return this;
	}

	$removeRange$( range )
	{
		this.js.removeRange( range.js );
		return this;
	}

	$selectAllChildren$( node )
	{
		this.js.selectAllChildren( node.js );
		return this;
	}

	$setBase$extent$( anchorNode, focusNode )
	{
		this.js.setBaseAndExtent( anchorNode.js, 0, focusNode.js, 0 );
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

}

export class StStorage extends StJsObject
{
	$class()
	{
		return stStorage$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StValidityState extends StJsObject
{
	$class()
	{
		return stValidityState$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$badInput()
	{
		return stBoolean$class.$fromJs$( this.js.badInput );
	}

	$customError()
	{
		return stBoolean$class.$fromJs$( this.js.customError );
	}

	$patternMismatch()
	{
		return stBoolean$class.$fromJs$( this.js.patternMismatch );
	}

	$rangeOverflow()
	{
		return stBoolean$class.$fromJs$( this.js.rangeOverflow );
	}

	$rangeUnderflow()
	{
		return stBoolean$class.$fromJs$( this.js.rangeUnderflow );
	}

	$stepMismatch()
	{
		return stBoolean$class.$fromJs$( this.js.stepMismatch );
	}

	$tooLong()
	{
		return stBoolean$class.$fromJs$( this.js.tooLong );
	}

	$tooShort()
	{
		return stBoolean$class.$fromJs$( this.js.tooShort );
	}

	$typeMismatch()
	{
		return stBoolean$class.$fromJs$( this.js.typeMismatch );
	}

	$valid()
	{
		return stBoolean$class.$fromJs$( this.js.valid );
	}

	$valueMissing()
	{
		return stBoolean$class.$fromJs$( this.js.valueMissing );
	}

}

export class StCanvasGradient extends StJsObject
{
	$class()
	{
		return stCanvasGradient$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$addColorStop$color$( offset, color )
	{
		this.js.addColorStop( offset.js, color.js );
		return this;
	}

}

export class StCanvasPattern extends StJsObject
{
	$class()
	{
		return stCanvasPattern$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$setTransform$( domMatrix )
	{
		setTransform( domMatrix.js );
		return this;
	}

}

export class StCanvasRenderingContext2d extends StJsObject
{
	$class()
	{
		return stCanvasRenderingContext2d$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$canvas()
	{
		return stHtmlCanvasElement$class.$fromJs$( this.js.canvas );
	}

	$direction()
	{
		return stString$class.$fromJs$( this.js.direction );
	}

	$direction$( direction )
	{
		this.js.direction = direction.js;
		return this;
	}

	$fillStyle()
	{
		return stString$class.$fromJs$( this.js.fillStyle );
	}

	$fillStyle$( fillStyle )
	{
		this.js.fillStyle = fillStyle.js;
		return this;
	}

	$filter()
	{
		return stString$class.$fromJs$( this.js.filter );
	}

	$filter$( filter )
	{
		this.js.filter = filter.js;
		return this;
	}

	$font()
	{
		return stString$class.$fromJs$( this.js.font );
	}

	$font$( font )
	{
		this.js.font = font.js;
		return this;
	}

	$fontKerning()
	{
		return stString$class.$fromJs$( this.js.fontKerning );
	}

	$fontKerning$( fontKerning )
	{
		this.js.fontKerning = fontKerning.js;
		return this;
	}

	$fontStretch()
	{
		return stString$class.$fromJs$( this.js.fontStretch );
	}

	$fontStretch$( fontStretch )
	{
		this.js.fontStretch = fontStretch.js;
		return this;
	}

	$fontVariantCaps()
	{
		return stString$class.$fromJs$( this.js.fontVariantCaps );
	}

	$fontVariantCaps$( fontVariantCaps )
	{
		this.js.fontVariantCaps = fontVariantCaps.js;
		return this;
	}

	$globalAlpha()
	{
		return stFloat$class.$fromJs$( this.js.globalAlpha );
	}

	$globalAlpha$( globalAlpha )
	{
		this.js.globalAlpha = globalAlpha.js;
		return this;
	}

	$globalCompositeOperation()
	{
		return stString$class.$fromJs$( this.js.globalCompositeOperation );
	}

	$globalCompositeOperation$( globalCompositeOperation )
	{
		this.js.globalCompositeOperation = globalCompositeOperation.js;
		return this;
	}

	$imageSmoothingEnabled()
	{
		return stBoolean$class.$fromJs$( this.js.imageSmoothingEnabled  );
	}

	$imageSmoothingEnabled$( imageSmoothingEnabled )
	{
		this.js.imageSmoothingEnabled = imageSmoothingEnabled.js;
		return this;
	}

	$letterSpacing()
	{
		return stString$class.$fromJs$( this.js.letterSpacing );
	}

	$letterSpacing$( letterSpacing )
	{
		this.js.letterSpacing = letterSpacing.js;
		return this;
	}

	$lineCap()
	{
		return stString$class.$fromJs$( this.js.lineCap  );
	}

	$lineCap$( lineCap )
	{
		this.js.lineCap = lineCap .js;
		return this;
	}

	$lineDashOffset()
	{
		return stInteger$class.$fromJs$( this.js.lineDashOffset );
	}

	$lineDashOffset$( lineDashOffset )
	{
		this.js.lineDashOffset = lineDashOffset.js;
		return this;
	}

	$lineJoin()
	{
		return stString$class.$fromJs$( this.js.lineJoin );
	}

	$lineJoin$( lineJoin )
	{
		this.js.lineJoin = lineJoin.js;
		return this;
	}

	$lineWidth()
	{
		return stFloat$class.$fromJs$( this.js.lineWidth );
	}

	$lineWidth$( lineWidth )
	{
		this.js.lineWidth = lineWidth.js;
		return this;
	}

	$miterLimit()
	{
		return stFloat$class.$fromJs$( this.js.miterLimit );
	}

	$miterLimit$( miterLimit )
	{
		this.js.miterLimit = miterLimit.js;
		return this;
	}

	$shadowBlur()
	{
		return stFloat$class.$fromJs$( this.js.shadowBlur );
	}

	$shadowBlur$( shadowBlur )
	{
		this.js.shadowBlur = shadowBlur.js;
		return this;
	}

	$shadowColor()
	{
		return stString$class.$fromJs$( this.js.shadowColor );
	}

	$shadowColor$( shadowColor )
	{
		this.js.shadowColor = shadowColor.js;
		return this;
	}

	$shadowOffset()
	{
		return stPoint$class.$jsX$jsY$( this.js.shadowOffsetX, this.js.shadowOffsetY );
	}

	$shadowOffset$( shadowOffset )
	{
		this.js.shadowOffsetX = shadowOffset.x.js;
		this.js.shadowOffsetY = shadowOffset.y.js;
		return this;
	}

	$strokeStyle()
	{
		return stString$class.$fromJs$( this.js.strokeStyle );
	}

	$strokeStyle$( strokeStyle )
	{
		this.js.strokeStyle = strokeStyle.js;
		return this;
	}

	$textAlign()
	{
		return stString$class.$fromJs$( this.js.textAlign );
	}

	$textAlign$( textAlign )
	{
		this.js.textAlign = textAlign.js;
		return this;
	}

	$textBaseline()
	{
		return stString$class.$fromJs$( this.js.textBaseline );
	}

	$textBaseline$( textBaseline )
	{
		this.js.textBaseline = textBaseline.js;
		return this;
	}

	$textRendering()
	{
		return stString$class.$fromJs$( this.js.textRendering );
	}

	$textRendering$( textRendering )
	{
		this.js.textRendering = textRendering.js;
		return this;
	}

	$wordSpacing()
	{
		return stString$class.$fromJs$( this.js.wordSpacing );
	}

	$wordSpacing$( wordSpacing )
	{
		this.js.wordSpacing = wordSpacing.js;
		return this;
	}

	$beginPath()
	{
		this.js.beginPath();
		return this;
	}

	$closePath()
	{
		this.js.closePath();
		return this;
	}

	$moveTo$( point )
	{
		this.js.moveTo( point.x.js, point.y.js );
		return this;
	}

	$stroke()
	{
		this.js.stroke();
		return this;
	}

	$strokePath$( path )
	{
		this.js.stroke( path.js );
		return this;
	}

	$fill()
	{
		this.js.fill();
		return this;
	}

	$fillRule$( rule )
	{
		this.js.fill( rule.js );
		return this;
	}

	$fillPath$( path )
	{
		this.js.fill( path.js );
		return this;
	}

	$fillPath$rule$( path, rule )
	{
		this.js.fill( path.js, rule.js );
		return this;
	}

	$arc$radius$startAngle$endAngle$counterclockwise$( center, radius, startAngle, endAngle, counterclockwise )
	{
		this.js.arc( center.x.js, center.y.js, radius.js, startAngle.js, endAngle.js, counterclockwise.js );
		return this;
	}

	$arcTo$to$radius$( to1, to2, radius )
	{
		this.js.arcTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, radius.js );
		return this;
	}

	$bezierCurveTo$to$end$( to1, to2, end )
	{
		this.js.bezierCurveTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, end.x.js, end.y.js );
		return this;
	}

	$ellipse$radii$rotation$startAngle$endAngle$counterclockwise$( center, radii, rotation, startAngle, endAngle, counterclockwise )
	{
		this.js.ellipse( center.x.js, center.y.js , radii.x.js, radii.y.js, rotation.js, startAngle.js, endAngle.js, counterclockwise.js );
		return this;
	}

	$quadraticCurveTo$end$( to, end )
	{
		this.js.quadraticCurveTo( to.x.js, to.y.js, end.x.js, end.y.js );
		return this;
	}

	$rect$( rect )
	{
		this.js.rect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js );
		return this;
	}

	$fillRect$( rect )
	{
		this.js.fillRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js );
		return this;
	}

	$clearRect$( rect )
	{
		this.js.clearRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js );
		return this;
	}

	$roundRect$radius$( rect, radius )
	{
		this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radius.js );
		return this;
	}

	$roundRect$radii$( rect, radii )
	{
		this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radii.$toJs() );
		return this;
	}

	$strokeRect$( rect )
	{
		this.js.strokeRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js );
		return this;
	}

	$clip()
	{
		this.js.clip();
		return this;
	}

	$drawImage$dest$( image, dest )
	{
		this.js.drawImage( image.js, dest.x.js, dest.y.js );
		return this;
	}

	$drawImage$destRect$( image, destRect )
	{
		this.js.drawImage( image.js, destRect.origin.x.js, destRect.origin.y.js, destRect.extent.x.js, destRect.extent.y.js );
		return this;
	}

	$drawImage$sourceRect$destRect$( image, sourceRect, destRect )
	{
		this.js.drawImage( image.js,
		sourceRect.origin.x.js, sourceRect.origin.y.js, sourceRect.extent.x.js, sourceRect.extent.y.js,
		destRect.origin.x.js, destRect.origin.y.js, destRect.extent.x.js, destRect.extent.y.js );
		return this;
	}

	$createPattern$repetition$( image, repetition )
	{
		return stCanvasPattern$class.$fromJs$( this.js.createPattern( image.js, repetition.js ) );
	}

	$createImageData$( size )
	{
		return stImageData$class.$fromJs$( this.js.createImageData( size.x.js, size.y.js ) );
	}

	$getImageData$( rect )
	{
		return stImageData$class.$fromJs$( this.js.getImageData( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js ) );
	}

	$putImageData$dest$( imageData, dest )
	{
		this.js.putImageData( imageData.js, dest.x.js, dest.y.js );
		return this;
	}

	$putImageData$dest$sourceRect$( imageData, dest, sourceRect )
	{
		this.js.putImageData( imageData.js, dest.x.js, dest.y.js, sourceRect.origin.x.js, sourceRect.origin.y.js, sourceRect.extent.x.js, sourceRect.extent.y.js );
		return this;
	}

	$createLinearGradientFrom$to$( from, to )
	{
		return stCanvasGradient$class.$fromJs$( this.js.createLinearGradient( from.x.js, from.y.js, to.x.js, to.y.js ) );
	}

	$createRadialGradientFrom$radius$to$radius$( from, fromRadius, to, toRadius )
	{
		return stCanvasGradient$class.$fromJs$( this.js.createRadialGradient( from.x.js, from.y.js, fromRadius.js, to.x.js, to.y.js, toRadius.js ) );
	}

	$fillText$at$( text, point )
	{
		this.js.fillText( text.js, point.x.js, point.y.js );
		return this;
	}

	$fillText$at$maxWidth$( text, point, maxWidth )
	{
		this.js.fillText( text.js, point.x.js, point.y.js, maxWidth.js );
		return this;
	}

	$measureText$( text )
	{
		return stTextMetrics$class.$fromJs$( this.js.measureText( text.js ) );
	}

	$strokeText$at$( text, point )
	{
		this.js.strokeText( text.js, point.x.js, point.y.js );
		return this;
	}

	$strokeText$at$maxWidth$( text, point, maxWidth )
	{
		this.js.strokeText( text.js, point.x.js, point.y.js, maxWidth.js );
		return this;
	}

	$getContextAttributes()
	{
		return stContextAttributes$class.$fromJs$( this.js.getContextAttributes() );
	}

	$isContextLost()
	{
		return stBoolean$class.$fromJs$( this.js.isContextLost() );
	}

	$lineTo$( point )
	{
		this.js.lineTo( point.x.js, point.y.js );
		return this;
	}

	$setLineDash$( segments )
	{
		this.js.setLineDash( segments.$toJs() );
		return this;
	}

	$getLineDash()
	{
		return stArray$class.$fromJs$elementClass$( this.js.getLineDash(), stInteger$class );
	}

	$isPointInPath$( point )
	{
		return stBoolean$class.$fromJs$( this.js.isPointInPath( point.x.js, point.y.js ) );
	}

	$isPointInStroke$( point )
	{
		return stBoolean$class.$fromJs$( this.js.isPointInStroke( point.x.js, point.y.js ) );
	}

	$reset()
	{
		this.js.reset();
		return this;
	}

	$save()
	{
		this.js.save();
		return this;
	}

	$restore()
	{
		this.js.restore();
		return this;
	}

	$getTransform()
	{
		return stDomMatrix$class.$fromJs$( this.js.getTransform() );
	}

	$setTransform$( matrix )
	{
		this.js.setTransform( matrix.js );
		return this;
	}

	$transform$( matrix )
	{
		this.js.transform( matrix.js.a, matrix.js.b, matrix.js.c, matrix.js.d, matrix.js.e, matrix.js.f );
		return this;
	}

	$rotate$( angle )
	{
		this.js.rotate( angle.js );
		return this;
	}

	$scale$( point )
	{
		this.js.scale( point.x.js, point.y.js );
		return this;
	}

	$translate$( point )
	{
		this.js.translate( point.x.js, point.y.js );
		return this;
	}

	$resetTransform()
	{
		this.js.resetTransform();
		return this;
	}

}

export class StContextAttributes extends StJsObject
{
	$class()
	{
		return stContextAttributes$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$alpha()
	{
		return stBoolean$class.$fromJs$( this.js.alpha );
	}

	$colorSpace()
	{
		return stString$class.$fromJs$( this.js.colorSpace );
	}

	$desynchronized()
	{
		return stBoolean$class.$fromJs$( this.js.desynchronized );
	}

	$willReadFrequently()
	{
		return stBoolean$class.$fromJs$( this.js.willReadFrequently == true );
	}

}

export class StDomMatrix extends StJsObject
{
	$class()
	{
		return stDomMatrix$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$a()
	{
		return stFloat$class.$fromJs$( this.js.a );
	}

	$b()
	{
		return stFloat$class.$fromJs$( this.js.b );
	}

	$c()
	{
		return stFloat$class.$fromJs$( this.js.c );
	}

	$d()
	{
		return stFloat$class.$fromJs$( this.js.d );
	}

	$e()
	{
		return stFloat$class.$fromJs$( this.js.e );
	}

	$f()
	{
		return stFloat$class.$fromJs$( this.js.f );
	}

	$m11()
	{
		return stFloat$class.$fromJs$( this.js.m11 );
	}

	$m12()
	{
		return stFloat$class.$fromJs$( this.js.m12 );
	}

	$m13()
	{
		return stFloat$class.$fromJs$( this.js.m13 );
	}

	$m14()
	{
		return stFloat$class.$fromJs$( this.js.m14 );
	}

	$m21()
	{
		return stFloat$class.$fromJs$( this.js.m21 );
	}

	$m22()
	{
		return stFloat$class.$fromJs$( this.js.m22 );
	}

	$m23()
	{
		return stFloat$class.$fromJs$( this.js.m23 );
	}

	$m24()
	{
		return stFloat$class.$fromJs$( this.js.m24 );
	}

	$m31()
	{
		return stFloat$class.$fromJs$( this.js.m31 );
	}

	$m32()
	{
		return stFloat$class.$fromJs$( this.js.m32 );
	}

	$m33()
	{
		return stFloat$class.$fromJs$( this.js.m33 );
	}

	$m34()
	{
		return stFloat$class.$fromJs$( this.js.m34 );
	}

	$m41()
	{
		return stFloat$class.$fromJs$( this.js.m41 );
	}

	$m42()
	{
		return stFloat$class.$fromJs$( this.js.m42 );
	}

	$m43()
	{
		return stFloat$class.$fromJs$( this.js.m43 );
	}

	$m44()
	{
		return stFloat$class.$fromJs$( this.js.m44 );
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

	$toJson()
	{
		return stJsObject$class.$fromJs$( this.js.toJSON() );
	}

	$copy()
	{
		return stDomMatrix$class.$fromMatrix$( this );
	}

	$is2d()
	{
		return stBoolean$class.$fromJs$( this.js.is2D );
	}

	$is3d()
	{
		return this.$is2d().$not();
	}

	$isIdentity()
	{
		return stBoolean$class.$fromJs$( this.js.isIdentity );
	}

	$equals2d$precision$( matrix, precision )
	{
		return this.$is2d().$$amp( matrix.$is2d() ).$$amp( this.$a().$$minus( matrix.$a() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$b().$$minus( matrix.$b() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$c().$$minus( matrix.$c() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$d().$$minus( matrix.$d() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$e().$$minus( matrix.$e() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$f().$$minus( matrix.$f() ).$abs().$$lt$equeals( precision ) );
	}

	$equals3d$precision$( matrix, precision )
	{
		return this.$is3d().$$amp( matrix.$is3d() ).$$amp( this.$m11().$$minus( matrix.$m11() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m12().$$minus( matrix.$m12() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m13().$$minus( matrix.$m13() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m14().$$minus( matrix.$m14() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m21().$$minus( matrix.$m21() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m22().$$minus( matrix.$m22() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m23().$$minus( matrix.$m23() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m24().$$minus( matrix.$m24() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m31().$$minus( matrix.$m31() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m32().$$minus( matrix.$m32() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m33().$$minus( matrix.$m33() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m34().$$minus( matrix.$m34() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m41().$$minus( matrix.$m41() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m42().$$minus( matrix.$m42() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m43().$$minus( matrix.$m43() ).$abs().$$lt$equeals( precision ) ).$$amp( this.$m44().$$minus( matrix.$m44() ).$abs().$$lt$equeals( precision ) );
	}

	$flipX()
	{
		return stDomMatrix$class.$fromJs$( this.js.flipX() );
	}

	$flipY()
	{
		return stDomMatrix$class.$fromJs$( this.js.flipY() );
	}

	$inverse()
	{
		return stDomMatrix$class.$fromJs$( this.js.inverse() );
	}

	$multiply$( matrix )
	{
		return stDomMatrix$class.$fromJs$( this.js.multiply( matrix.js ) );
	}

	$rotateAxis$angle$( degrees3d, angle )
	{
		return stDomMatrix$class.$fromJs$( this.js.rotateAxisAngle( degrees3d.x.js, degrees3d.y.js,  degrees3d.z.js, angle.js ) );
	}

	$rotate$( angle )
	{
		return stDomMatrix$class.$fromJs$( this.js.rotate( angle.js ) );
	}

	$rotateFromVector$( point3d )
	{
		return stDomMatrix$class.$fromJs$( this.js.rotate( point3d.x.js, point3d.y.js, point3d.z.js ) );
	}

	$scale$( scale3d )
	{
		return stDomMatrix$class.$fromJs$( this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js ) );
	}

	$scale$origin$( scale3d, origin3d )
	{
		return stDomMatrix$class.$fromJs$( this.js.rotate( scale3d.x.js, scale3d.y.js, scale3d.z.js, origin3d.x.js, origin3d.y.js, origin3d.z.js  ) );
	}

	$transformPoint$( point3d )
	{
		let domPoint = stNil;
		let result = stNil;
		domPoint = stDomPoint$class.$fromPoint3d$( point3d );
		result = stDomPoint$class.$fromJs$( this.js.transformPoint( domPoint.js ) );
		return result.$toPoint3d();
	}

	$translate$( point3d )
	{
		let domPoint = stNil;
		domPoint = stDomPoint$class.$fromPoint3d$( point3d );
		return stDomMatrix$class.$fromJs$( this.js.translate( domPoint.js.x, domPoint.js.y, domPoint.js.z ) );
	}

	$invertSelf()
	{
		this.js.invertSelf();
		return this;
	}

	$multiplySelf$( matrix )
	{
		this.js.multiplySelf( matrix.js );
		return this;
	}

	$preMultiplySelf$( matrix )
	{
		this.js.preMultiplySelf( matrix.js );
		return this;
	}

	$translateSelf$( point3d )
	{
		this.js.translateSelf( point3d.x.js, point3d.y.js, point3d.z.js );
		return this;
	}

	$scaleSelf$( scale )
	{
		this.js.scaleSelf( scale.js );
		return this;
	}

	$scaleSelf$origin$( scale, origin )
	{
		this.js.scaleSelf( scale.js, origin.x.js, origin.y.js, origin.z.js );
		return this;
	}

	$scale3dSelf$( scale3d )
	{
		this.js.scale3dSelf( scale3d.x.js, scale3d.y.js, scale3d.z.js );
		return this;
	}

	$scale3dSelf$origin$( scale3d, origin )
	{
		this.js.scale3dSelf( scale3d.x.js, scale3d.y.js, scale3d.z.js, origin.x.js, origin.y.js, origin.z.js );
		return this;
	}

	$rotateSelf$( degrees3d )
	{
		this.js.rotateSelf( degrees3d.x.js, degrees3d.y.js, degrees3d.z.js );
		return this;
	}

	$rotateAxisAngleSelf$degrees$( point3d, degrees )
	{
		this.js.rotateAxisAngleSelf( point3d.x.js, point3d.y.js, point3d.z.js, degrees.js );
		return this;
	}

	$rotateFromVectorSelf$( point )
	{
		this.js.rotateFromVectorSelf( point.x.js, point.y.js );
		return this;
	}

	$skewXSelf$( degrees )
	{
		this.js.skewXSelf( degrees.js );
		return this;
	}

	$skewYSelf$( degrees )
	{
		this.js.skewYSelf( degrees.js );
		return this;
	}

	$setMatrixValue$( transform )
	{
		this.js.setMatrixValue( transform.js );
		return this;
	}

}

export class StDomPoint extends StJsObject
{
	$class()
	{
		return stDomPoint$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$toJson()
	{
		return stString$class.$fromJs$( this.js.toJSON() );
	}

	$copy()
	{
		return stDomPoint$class.$fromDomPoint$( this );
	}

	$toPoint()
	{
		return stPoint$class.$x$y$( this.$x(), this.$y() );
	}

	$toPoint3d()
	{
		return stPoint3d$class.$x$y$z$( this.$x(), this.$y(), this.$z() );
	}

	$x()
	{
		return stFloat$class.$fromJs$( this.js.x );
	}

	$x$( x )
	{
		this.js.x = x.js;
		return this;
	}

	$y()
	{
		return stFloat$class.$fromJs$( this.js.y );
	}

	$y$( y )
	{
		this.js.y = y.js;
		return this;
	}

	$z()
	{
		return stFloat$class.$fromJs$( this.js.z );
	}

	$z$( z )
	{
		this.js.z = z.js;
		return this;
	}

	$w()
	{
		return stFloat$class.$fromJs$( this.js.w );
	}

	$w$( w )
	{
		this.js.w = w.js;
		return this;
	}

	$$equeals( domPoint )
	{
		return this.$x().$$equeals( domPoint.$x() ).$$amp( this.$y().$$equeals( domPoint.$y() ) ).$$amp( this.$z().$$equeals( domPoint.$z() ) ).$$amp( this.$w().$$equeals( domPoint.$w() ) );
	}

}

export class StImageBitmap extends StJsObject
{
	$class()
	{
		return stImageBitmap$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$extent()
	{
		return this.$width().$$commat( this.$height() );
	}

	$close()
	{
		this.js.close();
		return this;
	}

}

export class StImageData extends StJsObject
{
	$class()
	{
		return stImageData$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$data()
	{
		return stUint8Array$class.$fromJs$( this.js.data );
	}

	$atPixel$( point )
	{
		let data = stNil;
		let index = stNil;
		let rgba = stNil;
		data = this.$data();
		rgba = stArray$class.$new$( stInteger$class.$fromJs$( 4 ) );
		index = point.$y().$$ast( this.$width() ).$$plus( point.$x() ).$$ast( stInteger$class.$fromJs$( 4 ) );
		rgba.$at$put$( stInteger$class.$fromJs$( 0 ), data.$at$( index ) );
		rgba.$at$put$( stInteger$class.$fromJs$( 1 ), data.$at$( index.$$plus( stInteger$class.$fromJs$( 1 ) ) ) );
		rgba.$at$put$( stInteger$class.$fromJs$( 2 ), data.$at$( index.$$plus( stInteger$class.$fromJs$( 2 ) ) ) );
		rgba.$at$put$( stInteger$class.$fromJs$( 3 ), data.$at$( index.$$plus( stInteger$class.$fromJs$( 3 ) ) ) );
		return rgba;
	}

	$atPixel$put$( point, rgba )
	{
		let index = stNil;
		this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return rgba.$length().$$equeals( stInteger$class.$fromJs$( 4 ) );
			} ) );
		index = point.$y().$$ast( this.$width() ).$$plus( point.$x() ).$$ast( stInteger$class.$fromJs$( 4 ) );
		rgba.$do$( stBlock$class.$fromJs$( ( color ) => {
				return this.js.data[ index.js++ ] = color.js;
			} ) );
		return this;
	}

	$pixelLength()
	{
		return this.$data().$length().$$sol$sol( stInteger$class.$fromJs$( 4 ) );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$extent()
	{
		return this.$width().$$commat( this.$height() );
	}

}

export class StOffscreenCanvas extends StJsObject
{
	$class()
	{
		return stOffscreenCanvas$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StPath2d extends StJsObject
{
	$class()
	{
		return stPath2d$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$addPath$( path )
	{
		this.js.addPath( path.js );
		return this;
	}

	$addPath$transform$( path, domMatrix )
	{
		this.js.addPath( path.js, domMatrix.js );
		return this;
	}

	$closePath()
	{
		this.js.closePath();
		return this;
	}

	$moveTo$( point )
	{
		this.js.moveTo( point.x.js, point.y.js );
		return this;
	}

	$lineTo$( point )
	{
		this.js.lineTo( point.x.js, point.y.js );
		return this;
	}

	$roundRect$radius$( rect, radius )
	{
		this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radius.js );
		return this;
	}

	$roundRect$radii$( rect, radii )
	{
		this.js.roundRect( rect.origin.x.js, rect.origin.y.js, rect.extent.x.js, rect.extent.y.js, radii.$toJs() );
		return this;
	}

	$arc$radius$startAngle$endAngle$counterclockwise$( center, radius, startAngle, endAngle, counterclockwise )
	{
		this.js.arc( center.x.js, center.y.js, radius.js, startAngle.js, endAngle.js, counterclockwise.js );
		return this;
	}

	$arcTo$to$radius$( to1, to2, radius )
	{
		this.js.arcTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, radius.js );
		return this;
	}

	$bezierCurveTo$to$end$( to1, to2, end )
	{
		this.js.bezierCurveTo( to1.x.js, to1.y.js, to2.x.js, to2.y.js, end.x.js, end.y.js );
		return this;
	}

	$ellipse$radii$rotation$startAngle$endAngle$counterclockwise$( center, radii, rotation, startAngle, endAngle, counterclockwise )
	{
		this.js.ellipse( center.x.js, center.y.js , radii.x.js, radii.y.js, rotation.js, startAngle.js, endAngle.js, counterclockwise.js );
		return this;
	}

	$quadraticCurveTo$end$( to, end )
	{
		this.js.quadraticCurveTo( to.x.js, to.y.js, end.x.js, end.y.js );
		return this;
	}

}

export class StTextMetrics extends StJsObject
{
	$class()
	{
		return stTextMetrics$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$width()
	{
		return stFloat$class.$fromJs$( this.js.width );
	}

	$actualBoundingBoxLeft()
	{
		return stFloat$class.$fromJs$( this.js.actualBoundingBoxLeft );
	}

	$actualBoundingBoxRight()
	{
		return stFloat$class.$fromJs$( this.js.actualBoundingBoxRight );
	}

	$actualBoundingBoxAscent()
	{
		return stFloat$class.$fromJs$( this.js.actualBoundingBoxAscent );
	}

	$actualBoundingBoxDescent()
	{
		return stFloat$class.$fromJs$( this.js.actualBoundingBoxDescent );
	}

	$fontBoundingBoxAscent()
	{
		return stFloat$class.$fromJs$( this.js.fontBoundingBoxAscent );
	}

	$fontBoundingBoxDescent()
	{
		return stFloat$class.$fromJs$( this.js.fontBoundingBoxDescent );
	}

	$hangingBaseline()
	{
		return stFloat$class.$fromJs$( this.js.hangingBaseline );
	}

	$alphabeticBaseline()
	{
		return stFloat$class.$fromJs$( this.js.alphabeticBaseline );
	}

	$ideographicBaseline()
	{
		return stFloat$class.$fromJs$( this.js.ideographicBaseline );
	}

}

export class StCssStyleDeclaration extends StJsObject
{
	$class()
	{
		return stCssStyleDeclaration$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$cssText()
	{
		return stString$class.$fromJs$( this.js.cssText );
	}

	$cssText$( text )
	{
		return this.js.cssText = text.js;
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$parentRule()
	{
		return stCssRule$class.$fromJs$( this.js.parentRule );
	}

	$float()
	{
		return stString$class.$fromJs$( this.js.float );
	}

	$float$( text )
	{
		return this.js.float = text.js;
	}

	$getPropertyPriority$( property )
	{
		return stString$class.$fromJs$( this.js.getPropertyPriority( property.js ) );
	}

	$getPropertyValue$( property )
	{
		return stString$class.$fromJs$( this.js.getPropertyValue( property.js ) );
	}

	$item$( index )
	{
		return stString$class.$fromJs$( this.js.item( index.js ) );
	}

	$removeProperty$( property )
	{
		return stString$class.$fromJs$( this.js.getPropertyValue( property.js ) );
	}

	$setProperty$value$( property, value )
	{
		this.js.setProperty( property.js, value.js );
		return this;
	}

}

export class StCssRule extends StJsObject
{
	$class()
	{
		return stCssRule$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$cssText()
	{
		return stString$class.$fromJs$( this.js.cssText );
	}

	$parentRule()
	{
		return stCssRule$class.$fromJsSubRule$( this.js.parentRule );
	}

	$parentStyleSheet()
	{
		return stStyleSheet$class.$fromJs$( this.js.parentStyleSheet );
	}

}

export class StStyleSheet extends StJsObject
{
	$class()
	{
		return stStyleSheet$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$href()
	{
		return stString$class.$fromJs$( this.js.href );
	}

	$media()
	{
		return stMediaList$class.$fromJs$( this.js.media );
	}

	$ownerNode()
	{
		return stNode$class.$fromJsSubNode$( this.js.ownerNode );
	}

	$title()
	{
		return stString$class.$fromJs$( this.js.title != null ? this.js.title : "" );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

}

export class StMediaList extends StJsObject
{
	$class()
	{
		return stMediaList$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StMediaQueryList extends StJsObject
{
	$class()
	{
		return stMediaQueryList$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StMediaStream extends StJsObject
{
	$class()
	{
		return stMediaStream$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StClipboard extends StJsObject
{
	$class()
	{
		return stClipboard$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$readTextThen$( block )
	{
		return stString$class.$fromJs$( this.js.readText()
		.then( text => block.$value$( stString$class.$fromJs$( text ) ) ) );
	}

	$writeText$then$( text, block )
	{
		return stString$class.$fromJs$( this.js.writeText( text.js )
		.then( text => block.$value$( stString$class.$fromJs$( text ) ) ) );
	}

}

export class StCredentialsContainer extends StJsObject
{
	$class()
	{
		return stCredentialsContainer$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StGeolocation extends StJsObject
{
	$class()
	{
		return stGeolocation$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StLockManager extends StJsObject
{
	$class()
	{
		return stLockManager$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StMediaCapabilities extends StJsObject
{
	$class()
	{
		return stMediaCapabilities$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StMediaDevices extends StJsObject
{
	$class()
	{
		return stMediaDevices$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StMediaSession extends StJsObject
{
	$class()
	{
		return stMediaSession$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StNavigator extends StJsObject
{
	$class()
	{
		return stNavigator$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$clipboard()
	{
		return stClipboard$class.$fromJs$( this.js.clipboard );
	}

	$cookieEnabled()
	{
		return stBoolean$class.$fromJs$( this.js.cookieEnabled );
	}

	$credentials()
	{
		return stCredentialsContainer$class.$fromJs$( this.js.credentials );
	}

	$geolocation()
	{
		return stGeolocation$class.$fromJs$( this.js.geolocation );
	}

	$hardwareConcurrency()
	{
		return stInteger$class.$fromJs$( this.js.hardwareConcurrency );
	}

	$language()
	{
		return stString$class.$fromJs$( this.js.language );
	}

	$languages()
	{
		return stArray$class.$fromJs$elementClass$( this.js.languages, stString$class );
	}

	$locks()
	{
		return stLockManager$class.$fromJs$( this.js.locks );
	}

	$maxTouchPoints()
	{
		return stInteger$class.$fromJs$( this.js.maxTouchPoints );
	}

	$mediaCapabilities()
	{
		return stMediaCapabilities$class.$fromJs$( this.js.mediaCapabilities );
	}

	$mediaDevices()
	{
		return stMediaDevices$class.$fromJs$( this.js.mediaDevices );
	}

	$mediaSession()
	{
		return stMediaSession$class.$fromJs$( this.js.mediaSession );
	}

	$onLine()
	{
		return stBoolean$class.$fromJs$( this.js.onLine );
	}

	$pdfViewerEnabled()
	{
		return stBoolean$class.$fromJs$( this.js.pdfViewerEnabled );
	}

	$permissions()
	{
		return stPermissions$class.$fromJs$( this.js.permissions );
	}

	$platform()
	{
		return stString$class.$fromJs$( this.js.platform );
	}

	$serviceWorker()
	{
		return stServiceWorkerContainer$class.$fromJs$( this.js.serviceWorker );
	}

	$storage()
	{
		return stStorageManager$class.$fromJs$( this.js.storage );
	}

	$userAgent()
	{
		return stString$class.$fromJs$( this.js.userAgent );
	}

	$webdriver()
	{
		return stBoolean$class.$fromJs$( this.js.webdriver );
	}

	$sendBeacon$data$( url, data )
	{
		return stBoolean$class.$fromJs$( this.js.sendBeacon( url.js, data.js ) );
	}

	$vibrate$( pattern )
	{
		return stBoolean$class.$fromJs$( this.js.vibrate( pattern.$toJs() ) );
	}

}

export class StPermissions extends StJsObject
{
	$class()
	{
		return stPermissions$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StServiceWorkerContainer extends StJsObject
{
	$class()
	{
		return stServiceWorkerContainer$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StStorageManager extends StJsObject
{
	$class()
	{
		return stStorageManager$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHistory extends StJsObject
{
	$class()
	{
		return stHistory$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StScreen extends StJsObject
{
	$class()
	{
		return stScreen$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$availTop()
	{
		return stInteger$class.$fromJs$( this.js.availTop );
	}

	$availLeft()
	{
		return stInteger$class.$fromJs$( this.js.availLeft );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$availHeight()
	{
		return stInteger$class.$fromJs$( this.js.availHeight );
	}

	$availWidth()
	{
		return stInteger$class.$fromJs$( this.js.availWidth );
	}

	$colorDepth()
	{
		return stInteger$class.$fromJs$( this.js.colorDepth );
	}

	$pixelDepth()
	{
		return stInteger$class.$fromJs$( this.js.pixelDepth );
	}

	$orientation()
	{
		return stScreenOrientation$class.$fromJs$( this.js.orientation );
	}

}

export class StMessageEvent extends StJsObject
{
	$class()
	{
		return stMessageEvent$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$data()
	{
		return stJsObject$class.$fromJs$( this.js.data );
	}

	$lastEventId()
	{
		return stString$class.$fromJs$( this.js.lastEventId );
	}

	$origin()
	{
		return stString$class.$fromJs$( this.js.origin );
	}

	$ports()
	{
		return stArray$class.$fromJs$elemenClass$( this.js.ports, stMessagePort$class );
	}

	$source()
	{
		return stMessagePort$class.$fromJs$( this.js.source );
	}

}

export class StMessagePort extends StJsObject
{
	$class()
	{
		return stMessagePort$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StWorker extends StJsObject
{
	$class()
	{
		return stWorker$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$postMessage$( object )
	{
		this.js.postMessage( object.$toJs() );
		return this;
	}

	$terminate()
	{
		this.js.terminate();
		return this;
	}

	$onMessage$( block )
	{
		this.js.onmessage = ( jsMessageEvent ) => block.$value$( stMessageEvent$class.$fromJs$( jsMessageEvent ) );
		return this;
	}

}

export class StWorkerOptions extends StJsObject
{
	$class()
	{
		return stWorkerOptions$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		this.js.type = type.js;
		return this;
	}

	$credentials()
	{
		return stString$class.$fromJs$( this.js.credentials );
	}

	$credentials$( credentials )
	{
		this.js.credentials = credentials.js;
		return this;
	}

}

export class StSpeechSynthesis extends StEventTarget
{
	$class()
	{
		return stSpeechSynthesis$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StNode extends StEventTarget
{
	$class()
	{
		return stNode$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$baseUri()
	{
		return stString$class.$fromJs$( this.js.baseURI );
	}

	$childNodes()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.childNodes, stBlock$class.$fromJs$( ( node ) => {
				return stNode$class.$fromJsSubNode$( node );
			} ) );
	}

	$firstChild()
	{
		return stNode$class.$fromJsSubNode$( this.js.firstChild );
	}

	$isConnected()
	{
		return stBoolean$class.$fromJs$( this.js.isConnected );
	}

	$lastChild()
	{
		return stNode$class.$fromJsSubNode$( this.js.lastChild );
	}

	$nextSibling()
	{
		return stNode$class.$fromJsSubNode$( this.js.nextSibling );
	}

	$nodeName()
	{
		return stString$class.$fromJs$( this.js.nodeName );
	}

	$nodeType()
	{
		return stInteger$class.$fromJs$( this.js.nodeType );
	}

	$nodeValue()
	{
		return stString$class.$fromJs$( this.js.nodeValue );
	}

	$nodeValue$( nodeValue )
	{
		this.js.nodeValue = nodeValue.js;
		return this;
	}

	$ownerDocument()
	{
		return stDocument$class.$fromJs$( this.js.ownerDocument );
	}

	$parentElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.parentElement );
	}

	$parentNode()
	{
		return stNode$class.$fromJsSubNode$( this.js.parentNode );
	}

	$previousSibling()
	{
		return stNode$class.$fromJsSubNode$( this.js.previousSibling );
	}

	$textContent()
	{
		return stString$class.$fromJs$( this.js.textContent );
	}

	$textContent$( textContent )
	{
		this.js.textContent = textContent.js;
		return this;
	}

	$appendChild$( node )
	{
		this.js.appendChild( node.js );
		return this;
	}

	$cloneNode$( deep )
	{
		return stNode$class.$fromJsSubNode$( this.js.cloneNode( deep.js ) );
	}

	$compareDocumentPosition$( node )
	{
		return stInteger$class.$fromJs$( this.js.compareDocumentPosition( node.js ) );
	}

	$contains$( node )
	{
		return stBoolean$class.$fromJs$( this.js.contains( node.js ) );
	}

	$getRootNode()
	{
		return stNode$class.$fromJsSubNode$( this.js.getRootNode() );
	}

	$getRootNodeComposed()
	{
		return stNode$class.$fromJsSubNode$( this.js.getRootNode( { composed: true } ) );
	}

	$hasChildNodes()
	{
		return stBoolean$class.$fromJs$( this.js.hasChildNodes() );
	}

	$insert$before$( node, referenceNode )
	{
		let jsReferenceNode = stNil;
		jsReferenceNode = referenceNode.$isNil().$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return null;
			} ), stBlock$class.$fromJs$( (  ) => {
				return referenceNode.js;
			} ) );
		this.js.insertBefore( node.js, jsReferenceNode );
		return this;
	}

	$isEqualNode$( node )
	{
		return stBoolean$class.$fromJs$( this.js.isEqualNode( node.js ) );
	}

	$isSameNode$( node )
	{
		return stBoolean$class.$fromJs$( this.js.isSameNode( node.js ) );
	}

	$normalize()
	{
		this.js.normalize();
		return this;
	}

	$remove()
	{
		this.$parentNode().$removeChild$( this );
		return this;
	}

	$removeChild$( node )
	{
		this.js.removeChild( node.js );
		return this;
	}

	$removeChildren()
	{
		this.$childNodes().$do$( stBlock$class.$fromJs$( ( childNode ) => {
				return this.$removeChild$( childNode );
			} ) );
		return this;
	}

	$replaceChild$with$( node, newNode )
	{
		this.js.replaceChild( newNode.js, node.js );
		return this;
	}

}

export class StAnimation extends StEventTarget
{
	$class()
	{
		return stAnimation$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StScreenOrientation extends StEventTarget
{
	$class()
	{
		return stScreenOrientation$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$angle()
	{
		return stString$class.$fromJs$( this.js.angle );
	}

	$lock$onLocked$onError$( orientation, block, errorBlock )
	{
		this.js.lock( orientation.js ).then( () => block.js() ).catch( () => errorBlock.js() );
		return this;
	}

	$unlock()
	{
		this.js.unlock();
		return this;
	}

}

export class StVisualViewport extends StEventTarget
{
	$class()
	{
		return stVisualViewport$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$offsetLeft()
	{
		return stInteger$class.$fromJs$( this.js.offsetLeft );
	}

	$offsetTop()
	{
		return stInteger$class.$fromJs$( this.js.offsetLeft );
	}

	$offset()
	{
		return this.$offsetLeft().$$commat( this.$offsetTop() );
	}

	$pageLeft()
	{
		return stInteger$class.$fromJs$( this.js.pageLeft );
	}

	$pageTop()
	{
		return stInteger$class.$fromJs$( this.js.pageLeft );
	}

	$pageOffset()
	{
		return this.$pageLeft().$$commat( this.$pageTop() );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$size()
	{
		return this.$width().$$commat( this.$height() );
	}

	$scale()
	{
		return stFloat$class.$fromJs$( this.js.scale );
	}

}

export class StWindow extends StEventTarget
{
	$class()
	{
		return stWindow$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$closed()
	{
		return stBoolean$class.$fromJs$( this.js.closed );
	}

	$console()
	{
		return stConsole$class;
	}

	$customElements()
	{
		return stCustomElementRegistry$class.$fromJs$( this.js.customElements );
	}

	$devicePixelRatio()
	{
		return stFloat$class.$fromJs$( this.js.devicePixelRatio );
	}

	$document()
	{
		return stDocument$class.$fromJs$( this.js.document );
	}

	$frameElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.frameElement );
	}

	$frames()
	{
		return stWindow$class.$fromJs$( this.js.frames );
	}

	$history()
	{
		return stHistory$class.$fromJs$( this.js.history );
	}

	$innerHeight()
	{
		return stInteger$class.$fromJs$( this.js.innerHeight );
	}

	$innerWidth()
	{
		return stInteger$class.$fromJs$( this.js.innerWidth );
	}

	$innerSize()
	{
		return this.$innerWidth().$$commat( this.$innerHeight() );
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$localStorage()
	{
		return stStorage$class.$fromJs$( this.js.localStorage );
	}

	$location()
	{
		return stLocation$class.$fromJs$( this.js.location );
	}

	$locationBarVisible()
	{
		return stBoolean$class.$fromJs$( this.js.locationbar.visible );
	}

	$menuBarVisible()
	{
		return stBoolean$class.$fromJs$( this.js.menubar.visible );
	}

	$navigator()
	{
		return stNavigator$class.$fromJs$( this.js.navigator );
	}

	$opener()
	{
		return stWindow$class.$fromJs$( this.js.opener );
	}

	$outerHeight()
	{
		return stInteger$class.$fromJs$( this.js.outerHeight );
	}

	$outerWidth()
	{
		return stInteger$class.$fromJs$( this.js.outerWidth );
	}

	$pageXOffset()
	{
		return this.$scrollX();
	}

	$pageYOffset()
	{
		return this.$scrollY();
	}

	$parent()
	{
		return stWindow$class.$fromJs$( this.js.parent );
	}

	$personalBarVisible()
	{
		return stBoolean$class.$fromJs$( this.js.personalbar.visible );
	}

	$screen()
	{
		return stScreen$class.$fromJs$( this.js.screen );
	}

	$screenLeft()
	{
		return stInteger$class.$fromJs$( this.js.screenLeft );
	}

	$screenTop()
	{
		return stInteger$class.$fromJs$( this.js.screenTop );
	}

	$screenX()
	{
		return stInteger$class.$fromJs$( this.js.screenX );
	}

	$screenY()
	{
		return stInteger$class.$fromJs$( this.js.screenY );
	}

	$screenPos()
	{
		return this.$screenX().$$commat( this.$screenY() );
	}

	$scrollBarsVisible()
	{
		return stBoolean$class.$fromJs$( this.js.scrollbars.visible );
	}

	$scrollX()
	{
		return stInteger$class.$fromJs$( Math.round( this.js.scrollX ) );
	}

	$scrollY()
	{
		return stInteger$class.$fromJs$( Math.round( this.js.scrollY ) );
	}

	$self()
	{
		return stWindow$class.$fromJs$( this.js.self );
	}

	$sessionStorage()
	{
		return stStorage$class.$fromJs$( this.js.sessionStorage );
	}

	$speechSynthesis()
	{
		return stSpeechSynthesis$class.$fromJs$( this.js.speechSynthesis );
	}

	$statusBarVisible()
	{
		return stBoolean$class.$fromJs$( this.js.statusbar.visible );
	}

	$toolBarVisible()
	{
		return stBoolean$class.$fromJs$( this.js.toolbar.visible );
	}

	$top()
	{
		return stWindow$class.$fromJs$( this.js.top );
	}

	$visualViewport()
	{
		return stVisualViewport$class.$fromJs$( this.js.visualViewport );
	}

	$window()
	{
		return stWindow$class.$fromJs$( this.js.window );
	}

	$requestIdleCallback$timeout$( callback, timeout )
	{
		return stInteger$class.$fromJs$( this.js.requestIdleCallback( callback.js, { timeout: timeout.js } ) );
	}

	$cancelIdleCallback$( handle )
	{
		this.js.cancelIdleCallback( handle.js );
		return this;
	}

	$requestAnimationFrame$( callback )
	{
		this.js.requestAnimationFrame( callback.js );
		return this;
	}

	$cancelAnimationFrame$( requestId )
	{
		this.js.cancelAnimationFrame( requestId.js );
		return this;
	}

	$alert$( message )
	{
		this.js.alert( message.js );
		return this;
	}

	$confirm$( message )
	{
		return stBoolean$class.$fromJs$( this.js.confirm( message.js ) );
	}

	$prompt$( message )
	{
		return this.$prompt$defaultValue$( message, stString$class.$fromJs$( '' ) );
	}

	$prompt$defaultValue$( message, defaultValue )
	{
		return stString$class.$fromJs$( this.js.prompt( message.js, defaultValue.js ) );
	}

	$open$target$features$( url, target, features )
	{
		return stWindow$class.$fromJs$( this.js.open( url.js, target.js, features.js ) );
	}

	$moveBy$( delta )
	{
		this.js.moveBy( delta.x.js, delta.y.js );
		return this;
	}

	$moveTo$( point )
	{
		this.js.moveTo( point.x.js, point.y.js );
		return this;
	}

	$close()
	{
		this.js.close();
		return this;
	}

	$blur()
	{
		this.js.blur();
		return this;
	}

	$focus()
	{
		this.js.focus();
		return this;
	}

	$getComputedStyle$( element )
	{
		return stCssStyleDeclaration$class.$fromJs$( this.js.getComputedStyle( element.js ) );
	}

	$getSelection()
	{
		return stSelection$class.$fromJs$( this.js.getSelection() );
	}

	$matchMedia$( mediaQueryString )
	{
		return stMediaQueryList$class.$fromJs$( this.js.matchMedia( mediaQueryString.js ) );
	}

	$postMessage$targetOrigin$( message, targetOrigin )
	{
		this.js.postMessage( message.js, targetOrigin.js );
		return this;
	}

	$print()
	{
		this.js.print();
		return this;
	}

	$resizeBy$( delta )
	{
		this.js.resizeBy( delta.x.js, delta.y.js );
		return this;
	}

	$resizeTo$( size )
	{
		this.js.resizeTo( size.x.js, size.y.js );
		return this;
	}

	$scrollTo$( point )
	{
		this.js.resizeTo( point.x.js, point.y.js );
		return this;
	}

	$scrollTo$behavior$( point, behavior )
	{
		this.js.scrollTo( { top: point.y.js, left: point.x.js, behavior: behavior.js } );
		return this;
	}

	$scrollBy$( point )
	{
		this.js.scrollBy( point.x.js, point.y.js );
		return this;
	}

	$scrollBy$behavior$( point, behavior )
	{
		this.js.scrollBy( { top: point.y.js, left: point.x.js, behavior: behavior.js } );
		return this;
	}

	$stop()
	{
		this.js.stop();
		return this;
	}

}

export class StWorkerGlobalScope extends StEventTarget
{
	$class()
	{
		return stWorkerGlobalScope$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StRange extends StAbstractRange
{
	$class()
	{
		return stRange$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$commonAncestorContainer()
	{
		return stNode$class.$fromJsSubNode$( this.js.commonAncestorContainer );
	}

	$collapse()
	{
		this.js.collapse();
		return this;
	}

	$collapseToStart()
	{
		this.js.collapse( true );
		return this;
	}

	$compareBoundaryPoints$with$( how, range )
	{
		return stInteger$class.$fromJs$( this.js.compareBoundaryPoints( how.js, range.js ) );
	}

	$comparePoint$offset$( node, offset )
	{
		return stInteger$class.$fromJs$( this.js.comparePoint( node.js, offset.js ) );
	}

	$cloneContents()
	{
		return stDocumentFragment$class.$fromJs$( this.js.cloneContents() );
	}

	$cloneRange()
	{
		return stRange$class.$fromJs$( this.js.cloneRange() );
	}

	$createContextualFragment$( tagString )
	{
		return stDocumentFragment$class.$fromJs$( this.js.createContextualFragment( tagString.js ) );
	}

	$deleteContents()
	{
		this.js.deleteContents();
		return this;
	}

	$extractContents()
	{
		return stDocumentFragment$class.$fromJs$( this.js.extractContents() );
	}

	$getBoundingClientRect()
	{
		return stRect$class.$fromJs$( this.js.getBoundingClientRect() );
	}

	$getClientRects()
	{
		return stArray$class.$fromJs$elementClass$( this.js.getClientRects(), stRect$class );
	}

	$isPointInRange$offset$( node, offset )
	{
		return stBoolean$class.$fromJs$( this.js.isPointInRange( node.js, offset.js ) );
	}

	$insertNode$( node )
	{
		this.js.insertNode( node.js );
		return this;
	}

	$intersectsNode$( node )
	{
		return stBoolean$class.$fromJs$( this.js.intersectsNode( node.js ) );
	}

	$selectNode$( node )
	{
		this.js.selectNode( node.js );
		return this;
	}

	$selectNodeContents$( node )
	{
		this.js.selectNodeContents( node.js );
		return this;
	}

	$setEnd$offset$( node, offset )
	{
		this.js.setEnd( node.js, offset.js );
		return this;
	}

	$setEndAfter$( node )
	{
		this.js.setEndAfter( node.js );
		return this;
	}

	$setEndBefore$( node )
	{
		this.js.setEndBefore( node.js );
		return this;
	}

	$setStart$offset$( node, offset )
	{
		this.js.setStart( node.js, offset.js );
		return this;
	}

	$setStartAfter$( node )
	{
		this.js.setStartAfter( node.js );
		return this;
	}

	$setStartBefore$( node )
	{
		this.js.setStartBefore( node.js );
		return this;
	}

	$surroundContents$( parentNode )
	{
		this.js.surroundContents( parentNode.js );
		return this;
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

}

export class StCssImportRule extends StCssRule
{
	$class()
	{
		return stCssImportRule$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$href()
	{
		return stString$class.$fromJs$( this.js.href );
	}

	$media()
	{
		return stMediaList$class.$fromJs$( this.js.media );
	}

	$styleSheet()
	{
		return stCssStyleSheet$class.$fromJs$( this.js.styleSheet );
	}

}

export class StCssStyleRule extends StCssRule
{
	$class()
	{
		return stCssStyleRule$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$selectorText()
	{
		return stString$class.$fromJs$( this.js.selectorText );
	}

	$style()
	{
		return stCssStyleDeclaration$class.$fromJs$( this.js.style );
	}

}

export class StCssStyleSheet extends StStyleSheet
{
	$class()
	{
		return stCssStyleSheet$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$cssRules()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.cssRules, stBlock$class.$fromJs$( ( jsCssRule ) => {
				return stCssRule$class.$fromJsSubRule$( jsCssRule );
			} ) );
	}

	$ownerRule()
	{
		return stCssRule$class.$fromJsSubRule$( this.js.ownerRule );
	}

	$findStyleRule$( selectorText )
	{
		return this.$cssRules().$find$( stBlock$class.$fromJs$( ( cssRule ) => {
				return cssRule.$class().$$equeals( stCssStyleRule$class ).$and$( stBlock$class.$fromJs$( (  ) => {
				return cssRule.$selectorText().$$equeals( selectorText );
			} ) );
			} ) );
	}

	$findStyleRuleIndex$( selectorText )
	{
		return this.$cssRules().$findIndex$( stBlock$class.$fromJs$( ( cssRule ) => {
				return cssRule.$class().$$equeals( stCssStyleRule$class ).$and$( stBlock$class.$fromJs$( (  ) => {
				return cssRule.$selectorText().$$equeals( selectorText );
			} ) );
			} ) );
	}

	$deleteRule$( index )
	{
		this.js.deleteRule( index.js );
		return this;
	}

	$insertRule$index$( rule, index )
	{
		this.js.insertRule( rule.js, index.js );
		return this;
	}

	$replace$( text )
	{
		this.js.replaceSync( text.js );
		return this;
	}

}

export class StDocument extends StNode
{
	$class()
	{
		return stDocument$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$activeElement()
	{
		return stHtmlElement$class.$fromJsSubElement$( this.js.activeElement );
	}

	$body()
	{
		return stHtmlBodyElement$class.$fromJs$( this.js.body );
	}

	$body$( body )
	{
		this.js.body = body.js;
		return this;
	}

	$characterSet()
	{
		return stString$class.$fromJs$( this.js.characterSet );
	}

	$childElementCount()
	{
		return stInteger$class.$fromJs$( this.js.childElementCount );
	}

	$children()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.children, stBlock$class.$fromJs$( ( element ) => {
				return stElement$class.$fromJsSubElement$( element );
			} ) );
	}

	$contentType()
	{
		return stString$class.$fromJs$( this.js.contentType );
	}

	$doctype()
	{
		return stDocumentType$class.$fromJs$( this.js.doctype );
	}

	$documentElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.documentElement );
	}

	$documentUri()
	{
		return stString$class.$fromJs$( this.js.documentURI );
	}

	$embeds()
	{
		return stElement$class.$fromJsSubElements$( this.js.embeds );
	}

	$firstElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.firstElementChild );
	}

	$lastElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.lastElementChild );
	}

	$forms()
	{
		return stArray$class.$fromJs$elementClass$( this.js.embeds, stHtmlFormElement$class );
	}

	$fullscreenElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.fullscreenElement );
	}

	$head()
	{
		return stHtmlHeadElement$class.$fromJs$( this.js.head );
	}

	$hasFocus()
	{
		return stBoolean$class.$fromJs$( this.js.hasFocus() );
	}

	$hidden()
	{
		return stBoolean$class.$fromJs$( this.js.hidden );
	}

	$images()
	{
		return stArray$class.$fromJs$elementClass$( this.js.images, stHtmlImageElement$class );
	}

	$implementation()
	{
		return stDomImplementation$class.$fromJs$( this.js.implementation );
	}

	$links()
	{
		return stArray$class.$fromJs$elementClass$( this.js.links, stHtmlLinkElement$class );
	}

	$plugins()
	{
		return stArray$class.$fromJs$elementClass$( this.js.plugins, stHtmlEmbedElement$class );
	}

	$pointerLockElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.pointerLockElement );
	}

	$scripts()
	{
		return stArray$class.$fromJs$elementClass$( this.js.scripts, stHtmlScriptElement$class );
	}

	$styleSheets()
	{
		return stArray$class.$fromJs$elementClass$( this.js.styleSheets, stCssStyleSheet$class );
	}

	$visibilityState()
	{
		return stString$class.$fromJs$( this.js.visibilityState );
	}

	$cookie()
	{
		return stString$class.$fromJs$( this.js.cookie );
	}

	$cookie$( cookie )
	{
		this.js.cookie = cookie.js;
		return this;
	}

	$defaultView()
	{
		return stWindow$class.$fromJs$( this.js.defaultView );
	}

	$designMode()
	{
		return stString$class.$fromJs$( this.js.designMode );
	}

	$designMode$( designMode )
	{
		this.js.designMode = designMode.js;
		return this;
	}

	$dir()
	{
		return stString$class.$fromJs$( this.js.dir );
	}

	$dir$( dir )
	{
		this.js.dir = dir.js;
		return this;
	}

	$lastModified()
	{
		return stString$class.$fromJs$( this.js.lastModified );
	}

	$location()
	{
		return stLocation$class.$fromJs$( this.js.location );
	}

	$readyState()
	{
		return stString$class.$fromJs$( this.js.readyState );
	}

	$referrer()
	{
		return stString$class.$fromJs$( this.js.referrer );
	}

	$title()
	{
		return stString$class.$fromJs$( this.js.title );
	}

	$title$( title )
	{
		this.js.title = title.js;
		return this;
	}

	$url()
	{
		return stString$class.$fromJs$( this.js.URL );
	}

	$adoptNode$( node )
	{
		return stNode$class.$fromJsSubNode$( this.js.adoptNode( node.js ) );
	}

	$append$( node )
	{
		return stNode$class.$fromJs$( this.js.append( node.js ) );
	}

	$createAttribute$( name )
	{
		return stAttr$class.$fromJs$( this.js.createAttribute( name.js ) );
	}

	$createComment$( data )
	{
		return stComment$class.$fromJs$( this.js.createComment( data.js ) );
	}

	$createDocumentFragment()
	{
		return stDocumentFragment$class.$fromJs$( this.js.createDocumentFragment() );
	}

	$createElement$( tagName )
	{
		return stElement$class.$fromJsSubElement$( this.js.createElement( tagName.js ) );
	}

	$createRange()
	{
		return stRange$class.$fromJs$( this.js.createRange() );
	}

	$createTextNode$( text )
	{
		return stText$class.$fromJs$( this.js.createTextNode( text.js ) );
	}

	$elementFromPoint$( point )
	{
		return stElement$class.$fromJsSubElement$( this.js.elementFromPoint( point.x.js, point.y.js ) );
	}

	$elementsFromPoint$( point )
	{
		return stElement$class.$fromJsSubElements$( this.js.elementsFromPoint( point.x.js, point.y.js ) );
	}

	$getElementById$( id )
	{
		return stElement$class.$fromJsSubElement$( this.js.getElementById( id.js ) );
	}

	$getElementById$class$( id, class$ )
	{
		let element = stNil;
		element = stElement$class.$fromJsSubElement$( this.js.getElementById( id.js ) );
		this.$assert$( stBlock$class.$fromJs$( (  ) => {
				return element.$class().$$equeals( class$ );
			} ) );
		return element;
	}

	$getElementsByClassName$( className )
	{
		return stElement$class.$fromJsSubElements$( this.js.getElementsByClassName( className.js ) );
	}

	$getElementsByTagName$( tagName )
	{
		return stElement$class.$fromJsSubElements$( this.js.getElementsByTagName( tagName.js ) );
	}

	$getSelection()
	{
		return stSelection$class.$fromJs$( this.js.getSelection() );
	}

	$importNode$deep$( node, deep )
	{
		return stNode$class.$fromJsSubNode$( this.js.importNode( node.js, deep.js ) );
	}

	$prepend$( node )
	{
		return stNode$class.$fromJs$( this.js.prepend( node.js ) );
	}

	$querySelector$( selector )
	{
		return stElement$class.$fromJsSubElement$( this.js.querySelector( selector.js ) );
	}

	$querySelectorAll$( selector )
	{
		return stElement$class.$fromJsSubElements$( this.js.querySelectorAll( selector.js ) );
	}

	$replaceChildren$( elements )
	{
		this.js.replaceChildren( elements.$toJs() );
		return this;
	}

	$close()
	{
		this.js.close();
		return this;
	}

	$getElementsByName$( name )
	{
		return stElement$class.$fromJsSubElements$( this.js.getElementsByName( name.js ) );
	}

	$open()
	{
		this.js.open();
		return this;
	}

	$write$( html )
	{
		this.js.write( html.js );
		return this;
	}

	$writeln$( html )
	{
		this.js.writeln( html.js );
		return this;
	}

}

export class StDocumentFragment extends StNode
{
	$class()
	{
		return stDocumentFragment$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$childElementCount()
	{
		return stInteger$class.$fromJs$( this.js.childElementCount );
	}

	$children()
	{
		return stElement$class.$fromJsSubElements$( this.js.children );
	}

	$firstElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.firstElementChild );
	}

	$lastElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.lastElementChild );
	}

	$append$( node )
	{
		this.js.append( node.js );
		return this;
	}

	$prepend$( node )
	{
		this.js.prepend( node.js );
		return this;
	}

	$querySelector$( selector )
	{
		return stElement$class.$fromJsSubElement$( this.js.querySelector( selector.js ) );
	}

	$querySelectorAll$( selector )
	{
		return stElement$class.$fromJsSubElements$( this.js.querySelectorAll( selector.js ) );
	}

	$replaceChildren$( nodes )
	{
		this.js.replaceChildren();
		nodes.$do$( stBlock$class.$fromJs$( ( node ) => {
				return this.$append$( node );
			} ) );
		return this;
	}

}

export class StDocumentType extends StNode
{
	$class()
	{
		return stDocumentType$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$publicId()
	{
		return stString$class.$fromJs$( this.js.publicId );
	}

	$systemId()
	{
		return stString$class.$fromJs$( this.js.systemId );
	}

	$after$( node )
	{
		this.js.after( node.js );
		return this;
	}

	$before$( node )
	{
		this.js.before( node.js );
		return this;
	}

	$replaceWith$( node )
	{
		this.js.replaceWith( node.js );
		return this;
	}

}

export class StElement extends StNode
{
	$class()
	{
		return stElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$assignedSlot()
	{
		return stHtmlSlotElement$class.$fromJs$( this.js.assignedSlot );
	}

	$attributes()
	{
		return stNamedNodeMap$class.$fromJs$( this.js.attributes );
	}

	$childElementCount()
	{
		return stInteger$class.$fromJs$( this.js.childElementCount );
	}

	$children()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.children, stBlock$class.$fromJs$( ( element ) => {
				return stElement$class.$fromJsSubElement$( element );
			} ) );
	}

	$classList()
	{
		return stDomTokenList$class.$fromJs$( this.js.classList );
	}

	$className()
	{
		return stString$class.$fromJs$( this.js.className );
	}

	$className$( className )
	{
		this.js.className = className.js;
		return this;
	}

	$clientHeight()
	{
		return stInteger$class.$fromJs$( this.js.clientHeight );
	}

	$clientLeft()
	{
		return stInteger$class.$fromJs$( this.js.clientLeft );
	}

	$clientTop()
	{
		return stInteger$class.$fromJs$( this.js.clientTop );
	}

	$clientWidth()
	{
		return stInteger$class.$fromJs$( this.js.clientWidth );
	}

	$firstElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.firstElementChild );
	}

	$id()
	{
		return stString$class.$fromJs$( this.js.id );
	}

	$id$( id )
	{
		this.js.id = id.js;
		return this;
	}

	$name()
	{
		return this.$getAttribute$( stString$class.$fromJs$( 'name' ) );
	}

	$innerHtml()
	{
		return stString$class.$fromJs$( this.js.innerHTML );
	}

	$innerHtml$( html )
	{
		this.js.innerHTML = html.js;
		return this;
	}

	$lastElementChild()
	{
		return stElement$class.$fromJsSubElement$( this.js.lastElementChild );
	}

	$localName()
	{
		return stString$class.$fromJs$( this.js.localName );
	}

	$namespaceUri()
	{
		return stString$class.$fromJs$( this.js.namespaceURI );
	}

	$nextElementSibling()
	{
		return stElement$class.$fromJsSubElement$( this.js.nextElementSibling );
	}

	$outerHtml()
	{
		return stString$class.$fromJs$( this.js.outerHTML );
	}

	$part()
	{
		return stDomTokenList$class.$fromJs$( this.js.part );
	}

	$prefix()
	{
		return stString$class.$fromJs$( this.js.prefix );
	}

	$previousElementSibling()
	{
		return stElement$class.$fromJsSubElement$( this.js.previousElementSibling );
	}

	$scrollHeight()
	{
		return stInteger$class.$fromJs$( this.js.scrollHeight );
	}

	$scrollLeft()
	{
		return stInteger$class.$fromJs$( this.js.scrollLeft );
	}

	$scrollTop()
	{
		return stInteger$class.$fromJs$( this.js.scrollTop );
	}

	$scrollWidth()
	{
		return stInteger$class.$fromJs$( this.js.scrollWidth );
	}

	$shadowRoot()
	{
		return stShadowRoot$class.$fromJs$( this.js.shadowRoot );
	}

	$slot()
	{
		return stString$class.$fromJs$( this.js.slot );
	}

	$tagName()
	{
		return stString$class.$fromJs$( this.js.tagName );
	}

	$after$( node )
	{
		this.js.after( node.js );
		return this;
	}

	$attachShadow$delegatesFocus$( aMode, aDelegatesFocus )
	{
		let options = { mode: aMode.js, delegatesFocus: aDelegatesFocus.js };
		return stShadowRoot$class.$fromJs$( this.js.attachShadow( options ) );
	}

	$append$( node )
	{
		this.js.append( node.js );
		return this;
	}

	$before$( node )
	{
		this.js.before( node.js );
		return this;
	}

	$closest$( selector )
	{
		return stElement$class.$fromJsSubElement$( this.js.closest( selector.js ) );
	}

	$dispatchEvent$( event )
	{
		this.js.dispatchEvent( event.js );
		return this;
	}

	$getAttribute$( name )
	{
		return stString$class.$fromJs$( this.js.getAttribute( name.js ) );
	}

	$getAttributeNames()
	{
		return stArray$class.$fromJsStrings$( this.js.getAttributeNames() );
	}

	$getAttributeNode$( name )
	{
		return stAttr$class.$fromJs$( this.js.getAttributeNode( name.js ) );
	}

	$getBoundingClientRect()
	{
		return stRect$class.$fromJs$( this.js.getBoundingClientRect() );
	}

	$getClientRects()
	{
		return stArray$class.$fromJs$elementClass$( this.js.getClientRects(), stRect$class );
	}

	$getElementsByClassName$( name )
	{
		return stArray$class.$fromJs$elementConverter$( this.js.getElementsByClassName( name.js ), stBlock$class.$fromJs$( ( jsElement ) => {
				return stElement$class.$fromJsSubElement$( jsElement );
			} ) );
	}

	$getElementsByTagName$( name )
	{
		return stArray$class.$fromJs$elementConverter$( this.js.getElementsByTagName( name.js ), stBlock$class.$fromJs$( ( jsElement ) => {
				return stElement$class.$fromJsSubElement$( jsElement );
			} ) );
	}

	$hasAttribute$( name )
	{
		return stBoolean$class.$fromJs$( this.js.hasAttribute( name.js ) );
	}

	$hasAttributes()
	{
		return stBoolean$class.$fromJs$( this.js.hasAttributes() );
	}

	$hasPointerCapture$( pointerId )
	{
		return stBoolean$class.$fromJs$( this.js.hasPointerCapture( pointerId.js ) );
	}

	$insertAdjacentElement$position$( element, position )
	{
		this.js.insertAdjacentElement( position.js, element.js );
		return this;
	}

	$insertAdjacentHtml$position$( html, position )
	{
		this.js.insertAdjacentHTML( position.js, html.js );
		return this;
	}

	$insertAdjacentText$position$( text, position )
	{
		this.js.insertAdjacentText( position.js, text.js );
		return this;
	}

	$matches$( selector )
	{
		return stBoolean$class.$fromJs$( this.js.matches( selector.js ) );
	}

	$prepend$( node )
	{
		this.js.prepend( node.js );
		return this;
	}

	$querySelector$( selector )
	{
		return stElement$class.$fromJsSubElement$( this.js.querySelector( selector.js ) );
	}

	$querySelectorAll$( selector )
	{
		return stArray$class.$fromJs$elementConverter$( this.js.querySelectorAll( selector.js ), stBlock$class.$fromJs$( ( jsElement ) => {
				return stElement$class.$fromJsSubElement$( jsElement );
			} ) );
	}

	$releasePointerCapture$( id )
	{
		this.js.releasePointerCapture( id.js );
		return this;
	}

	$remove()
	{
		this.js.remove();
		return this;
	}

	$removeAttribute$( attrName )
	{
		this.js.removeAttribute( attrName.js );
		return this;
	}

	$removeAttributeNode$( attr )
	{
		this.js.removeAttributeNode( attr.js );
		return this;
	}

	$replaceChildren$( nodes )
	{
		this.js.replaceChildren( nodes.$toJs() );
		return this;
	}

	$replaceWith$( node )
	{
		this.js.replaceWith( node.js );
		return this;
	}

	$requestFullscreen$onError$navigationUi$( block, errorBlock, navigationUi )
	{
		
		this.js.requestFullscreen( navigationUi.js )
		.then( block.func() )
		.catch( errorBlock.func() );
		return this;
	}

	$requestPointerLock()
	{
		this.js.requestPointerLock();
		return this;
	}

	$scrollTo$( point )
	{
		this.js.scrollTo( point.x.js, point.y.js );
		return this;
	}

	$scrollTo$behavior$( point, behavior )
	{
		this.js.scrollTo( { top: point.y.js, left: point.x.js, behavior: behavior.js } );
		return this;
	}

	$scrollBy$( point )
	{
		this.js.scrollBy( point.x.js, point.y.js );
		return this;
	}

	$scrollBy$behavior$( point, behavior )
	{
		this.js.scrollBy( { top: point.y.js, left: point.x.js, behavior: behavior.js } );
		return this;
	}

	$scrollIntoView$( alignToTop )
	{
		this.js.scrollIntoView( alignToTop.js );
		return this;
	}

	$scrollIntoViewBehavior$block$inline$( behavior, block, inline )
	{
		this.js.scrollIntoView( { behavior: behavior.js, block: block.js, inline: inline.js } );
		return this;
	}

	$setAttribute$value$( name, value )
	{
		this.js.setAttribute( name.js, value.js );
		return this;
	}

	$setAttributeNode$( attribute )
	{
		this.js.setAttributeNode( attribute.js );
		return this;
	}

	$setPointerCapture$( pointerId )
	{
		this.js.setPointerCapture( pointerId.js );
		return this;
	}

	$toggleAttribute$( name )
	{
		return stBoolean$class.$fromJs$( this.js.toggleAttribute( name.js ) );
	}

	$toggleAttribute$force$( name, force )
	{
		return stBoolean$class.$fromJs$( this.js.toggleAttribute( name.js, force.js ) );
	}

}

export class StAttr extends StNode
{
	$class()
	{
		return stAttr$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$localName()
	{
		return stString$class.$fromJs$( this.js.localName );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$ownerElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.ownerElement );
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( aValue )
	{
		this.js.value = aValue.js;
		return this;
	}

}

export class StCharacterData extends StNode
{
	$class()
	{
		return stCharacterData$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$data()
	{
		return stString$class.$fromJs$( this.js.data );
	}

	$data$( data )
	{
		this.js.data = data.js;
		return this;
	}

	$length()
	{
		return stString$class.$fromJs$( this.js.length );
	}

	$nextElementSibling()
	{
		return stElement$class.$fromJsSubElement$( this.js.nextElementSibling );
	}

	$previousElementSibling()
	{
		return stElement$class.$fromJsSubElement$( this.js.previousElementSibling );
	}

	$before$( node )
	{
		this.js.before( node.js );
		return this;
	}

	$after$( node )
	{
		this.js.after( node.js );
		return this;
	}

	$replaceWith$( node )
	{
		this.js.replaceWith( node.js );
		return this;
	}

	$appendData$( string )
	{
		return stString$class.$fromJs$( this.js.appendData( string.js ) );
	}

	$deleteDataAt$count$( offset, count )
	{
		this.js.deleteData( offset.js - 1, count.js );
		return this;
	}

	$insertDataAt$with$( offset, string )
	{
		this.js.insertData( offset.js - 1, string.js );
		return this;
	}

	$remove()
	{
		this.js.remove();
		return this;
	}

	$replaceDataAt$count$with$( offset, count, string )
	{
		this.js.replaceData( offset.js - 1, count.js, string.js );
		return this;
	}

	$substringDataAt$count$( offset, count )
	{
		return stString$class.$fromJs$( this.js.substringData( offset.js - 1, count.js ) );
	}

}

export class StDedicatedWorkerGlobalScope extends StWorkerGlobalScope
{
	$class()
	{
		return stDedicatedWorkerGlobalScope$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$onMessage$( block )
	{
		this.js.onmessage = ( messageEvent ) => block.$value$( stMessageEvent$class.$fromJs$( messageEvent ) );
		return this;
	}

	$postMessage$( object )
	{
		this.js.postMessage( object.$toJs() );
		return this;
	}

}

export class StShadowRoot extends StDocumentFragment
{
	$class()
	{
		return stShadowRoot$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$activeElement()
	{
		return stHtmlElement$class.$fromJsSubElement$( this.js.activeElement );
	}

	$adoptedStyleSheets()
	{
		return stArray$class.$fromJs$elementClass$( this.js.adoptedStyleSheets, stCssStyleSheet$class );
	}

	$delegatesFocus()
	{
		return stBoolean$class.$fromJs$( this.js.delegatesFocus );
	}

	$fullscreenElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.fullscreenElement );
	}

	$host()
	{
		return stElement$class.$fromJsSubElement$( this.js.host );
	}

	$innerHtml()
	{
		return stString$class.$fromJs$( this.js.innerHTML );
	}

	$mode()
	{
		return stString$class.$fromJs$( this.js.mode );
	}

	$pointerLockElement()
	{
		return stElement$class.$fromJsSubElement$( this.js.pointerLockElement );
	}

	$styleSheets()
	{
		return stArray$class.$fromJs$elementClass$( this.js.styleSheets, stCssStyleSheet$class );
	}

	$getAnimations()
	{
		return stArray$class.$fromJs$elementClass$( this.js.getAnimations(), stAnimation$class );
	}

	$elementFromPoint$( point )
	{
		return stElement$class.$fromJsSubElement$( this.js.elementFromPoint( point.x.js, point.y.js ) );
	}

	$elementsFromPoint$( point )
	{
		return stElement$class.$fromJsSubElements$( this.js.elementsFromPoint( point.x.js, point.y.js ) );
	}

}

export class StHtmlElement extends StElement
{
	$class()
	{
		return stHtmlElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$accessKey()
	{
		return stString$class.$fromJs$( this.js.accessKey );
	}

	$accessKey$( accessKey )
	{
		this.js.accessKey = accessKey.js;
		return this;
	}

	$dir()
	{
		return stString$class.$fromJs$( this.js.dir );
	}

	$dir$( direction )
	{
		this.js.dir = direction.js;
		return this;
	}

	$enterKeyHint()
	{
		return stString$class.$fromJs$( this.js.enterKeyHint );
	}

	$enterKeyHint$( hint )
	{
		this.js.enterKeyHint = hint.js;
		return this;
	}

	$hidden()
	{
		return stBoolean$class.$fromJs$( this.js.hidden );
	}

	$hidden$( boolean )
	{
		this.js.hidden = boolean.js;
		return this;
	}

	$inert()
	{
		return stBoolean$class.$fromJs$( this.js.inert );
	}

	$inert$( boolean )
	{
		this.js.inert = boolean.js;
		return this;
	}

	$innerText()
	{
		return stString$class.$fromJs$( this.js.innerText );
	}

	$innerText$( string )
	{
		this.js.innerText = string.js;
		return this;
	}

	$outerText()
	{
		return stString$class.$fromJs$( this.js.outerText );
	}

	$outerText$( string )
	{
		this.js.outerText = string.js;
		return this;
	}

	$isContentEditable()
	{
		return stBoolean$class.$fromJs$( this.js.isContentEditable );
	}

	$lang()
	{
		return stString$class.$fromJs$( this.js.lang );
	}

	$lang$( string )
	{
		this.js.lang = string.js;
		return this;
	}

	$nonce()
	{
		return stString$class.$fromJs$( this.js.nonce );
	}

	$nonce$( string )
	{
		this.js.nonce = string.js;
		return this;
	}

	$offsetHeight()
	{
		return stInteger$class.$fromJs$( this.js.offsetHeight );
	}

	$offsetLeft()
	{
		return stInteger$class.$fromJs$( this.js.offsetLeft );
	}

	$offsetParent()
	{
		return stInteger$class.$fromJs$( this.js.offsetParent );
	}

	$offsetTop()
	{
		return stInteger$class.$fromJs$( this.js.offsetTop );
	}

	$offsetWidth()
	{
		return stInteger$class.$fromJs$( this.js.offsetWidth );
	}

	$style()
	{
		return stCssStyleDeclaration$class.$fromJs$( this.js.style );
	}

	$tabIndex()
	{
		return stString$class.$fromJs$( this.js.tabIndex );
	}

	$tabIndex$( tabIndex )
	{
		this.js.tabIndex = tabIndex.js;
		return this;
	}

	$title()
	{
		return stString$class.$fromJs$( this.js.title );
	}

	$title$( string )
	{
		this.js.title = string.js;
		return this;
	}

	$blur()
	{
		this.js.blur();
		return this;
	}

	$click()
	{
		this.js.click();
		return this;
	}

	$onClick$( block )
	{
		this.$addEventListener$then$( stString$class.$fromJs$( 'click' ), block );
		return this;
	}

	$focus()
	{
		this.js.focus();
		return this;
	}

	$forceFocus()
	{
		( () => { let $object$ = this;
			$object$.$tabIndex$( stInteger$class.$fromJs$( 0 ) );
			return $object$.$focus();
		} ) ();
		return this;
	}

}

export class StComment extends StCharacterData
{
	$class()
	{
		return stComment$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StText extends StCharacterData
{
	$class()
	{
		return stText$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$assignedSlot()
	{
		return stHtmlSlotElement$class.$fromJs$( this.js.assignedSlot );
	}

	$wholeText()
	{
		return stString$class.$fromJs$( this.js.wholeText );
	}

	$splitText$( offset )
	{
		return stText$class.$fromJs$( this.js.splitText( offset.js - 1 ) );
	}

}

export class StHtmlCanvasElement extends StHtmlElement
{
	$class()
	{
		return stHtmlCanvasElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$height$( height )
	{
		return this.js.height = height.js;
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$width$( width )
	{
		return this.js.width = width.js;
	}

	$size()
	{
		return this.$width().$$commat( this.$height() );
	}

	$size$( size )
	{
		this.$width$( size.$x() );
		this.$height$( size.$y() );
		return this;
	}

	$getContext$( type )
	{
		let context = stNil;
		try {
		context = stJsObject$class.$fromJs$( this.js.getContext( type.js ) );
		type = type.$toLowerCase();
		type.$$equeals( stString$class.$fromJs$( '2d' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stCanvasRenderingContext2d$class.$fromJs$( context.$js() ) );
			} ) );
		this.$error$( stBlock$class.$fromJs$( (  ) => {
				return stString$class.$fromJs$( 'Unsupported or invalid canvas context' ).$$comma( context.$jsClassName() );
			} ) );
		return this;
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$getContext2d()
	{
		return stCanvasRenderingContext2d$class.$fromJs$( this.js.getContext( "2d" ) );
	}

	$toBlobType$quality$then$( type, quality, block )
	{
		stBlob$class;
		this.js.toBlob( ( blob ) => block.$value$( stBlob$class.$fromJs$( blob ) ), type.js, quality.js );
		return this;
	}

	$toDataUrlType$quality$( type, quality )
	{
		return stString$class.$fromJs$( this.js.toDataURL( type.js, quality.js ) );
	}

	$transferControlToOffscreen()
	{
		return stOffscreenCanvas$class.$fromJs$( this.js.transferControlToOffscreen() );
	}

}

export class StHtmlAnchorElement extends StHtmlElement
{
	$class()
	{
		return stHtmlAnchorElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$download()
	{
		return stString$class.$fromJs$( this.js.download );
	}

	$download$( download )
	{
		return this.js.download = download.js;
	}

	$host()
	{
		return stString$class.$fromJs$( this.js.host );
	}

	$host$( host )
	{
		return this.js.host = host.js;
	}

	$hostname()
	{
		return stString$class.$fromJs$( this.js.hostname );
	}

	$hostname$( hostname )
	{
		return this.js.hostname = hostname.js;
	}

	$href()
	{
		return stString$class.$fromJs$( this.js.href );
	}

	$href$( href )
	{
		return this.js.href = href.js;
	}

	$hreflang()
	{
		return stString$class.$fromJs$( this.js.hreflang );
	}

	$hreflang$( hreflang )
	{
		return this.js.hreflang = hreflang.js;
	}

	$origin()
	{
		return stString$class.$fromJs$( this.js.origin );
	}

	$password()
	{
		return stString$class.$fromJs$( this.js.password );
	}

	$password$( password )
	{
		return this.js.password = password.js;
	}

	$pathname()
	{
		return stString$class.$fromJs$( this.js.pathname );
	}

	$pathname$( pathname )
	{
		return this.js.pathname = pathname.js;
	}

	$port()
	{
		return stString$class.$fromJs$( this.js.port );
	}

	$port$( port )
	{
		return this.js.port = port.js;
	}

	$protocol()
	{
		return stString$class.$fromJs$( this.js.protocol );
	}

	$protocol$( protocol )
	{
		return this.js.protocol = protocol.js;
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$referrerPolicy$( referrerPolicy )
	{
		return this.js.referrerPolicy = referrerPolicy.js;
	}

	$rel()
	{
		return stString$class.$fromJs$( this.js.rel );
	}

	$rel$( rel )
	{
		return this.js.rel = rel.js;
	}

	$relList()
	{
		return stDomTokenList$class.$fromJs$( this.js.relList );
	}

	$search()
	{
		return stString$class.$fromJs$( this.js.search );
	}

	$search$( search )
	{
		return this.js.search = search.js;
	}

	$target()
	{
		return stString$class.$fromJs$( this.js.target );
	}

	$target$( target )
	{
		return this.js.target = target.js;
	}

	$text()
	{
		return stString$class.$fromJs$( this.js.text );
	}

	$text$( text )
	{
		return this.js.text = text.js;
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		return this.js.type = type.js;
	}

	$username()
	{
		return stString$class.$fromJs$( this.js.username );
	}

	$username$( username )
	{
		return this.js.username = username.js;
	}

	$toString()
	{
		return stString$class.$fromJs$( this.js.toString() );
	}

}

export class StHtmlBodyElement extends StHtmlElement
{
	$class()
	{
		return stHtmlBodyElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlBrElement extends StHtmlElement
{
	$class()
	{
		return stHtmlBrElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlButtonElement extends StHtmlElement
{
	$class()
	{
		return stHtmlButtonElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$autofocus()
	{
		return stBoolean$class.$fromJs$( this.js.autofocus );
	}

	$autofocus$( autofocus )
	{
		this.js.autofocus = autofocus.js;
		return this;
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$form()
	{
		return stHtmlFormElement$class.$fromJs$( this.js.form );
	}

	$formAction()
	{
		return stString$class.$fromJs$( this.js.formAction );
	}

	$formAction$( formAction )
	{
		this.js.formAction = formAction.js;
		return this;
	}

	$formEnctype()
	{
		return stString$class.$fromJs$( this.js.formEnctype );
	}

	$formEnctype$( formEnctype )
	{
		this.js.formEnctype = formEnctype.js;
		return this;
	}

	$formMethod()
	{
		return stString$class.$fromJs$( this.js.formMethod );
	}

	$formMethod$( formMethod )
	{
		this.js.formMethod = formMethod.js;
		return this;
	}

	$formNoValidate()
	{
		return stBoolean$class.$fromJs$( this.js.formNoValidate );
	}

	$formNoValidate$( formNoValidate )
	{
		this.js.formNoValidate = formNoValidate.js;
		return this;
	}

	$formTarget()
	{
		return stString$class.$fromJs$( this.js.formTarget );
	}

	$formTarget$( formTarget )
	{
		this.js.formTarget = formTarget.js;
		return this;
	}

	$labels()
	{
		return stArray$class.$fromJs$elementClass$(  this.js.labels, stHtmlLabelElement$class );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		this.js.type = type.js;
		return this;
	}

	$willValidate()
	{
		return stBoolean$class.$fromJs$( this.js.willValidate );
	}

	$validationMessage()
	{
		return stString$class.$fromJs$( this.js.validationMessage );
	}

	$valid()
	{
		return stBoolean$class.$fromJs$( this.js.validity.valid );
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( value )
	{
		this.js.value = value.js;
		return this;
	}

}

export class StHtmlDataListElement extends StHtmlElement
{
	$class()
	{
		return stHtmlDataListElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$options()
	{
		return stArray$class.$fromJs$elementClass$( this.js.options, stHtmlOptionElement$class );
	}

	$indexOf$( value )
	{
		let index = stNil;
		try {
		index = stInteger$class.$fromJs$( 0 );
		this.$options().$do$( stBlock$class.$fromJs$( ( option ) => {
				option.$value().$$equeals( value ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( index );
			} ) );
				return index.$increment();
			} ) );
		return stInteger$class.$fromJs$( -1 );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StHtmlDivElement extends StHtmlElement
{
	$class()
	{
		return stHtmlDivElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlEmbedElement extends StHtmlElement
{
	$class()
	{
		return stHtmlEmbedElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$size()
	{
		return this.$width().$$commat( this.$height() );
	}

	$src()
	{
		return stString$class.$fromJs$( this.js.src );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

}

export class StHtmlFieldSetElement extends StHtmlElement
{
	$class()
	{
		return stHtmlFieldSetElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$elements()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.elements, stBlock$class.$fromJs$( ( element ) => {
				return stElement$class.$fromJsSubElement$( element );
			} ) );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$validationMessage()
	{
		return stString$class.$fromJs$( this.js.validationMessage );
	}

	$validity()
	{
		return stValidityState$class.$fromJs$( this.js.validity );
	}

	$willValidate()
	{
		return stBoolean$class.$fromJs$( this.js.willValidate );
	}

	$checkValidity()
	{
		return stBoolean$class.$fromJs$( this.js.checkValidity() );
	}

	$reportValidity()
	{
		return stBoolean$class.$fromJs$( this.js.reportValidity() );
	}

	$setCustomValidity$( customValidityMessage )
	{
		this.js.setCustomValidity( customValidityMessage.js );
		return this;
	}

}

export class StHtmlFormElement extends StHtmlElement
{
	$class()
	{
		return stHtmlFormElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$elements()
	{
		return stArray$class.$fromJs$elementConverter$( this.js.elements, stBlock$class.$fromJs$( ( jsHtmlElement ) => {
				return stHtmlElement$class.$fromJsSubElement$( jsHtmlElement );
			} ) );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$length()
	{
		return stInteger$class.$fromJs$( this.js.length );
	}

	$method()
	{
		return stString$class.$fromJs$( this.js.method );
	}

	$method$( method )
	{
		this.js.method = method.js;
		return this;
	}

	$target()
	{
		return stString$class.$fromJs$( this.js.target );
	}

	$target$( target )
	{
		this.js.target = target.js;
		return this;
	}

	$action()
	{
		return stString$class.$fromJs$( this.js.action );
	}

	$action$( action )
	{
		this.js.action = action.js;
		return this;
	}

	$enctype()
	{
		return stString$class.$fromJs$( this.js.enctype );
	}

	$enctype$( enctype )
	{
		this.js.enctype = enctype.js;
		return this;
	}

	$acceptCharset()
	{
		return stString$class.$fromJs$( this.js.acceptCharset );
	}

	$acceptCharset$( acceptCharset )
	{
		this.js.acceptCharset = acceptCharset.js;
		return this;
	}

	$autocomplete()
	{
		return stString$class.$fromJs$( this.js.autocomplete );
	}

	$autocomplete$( autocomplete )
	{
		this.js.autocomplete = autocomplete.js;
		return this;
	}

	$noValidate()
	{
		return stBoolean$class.$fromJs$( this.js.noValidate );
	}

	$noValidate$( noValidate )
	{
		this.js.noValidate = noValidate.js;
		return this;
	}

}

export class StHtmlHeadElement extends StHtmlElement
{
	$class()
	{
		return stHtmlHeadElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlHtmlElement extends StHtmlElement
{
	$class()
	{
		return stHtmlHtmlElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlIframeElement extends StHtmlElement
{
	$class()
	{
		return stHtmlIframeElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$size()
	{
		return this.$width().$$commat( this.$height() );
	}

	$allow()
	{
		return stString$class.$fromJs$( this.js.allow );
	}

	$allow$( allow )
	{
		this.js.allow = allow.js;
		return this;
	}

	$contentDocument()
	{
		return stDocument$class.$fromJs$( this.js.contentDocument );
	}

	$contentWindow()
	{
		return stWindow$class.$fromJs$( this.js.contentWindow );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$referrerPolicy$( referrerPolicy )
	{
		this.js.referrerPolicy = referrerPolicy.js;
		return this;
	}

	$sandbox()
	{
		return stDomTokenList$class.$fromJs$( this.js.sandbox );
	}

	$sandbox$( sandbox )
	{
		this.js.sandbox = sandbox.js;
		return this;
	}

	$src()
	{
		return stString$class.$fromJs$( this.js.src );
	}

	$src$( src )
	{
		this.js.src = src.js;
		return this;
	}

	$srcDoc()
	{
		return stString$class.$fromJs$( this.js.srcdoc );
	}

	$srcDoc$( srcDoc )
	{
		this.js.srcdoc = srcDoc.js;
		return this;
	}

}

export class StHtmlImageElement extends StHtmlElement
{
	$class()
	{
		return stHtmlImageElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$imageWidth$height$( width, height )
	{
		return stHtmlImageElement$class.$fromJs$( HtmlImageElement.Image( width, height ) );
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$width$( width )
	{
		this.js.width  = width.js;
		return this;
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$height$( height )
	{
		this.js.height  = height.js;
		return this;
	}

	$size()
	{
		return this.$width().$$commat( this.$height() );
	}

	$size$( size )
	{
		( () => { let $object$ = this;
			$object$.$width$( size.$x() );
			return $object$.$height$( size.$y() );
		} ) ();
		return this;
	}

	$sizes()
	{
		return stString$class.$fromJs$( this.js.sizes );
	}

	$naturalWidth()
	{
		return stInteger$class.$fromJs$( this.js.naturalWidth );
	}

	$naturalHeight()
	{
		return stInteger$class.$fromJs$( this.js.naturalHeight );
	}

	$naturalSize()
	{
		return this.$naturalWidth().$$commat( this.$naturalHeight() );
	}

	$x()
	{
		return stInteger$class.$fromJs$( this.js.x );
	}

	$x$( x )
	{
		this.js.x = x.js;
		return this;
	}

	$y()
	{
		return stInteger$class.$fromJs$( this.js.y );
	}

	$y$( y )
	{
		this.js.y = y.js;
		return this;
	}

	$position()
	{
		this.$x().$$commat( this.$y() );
		return this;
	}

	$position$( point )
	{
		this.$x$y$( point.$x(), point.$y() );
		return this;
	}

	$alt()
	{
		return stString$class.$fromJs$( this.js.alt );
	}

	$alt$( alt )
	{
		this.js.alt = alt.js;
		return this;
	}

	$complete()
	{
		return stBoolean$class.$fromJs$( this.js.complete );
	}

	$crossOrigin()
	{
		return stString$class.$fromJs$( this.js.crossOrigin );
	}

	$crossOrigin$( crossOrigin )
	{
		this.js.crossOrigin  = crossOrigin.js;
		return this;
	}

	$currentSrc()
	{
		return stString$class.$fromJs$( this.js.currentSrc );
	}

	$decoding()
	{
		return stString$class.$fromJs$( this.js.decoding );
	}

	$decoding$( decoding )
	{
		this.js.decoding  = decoding.js;
		return this;
	}

	$isMap()
	{
		return stBoolean$class.$fromJs$( this.js.isMap );
	}

	$isMap$( isMap )
	{
		this.js.isMap  = isMap.js;
		return this;
	}

	$loading()
	{
		return stString$class.$fromJs$( this.js.loading );
	}

	$loading$( loading )
	{
		this.js.loading  = loading.js;
		return this;
	}

	$src()
	{
		return stString$class.$fromJs$( this.js.src );
	}

	$src$( src )
	{
		this.js.src  = src.js;
		return this;
	}

	$srcSet()
	{
		return stString$class.$fromJs$( this.js.srcset );
	}

	$srcSet$( srcSet )
	{
		this.js.srcset = srcSet.js;
		return this;
	}

	$useMap()
	{
		return stString$class.$fromJs$( this.js.useMap );
	}

	$useMap$( useMap )
	{
		this.js.useMap  = useMap.js;
		return this;
	}

	$decodeThen$catch$( thenBlock, catchBlock )
	{
		stError$class;
		this.js.decode()
		.then( () => { thenBlock.js() } )
		.catch( ( error ) => { catchBlock.js( stError$class.$fromJs$( error ) ) } );
		return this;
	}

}

export class StHtmlInputElement extends StHtmlElement
{
	$class()
	{
		return stHtmlInputElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$form()
	{
		return stHtmlFormElement$class.$fromJs$( this.js.form );
	}

	$formAction()
	{
		return stString$class.$fromJs$( this.js.formAction );
	}

	$formAction$( formAction )
	{
		this.js.formAction = formAction.js;
		return this;
	}

	$formEnctype()
	{
		return stString$class.$fromJs$( this.js.formEnctype );
	}

	$formEncType$( formEnctype )
	{
		this.js.formEnctype = formEnctype.js;
		return this;
	}

	$formMethod()
	{
		return stString$class.$fromJs$( this.js.formMethod );
	}

	$formMethod$( formMethod )
	{
		this.js.formMethod = formMethod.js;
		return this;
	}

	$formNoValidate()
	{
		return stBoolean$class.$fromJs$( this.js.formNoValidate );
	}

	$formNoValidate$( formNoValidate )
	{
		this.js.formNoValidate = formNoValidate.js;
		return this;
	}

	$formTarget()
	{
		return stString$class.$fromJs$( this.js.formTarget );
	}

	$formTarget$( formTarget )
	{
		this.js.formtarget = formTarget.js;
		return this;
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		this.js.type = type.js;
		return this;
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$autofocus()
	{
		return stBoolean$class.$fromJs$( this.js.autofocus );
	}

	$autofocus$( autofocus )
	{
		this.js.autofocus = autofocus.js;
		return this;
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( value )
	{
		this.js.value = value.js;
		return this;
	}

	$valueAsDate()
	{
		return stDate$class.$fromJs$( this.js.valueAsDate );
	}

	$valueAsNumber()
	{
		return stInteger$class.$fromJs$( this.js.valueAsNumber );
	}

	$validity()
	{
		return stBoolean$class.$fromJs$( this.js.validity );
	}

	$validationMessage()
	{
		return stString$class.$fromJs$( this.js.validationMessage );
	}

	$willValidate()
	{
		return stBoolean$class.$fromJs$( this.js.willValidate );
	}

	$checkValidity()
	{
		return stBoolean$class.$fromJs$( this.js.checkValidity() );
	}

	$reportValidity()
	{
		return stBoolean$class.$fromJs$( this.js.reportValidity() );
	}

	$setCustomValidity$( message )
	{
		this.js.setCustomValidity( message.js );
		return this;
	}

	$checked()
	{
		return stBoolean$class.$fromJs$( this.js.checked );
	}

	$checked$( checked )
	{
		this.js.checked = checked.js;
		return this;
	}

	$defaultChecked()
	{
		return stBoolean$class.$fromJs$( this.js.defaultChecked );
	}

	$defaultChecked$( defaultChecked )
	{
		this.js.defaultChecked = defaultChecked.js;
		return this;
	}

	$indeterminate()
	{
		return stBoolean$class.$fromJs$( this.js.indeterminate );
	}

	$alt()
	{
		return stString$class.$fromJs$( this.js.alt );
	}

	$alt$( alt )
	{
		this.js.alt = alt.js;
		return this;
	}

	$width()
	{
		return stInteger$class.$fromJs$( this.js.width );
	}

	$width$( width )
	{
		this.js.width = width.js;
		return this;
	}

	$height()
	{
		return stInteger$class.$fromJs$( this.js.height );
	}

	$height$( height )
	{
		this.js.height = height.js;
		return this;
	}

	$imageSize()
	{
		return this.$width().$$commat( this.$height() );
	}

	$imageSize$( imageSize )
	{
		this.$width$( imageSize.$x() );
		this.$height$( imageSize.$y() );
		return this;
	}

	$src()
	{
		return stString$class.$fromJs$( this.js.src );
	}

	$src$( src )
	{
		this.js.src  = src.js;
		return this;
	}

	$accept()
	{
		return stString$class.$fromJs$( this.js.accept );
	}

	$accept$( accept )
	{
		this.js.accept = accept.js;
		return this;
	}

	$files()
	{
		return stArray$class.$fromJs$elementClass$( Array.from( this.js.files ), stFile$class );
	}

	$autocomplete()
	{
		return stString$class.$fromJs$( this.js.autocomplete );
	}

	$autocomplete$( autocomplete )
	{
		this.js.autocomplete = autocomplete.js;
		return this;
	}

	$min()
	{
		return stString$class.$fromJs$( this.js.min );
	}

	$min$( min )
	{
		this.js.min = min.js;
		return this;
	}

	$max()
	{
		return stString$class.$fromJs$( this.js.max );
	}

	$max$( max )
	{
		this.js.max = max.js;
		return this;
	}

	$minLength()
	{
		return stInteger$class.$fromJs$( this.js.minLength );
	}

	$minLength$( minLength )
	{
		this.js.minLength = minLength.js;
		return this;
	}

	$maxLength()
	{
		return stInteger$class.$fromJs$( this.js.maxLength );
	}

	$maxLength$( maxLength )
	{
		this.js.maxLength = maxLength.js;
		return this;
	}

	$pattern()
	{
		return stString$class.$fromJs$( this.js.pattern );
	}

	$pattern$( pattern )
	{
		this.js.pattern = pattern.js;
		return this;
	}

	$placeholder()
	{
		return stString$class.$fromJs$( this.js.placeholder );
	}

	$placeholder$( placeholder )
	{
		this.js.placeholder = placeholder.js;
		return this;
	}

	$readOnly()
	{
		return stBoolean$class.$fromJs$( this.js.readOnly );
	}

	$readOnly$( readOnly )
	{
		this.js.readOnly = readOnly.js;
		return this;
	}

	$size()
	{
		return stInteger$class.$fromJs$( this.js.size );
	}

	$size$( size )
	{
		this.js.size = size.js;
		return this;
	}

	$stepUp$( increment )
	{
		this.js.stepUp( increment.js );
		return this;
	}

	$stepDown$( decrement )
	{
		this.js.stepDown( decrement.js );
		return this;
	}

	$setRangeText$start$end$selectMode$( text, start, end, selectMode )
	{
		this.js.setRangeText( text.js, start.js, end.js, selectMode.js );
		return this;
	}

	$showPicker()
	{
		this.js.showPicker();
		return this;
	}

	$selectionStart()
	{
		return stInteger$class.$fromJs$( this.js.selectionStart );
	}

	$selectionStart$( selectionStart )
	{
		this.js.selectionStart = selectionStart.js;
		return this;
	}

	$selectionEnd()
	{
		return stInteger$class.$fromJs$( this.js.selectionEnd );
	}

	$selectionEnd$( selectionEnd )
	{
		this.js.selectionEnd = selectionEnd.js;
		return this;
	}

	$selectionDirection()
	{
		return stString$class.$fromJs$( this.js.selectionDirection );
	}

	$selectionDirection$( selectionDirection )
	{
		this.js.selectionDirection = selectionDirection.js;
		return this;
	}

	$select()
	{
		this.js.select();
		return this;
	}

	$setSelectionRange$to$( start, end )
	{
		this.js.setSelectionRange( start.js, end.js );
		return this;
	}

	$defaultValue()
	{
		return stString$class.$fromJs$( this.js.defaultValue );
	}

	$defaultValue$( defaultValue )
	{
		this.js.defaultValue = defaultValue.js;
		return this;
	}

	$dirName()
	{
		return stString$class.$fromJs$( this.js.dirName );
	}

	$dirName$( dirName )
	{
		this.js.dirName = dirName.js;
		return this;
	}

	$accessKey()
	{
		return stString$class.$fromJs$( this.js.accessKey );
	}

	$accessKey$( accessKey )
	{
		this.js.accessKey = accessKey.js;
		return this;
	}

	$multiple()
	{
		return stBoolean$class.$fromJs$( this.js.multiple );
	}

	$multiple$( multiple )
	{
		this.js.multiple = multiple.js;
		return this;
	}

	$labels()
	{
		return stArray$class.$fromJs$toClass$( this.js.labels, stHtmlLabelElement$class );
	}

}

export class StHtmlLabelElement extends StHtmlElement
{
	$class()
	{
		return stHtmlLabelElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$control()
	{
		return stHtmlElement$class.$fromJsSubElement$( this.js.control );
	}

	$form()
	{
		return stHtmlFormElement$class.$fromJs$( this.js.htmlForm );
	}

	$htmlFor()
	{
		return stString$class.$fromJs$( this.js.htmlFor );
	}

	$htmlFor$( htmlFor )
	{
		this.js.htmlFor = htmlFor.js;
		return this;
	}

}

export class StHtmlLinkElement extends StHtmlElement
{
	$class()
	{
		return stHtmlLinkElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$as()
	{
		return stString$class.$fromJs$( this.js.as );
	}

	$as$( as )
	{
		this.js.as = as.js;
		return this;
	}

	$crossOrigin()
	{
		return stString$class.$fromJs$( this.js.crossOrigin );
	}

	$crossOrigin$( crossOrigin )
	{
		this.js.crossOrigin = crossOrigin.js;
		return this;
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$href()
	{
		return stString$class.$fromJs$( this.js.href );
	}

	$href$( href )
	{
		this.js.href = href.js;
		return this;
	}

	$hreflang()
	{
		return stString$class.$fromJs$( this.js.hreflang );
	}

	$hreflang$( hreflang )
	{
		this.js.hreflang = hreflang.js;
		return this;
	}

	$media()
	{
		return stString$class.$fromJs$( this.js.media );
	}

	$media$( media )
	{
		this.js.media = media.js;
		return this;
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$referrerPolicy$( referrerPolicy )
	{
		this.js.referrerPolicy = referrerPolicy.js;
		return this;
	}

	$rel()
	{
		return stString$class.$fromJs$( this.js.rel );
	}

	$rel$( rel )
	{
		this.js.rel = rel.js;
		return this;
	}

	$relList()
	{
		return stDomTokenList$class.$fromJs$( this.js.relList );
	}

	$sizes()
	{
		return stDomTokenList$class.$fromJs$( this.js.sizes );
	}

	$sheet()
	{
		return stCssStyleSheet$class.$fromJs$( this.js.sheet );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		this.js.type = type.js;
		return this;
	}

}

export class StHtmlMetaElement extends StHtmlElement
{
	$class()
	{
		return stHtmlMetaElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$charset()
	{
		return stString$class.$fromJs$( this.js.charset );
	}

	$charset$( charset )
	{
		this.js.charset = charset.js;
		return this;
	}

	$content()
	{
		return stString$class.$fromJs$( this.js.content );
	}

	$content$( content )
	{
		this.js.content = content.js;
		return this;
	}

	$httpEquiv()
	{
		return stString$class.$fromJs$( this.js.httpEquiv );
	}

	$httpEquiv$( httpEquiv )
	{
		this.js.httpEquiv = httpEquiv.js;
		return this;
	}

	$media()
	{
		return stString$class.$fromJs$( this.js.media );
	}

	$media$( media )
	{
		this.js.media = media.js;
		return this;
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

}

export class StHtmlOptionElement extends StHtmlElement
{
	$class()
	{
		return stHtmlOptionElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( value )
	{
		this.js.value = value.js;
		return this;
	}

	$defaultSelected()
	{
		return stBoolean$class.$fromJs$( this.js.defaultSelected );
	}

	$defaultSelected$( defaultSelected )
	{
		this.js.defaultSelected = defaultSelected.js;
		return this;
	}

	$selected()
	{
		return stBoolean$class.$fromJs$( this.js.selected );
	}

	$selected$( selected )
	{
		this.js.selected = selected.js;
		return this;
	}

}

export class StHtmlParagraphElement extends StHtmlElement
{
	$class()
	{
		return stHtmlParagraphElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlScriptElement extends StHtmlElement
{
	$class()
	{
		return stHtmlScriptElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$type()
	{
		return stString$class.$fromJs$( this.js.type );
	}

	$type$( type )
	{
		this.js.type = type.js;
		return this;
	}

	$src()
	{
		return stString$class.$fromJs$( this.js.src );
	}

	$src$( src )
	{
		this.js.src = src.js;
		return this;
	}

	$isAsync()
	{
		return stBoolean$class.$fromJs$( this.js.async );
	}

	$isAsync$( async )
	{
		this.js.async = async.js;
		return this;
	}

	$defer()
	{
		return stBoolean$class.$fromJs$( this.js.defer );
	}

	$defer$( defer )
	{
		this.js.defer = defer.js;
		return this;
	}

	$crossOrigin()
	{
		return stString$class.$fromJs$( this.js.crossOrigin );
	}

	$crossOrigin$( crossOrigin )
	{
		this.js.crossOrigin = crossOrigin.js;
		return this;
	}

	$text()
	{
		return stString$class.$fromJs$( this.js.text );
	}

	$text$( text )
	{
		this.js.text = text.js;
		return this;
	}

	$referrerPolicy()
	{
		return stString$class.$fromJs$( this.js.referrerPolicy );
	}

	$referrerPolicy$( referrerPolicy )
	{
		this.js.referrerPolicy = referrerPolicy.js;
		return this;
	}

}

export class StHtmlSlotElement extends StHtmlElement
{
	$class()
	{
		return stHtmlSlotElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$assign$( node )
	{
		this.js.assign( node.js );
		return this;
	}

	$assignedElements()
	{
		return this.$assignedElements$( stFalse );
	}

	$assignedElements$( flatten )
	{
		return stArray$class.$fromJs$elementConverter$( this.js.assignedElements( { flatten: flatten.js } ), stBlock$class.$fromJs$( ( jsElement ) => {
				return stElement$class.$fromJsSubElement$( jsElement );
			} ) );
	}

	$assignedNodes()
	{
		return this.$assignedNodes$( stFalse );
	}

	$assignedNodes$( flatten )
	{
		return stArray$class.$fromJs$elementConverter$( this.js.assignedNodes( { flatten: flatten.js } ), stBlock$class.$fromJs$( ( jsNode ) => {
				return stElement$class.$fromJsSubNode$( jsNode );
			} ) );
	}

}

export class StHtmlSpanElement extends StHtmlElement
{
	$class()
	{
		return stHtmlSpanElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlTemplateElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTemplateElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$content()
	{
		return stDocumentFragment$class.$fromJs$( this.js.content );
	}

}

export class StHtmlTextAreaElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTextAreaElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$accessKey()
	{
		return stString$class.$fromJs$( this.js.accessKey );
	}

	$accessKey$( accessKey )
	{
		this.js.accessKey = accessKey.js;
		return this;
	}

	$autocapitalize()
	{
		return stString$class.$fromJs$( this.js.autocapitalize );
	}

	$autocapitalize$( autocapitalize )
	{
		this.js.autocapitalize = autocapitalize.js;
		return this;
	}

	$autofocus()
	{
		return stBoolean$class.$fromJs$( this.js.autofocus );
	}

	$autofocus$( autofocus )
	{
		this.js.autofocus = autofocus.js;
		return this;
	}

	$cols()
	{
		return stInteger$class.$fromJs$( this.js.cols );
	}

	$cols$( cols )
	{
		this.js.cols = cols.js;
		return this;
	}

	$defaultValue()
	{
		return stString$class.$fromJs$( this.js.defaultValue );
	}

	$defaultValue$( defaultValue )
	{
		this.js.defaultValue = defaultValue.js;
		return this;
	}

	$disabled()
	{
		return stBoolean$class.$fromJs$( this.js.disabled );
	}

	$disabled$( disabled )
	{
		this.js.disabled = disabled.js;
		return this;
	}

	$form()
	{
		return stHtmlFormElement$class.$fromJs$( this.js.form );
	}

	$maxLength()
	{
		return stInteger$class.$fromJs$( this.js.maxLength );
	}

	$maxLength$( maxLength )
	{
		this.js.maxLength = maxLength.js;
		return this;
	}

	$minLength()
	{
		return stInteger$class.$fromJs$( this.js.minLength );
	}

	$minLength$( minLength )
	{
		this.js.minLength = minLength.js;
		return this;
	}

	$name()
	{
		return stString$class.$fromJs$( this.js.name );
	}

	$name$( name )
	{
		this.js.name = name.js;
		return this;
	}

	$placeholder()
	{
		return stString$class.$fromJs$( this.js.placeholder );
	}

	$placeholder$( placeholder )
	{
		this.js.placeholder = placeholder.js;
		return this;
	}

	$readOnly()
	{
		return stBoolean$class.$fromJs$( this.js.readOnly );
	}

	$readOnly$( readOnly )
	{
		this.js.readOnly = readOnly.js;
		return this;
	}

	$required()
	{
		return stBoolean$class.$fromJs$( this.js.required );
	}

	$required$( required )
	{
		this.js.required = required.js;
		return this;
	}

	$rows()
	{
		return stString$class.$fromJs$( this.js.rows );
	}

	$rows$( rows )
	{
		this.js.rows = rows.js;
		return this;
	}

	$textLength()
	{
		return stInteger$class.$fromJs$( this.js.textLength );
	}

	$value()
	{
		return stString$class.$fromJs$( this.js.value );
	}

	$value$( value )
	{
		this.js.value = value.js;
		return this;
	}

	$wrap()
	{
		return stString$class.$fromJs$( this.js.wrap );
	}

	$wrap$( wrap )
	{
		this.js.wrap = wrap.js;
		return this;
	}

	$labels()
	{
		return stArray$class.$fromJs$elementClass$( this.js.labels, stHtmlLabelElement$class );
	}

	$selectionDirection()
	{
		return stString$class.$fromJs$( this.js.selectionDirection );
	}

	$selectionDirection$( selectionDirection )
	{
		this.js.selectionDirection = selectionDirection.js;
		return this;
	}

	$selectionStart()
	{
		return stInteger$class.$fromJs$( this.js.selectionStart );
	}

	$selectionStart$( selectionStart )
	{
		this.js.selectionStart = selectionStart.js;
		return this;
	}

	$selectionEnd()
	{
		return stInteger$class.$fromJs$( this.js.selectionEnd );
	}

	$selectionEnd$( selectionEnd )
	{
		this.js.selectionEnd = selectionEnd.js;
		return this;
	}

	$blur()
	{
		this.js.blur();
		return this;
	}

	$focus()
	{
		this.js.focus();
		return this;
	}

	$select()
	{
		this.js.select();
		return this;
	}

	$setRangeText$start$end$( text, start, end )
	{
		this.js.setRangeText( text.js, start.js, end.js );
		return this;
	}

	$setSelectionRange$to$( start, end )
	{
		this.js.setSelectionRange( start.js, end.js );
		return this;
	}

	$checkValidity()
	{
		return stBoolean$class.$fromJs$( this.js.checkValidity() );
	}

	$reportValidity()
	{
		return stBoolean$class.$fromJs$( this.js.reportValidity() );
	}

	$setCustomValidity$( validity )
	{
		this.js.setCustomValidity( validity.js );
		return this;
	}

	$validationMessage()
	{
		return stString$class.$fromJs$( this.js.validationMessage );
	}

	$validity()
	{
		return stValidityState$class.$fromJs$( this.js.validity );
	}

	$willValidate()
	{
		return stBoolean$class.$fromJs$( this.js.willValidate );
	}

}

export class StHtmlTitleElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTitleElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$text()
	{
		return stString$class.$fromJs$( this.js.text );
	}

	$text$( text )
	{
		this.js.text = text.js;
		return this;
	}

}

export class StHtmlUnknownElement extends StHtmlElement
{
	$class()
	{
		return stHtmlUnknownElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlTableCaptionElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTableCaptionElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

}

export class StHtmlTableCellElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTableCellElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$abbr()
	{
		return stString$class.$fromJs$( this.js.abbr );
	}

	$abbr$( abbr )
	{
		this.js.abbr = abbr.js;
		return this;
	}

	$cellIndex()
	{
		return stInteger$class.$fromJs$( this.js.cellIndex );
	}

	$headers()
	{
		return stString$class.$fromJs$( this.js.headers );
	}

	$headers$( headers )
	{
		this.js.headers = headers.js;
		return this;
	}

	$scope()
	{
		return stString$class.$fromJs$( this.js.scope );
	}

	$scope$( scope )
	{
		this.js.scope = scope.js;
		return this;
	}

	$rowSpan()
	{
		return stInteger$class.$fromJs$( this.js.rowSpan );
	}

	$rowSpan$( rowSpan )
	{
		this.js.rowSpan = rowSpan.js;
		return this;
	}

	$colSpan()
	{
		return stInteger$class.$fromJs$( this.js.colSpan );
	}

	$colSpan$( colSpan )
	{
		this.js.colSpan = colSpan.js;
		return this;
	}

}

export class StHtmlTableElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTableElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$caption()
	{
		return stString$class.$fromJs$( this.js.caption );
	}

	$createCaption()
	{
		return stHtmlTableCaptionElement$class.$fromJs$( this.js.createCaption() );
	}

	$deleteCaption()
	{
		this.js.deleteCaption();
		return this;
	}

	$tHead()
	{
		return stHtmlTableSectionElement$class.$fromJs$( this.js.tHead );
	}

	$createTHead()
	{
		return stHtmlTableSectionElement$class.$fromJs$( this.js.createTHead() );
	}

	$deleteTHead()
	{
		this.js.deleteTHead();
		return this;
	}

	$createTBody()
	{
		return stHtmlTableSectionElement$class.$fromJs$( this.js.createTBody() );
	}

	$tBodies()
	{
		return stArray$class.$fromJs$elementClass$( this.js.tBodies, stHtmlTableSectionElement$class );
	}

	$tBody()
	{
		return this.$tBodies().$first();
	}

	$rows()
	{
		return stArray$class.$fromJs$elementClass$( this.js.rows, stHtmlTableRowElement$class );
	}

	$insertRow()
	{
		return stHtmlTableRowElement$class.$fromJs$( this.js.insertRow() );
	}

	$insertRow$( index )
	{
		return stHtmlTableRowElement$class.$fromJs$( this.js.insertRow( index.js ) );
	}

	$deleteRow$( index )
	{
		this.js.deleteRow( index.js );
		return this;
	}

	$tFoot()
	{
		return stHtmlTableSectionElement$class.$fromJs$( this.js.tFoot );
	}

	$createTFoot()
	{
		return stHtmlTableSectionElement$class.$fromJs$( this.js.createTFoot() );
	}

	$deleteTFoot()
	{
		this.js.deleteTFoot();
		return this;
	}

}

export class StHtmlTableRowElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTableRowElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$cells()
	{
		return stArray$class.$fromJs$elementClass$( this.js.cells, stHtmlTableCellElement$class );
	}

	$rowIndex()
	{
		return stInteger$class.$fromJs$( this.js.rowIndex );
	}

	$sectionRowIndex()
	{
		return stInteger$class.$fromJs$( this.js.sectionRowIndex );
	}

	$insertCell()
	{
		return stHtmlTableCellElement$class.$fromJs$( this.js.insertCell() );
	}

	$insertCell$( index )
	{
		return stHtmlTableCellElement$class.$fromJs$( this.js.insertCell( index.js ) );
	}

	$deleteCell$( index )
	{
		this.js.deleteCell( index.js );
		return this;
	}

}

export class StHtmlTableSectionElement extends StHtmlElement
{
	$class()
	{
		return stHtmlTableSectionElement$class;
	}

	$moduleName()
	{
		return stString$class.$fromJs$( 'Browser' );
	}

	$rows()
	{
		return stArray$class.$fromJs$elementClass$( this.js.rows, stHtmlTableRowElement$class );
	}

	$deleteRow$( index )
	{
		this.js.deleteRow( index.js );
		return this;
	}

	$insertRow$( index )
	{
		return stHtmlTableRowElement$class.$fromJs$( this.js.insertRow( index.js ) );
	}

}

export class StBrowserApp$class extends StObject$class
{
	$basicNew()
	{
		return new StBrowserApp();
	}

	$jsClass()
	{
		return StBrowserApp.prototype;
	}

}

export class StComponent$class extends StObject$class
{
	$basicNew()
	{
		return new StComponent();
	}

	$jsClass()
	{
		return StComponent.prototype;
	}

	$loadIntoElement$then$( elementId, block )
	{
		return this.$new().$loadIntoElement$then$( elementId, block );
	}

	$appendToElement$then$( elementId, block )
	{
		return this.$new().$appendToElement$then$( elementId, block );
	}

}

export class StLanguage$class extends StObject$class
{
	$basicNew()
	{
		return new StLanguage();
	}

	$jsClass()
	{
		return StLanguage.prototype;
	}

	$supported$( aSupported )
	{
		return this.$new().$supported$( aSupported );
	}

}

export class StLanguageCode$class extends StObject$class
{
	$basicNew()
	{
		return new StLanguageCode();
	}

	$jsClass()
	{
		return StLanguageCode.prototype;
	}

	$fromCode$( code )
	{
		return this.$new().$fromCode$( code );
	}

}

export class StFetch$class extends StObject$class
{
	$basicNew()
	{
		return new StFetch();
	}

	$jsClass()
	{
		return StFetch.prototype;
	}

	$request$then$catch$( url, block, errorBlock )
	{
		this.$request$options$then$catch$( url, stRequestOptions$class.$new(), block, errorBlock );
		return this;
	}

	$request$options$then$catch$( url, options, block, errorBlock )
	{
		stResponse$class;
		
		fetch( url.js, options.js )
			.then( response => block.$value$( stResponse$class.$fromJs$( response ) ) )
			.catch( error => errorBlock.$value$( stError$class.$fromJs$( error ) ) );
		return this;
	}

	$object$then$catch$( url, block, errorBlock )
	{
		this.$object$options$then$catch$( url, stRequestOptions$class.$new(), block, errorBlock );
		return this;
	}

	$object$options$then$catch$( url, options, block, errorBlock )
	{
		this.$request$options$then$catch$( url, options, stBlock$class.$fromJs$( ( response ) => {
				return this.$onObject$then$catch$( response, block, errorBlock );
			} ), errorBlock );
		return this;
	}

	$onObject$then$catch$( response, block, errorBlock )
	{
		response.$status().$$equeals( stInteger$class.$fromJs$( 200 ) ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return response.$jsonThen$( stBlock$class.$fromJs$( ( object ) => {
				return block.$value$( object );
			} ) );
			} ), stBlock$class.$fromJs$( (  ) => {
				return errorBlock.$value$( stError$class.$new$( response.$statusAndText() ) );
			} ) );
		return this;
	}

	$text$then$catch$( url, block, errorBlock )
	{
		this.$text$options$then$catch$( url, stRequestOptions$class.$new(), block, errorBlock );
		return this;
	}

	$text$options$then$catch$( url, options, block, errorBlock )
	{
		this.$request$options$then$catch$( url, options, stBlock$class.$fromJs$( ( response ) => {
				return this.$onFile$then$catch$( response, block, errorBlock );
			} ), errorBlock );
		return this;
	}

	$onFile$then$catch$( response, block, errorBlock )
	{
		response.$status().$$equeals( stInteger$class.$fromJs$( 200 ) ).$ifTrue$ifFalse$( stBlock$class.$fromJs$( (  ) => {
				return response.$textThen$( stBlock$class.$fromJs$( ( string ) => {
				return block.$value$( string );
			} ) );
			} ), stBlock$class.$fromJs$( (  ) => {
				return errorBlock.$value$( stError$class.$new$( response.$statusAndText() ) );
			} ) );
		return this;
	}

}

export class StAbstractRange$class extends StJsObject$class
{
	$basicNew()
	{
		return new StAbstractRange();
	}

	$jsClass()
	{
		return StAbstractRange.prototype;
	}

}

export class StCustomElementRegistry$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCustomElementRegistry();
	}

	$jsClass()
	{
		return StCustomElementRegistry.prototype;
	}

}

export class StDomImplementation$class extends StJsObject$class
{
	$basicNew()
	{
		return new StDomImplementation();
	}

	$jsClass()
	{
		return StDomImplementation.prototype;
	}

}

export class StDomTokenList$class extends StJsObject$class
{
	$basicNew()
	{
		return new StDomTokenList();
	}

	$jsClass()
	{
		return StDomTokenList.prototype;
	}

	$new()
	{
		this.$error$( stString$class.$fromJs$( 'DomTokenList cannot be created with new.' ) );
		return this;
	}

}

export class StLocation$class extends StJsObject$class
{
	$basicNew()
	{
		return new StLocation();
	}

	$jsClass()
	{
		return StLocation.prototype;
	}

}

export class StNamedNodeMap$class extends StJsObject$class
{
	$basicNew()
	{
		return new StNamedNodeMap();
	}

	$jsClass()
	{
		return StNamedNodeMap.prototype;
	}

}

export class StSelection$class extends StJsObject$class
{
	$basicNew()
	{
		return new StSelection();
	}

	$jsClass()
	{
		return StSelection.prototype;
	}

	$new()
	{
		return stDocument$class.$default().$getSelection();
	}

}

export class StStorage$class extends StJsObject$class
{
	$basicNew()
	{
		return new StStorage();
	}

	$jsClass()
	{
		return StStorage.prototype;
	}

}

export class StValidityState$class extends StJsObject$class
{
	$basicNew()
	{
		return new StValidityState();
	}

	$jsClass()
	{
		return StValidityState.prototype;
	}

	$new()
	{
		return this.$fromJs$( new ValidityState() );
	}

}

export class StCanvasGradient$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCanvasGradient();
	}

	$jsClass()
	{
		return StCanvasGradient.prototype;
	}

}

export class StCanvasPattern$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCanvasPattern();
	}

	$jsClass()
	{
		return StCanvasPattern.prototype;
	}

}

export class StCanvasRenderingContext2d$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCanvasRenderingContext2d();
	}

	$jsClass()
	{
		return StCanvasRenderingContext2d.prototype;
	}

}

export class StContextAttributes$class extends StJsObject$class
{
	$basicNew()
	{
		return new StContextAttributes();
	}

	$jsClass()
	{
		return StContextAttributes.prototype;
	}

}

export class StDomMatrix$class extends StJsObject$class
{
	$basicNew()
	{
		return new StDomMatrix();
	}

	$jsClass()
	{
		return StDomMatrix.prototype;
	}

	$new()
	{
		return this.$fromJs$( new DOMMatrix() );
	}

	$init$( array )
	{
		return this.$fromJs$( new DOMMatrix( array.$toJs() ) );
	}

	$fromMatrix$( matrix )
	{
		return stDomMatrix$class.$fromJs$( DOMMatrix.fromMatrix( matrix.js ) );
	}

}

export class StDomPoint$class extends StJsObject$class
{
	$basicNew()
	{
		return new StDomPoint();
	}

	$jsClass()
	{
		return StDomPoint.prototype;
	}

	$x$y$( x, y )
	{
		return this.$fromJs$( new DOMPoint( x.js, y.js ) );
	}

	$x$y$z$( x, y, z )
	{
		return this.$fromJs$( new DOMPoint( x.js, y.js, z.js ) );
	}

	$x$y$z$w$( x, y, z, w )
	{
		return this.$fromJs$( new DOMPoint( x.js, y.js, z.js, w.js ) );
	}

	$fromPoint$( point )
	{
		return this.$x$y$( point.$x(), point.$y() );
	}

	$fromPoint3d$( point3d )
	{
		return this.$x$y$z$( point3d.$x(), point3d.$y(), point3d.$z() );
	}

	$fromDomPoint$( domPoint )
	{
		return stDomPoint$class.$fromJs$( DOMPoint.fromPoint( domPoint.js ) );
	}

}

export class StImageBitmap$class extends StJsObject$class
{
	$basicNew()
	{
		return new StImageBitmap();
	}

	$jsClass()
	{
		return StImageBitmap.prototype;
	}

	$create$then$( image, block )
	{
		this.$fromJs$( createImageBitmap( image.js )
		.then( ( imageBitmap ) => block.$value$( stImageBitmap$class.$fromJs$( imageBitmap ) ) ) );
		return this;
	}

}

export class StImageData$class extends StJsObject$class
{
	$basicNew()
	{
		return new StImageData();
	}

	$jsClass()
	{
		return StImageData.prototype;
	}

}

export class StOffscreenCanvas$class extends StJsObject$class
{
	$basicNew()
	{
		return new StOffscreenCanvas();
	}

	$jsClass()
	{
		return StOffscreenCanvas.prototype;
	}

}

export class StPath2d$class extends StJsObject$class
{
	$basicNew()
	{
		return new StPath2d();
	}

	$jsClass()
	{
		return StPath2d.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Path2D() );
	}

}

export class StTextMetrics$class extends StJsObject$class
{
	$basicNew()
	{
		return new StTextMetrics();
	}

	$jsClass()
	{
		return StTextMetrics.prototype;
	}

}

export class StCssStyleDeclaration$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCssStyleDeclaration();
	}

	$jsClass()
	{
		return StCssStyleDeclaration.prototype;
	}

}

export class StCssRule$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCssRule();
	}

	$jsClass()
	{
		return StCssRule.prototype;
	}

	$fromJsSubRule$( jsCssRule )
	{
		let jsClassName = stNil;
		try {
		if( jsCssRule == null ) return stNil;
		jsClassName = stString$class.$fromJs$( jsCssRule.constructor.name );
		jsClassName.$$equeals( stString$class.$fromJs$( 'CSSStyleRule' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stCssStyleRule$class.$fromJs$( jsCssRule ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'CSSImportRule' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stCssImportRule$class.$fromJs$( jsCssRule ) );
			} ) );
		return stCssRule$class.$fromJs$( jsCssRule );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StStyleSheet$class extends StJsObject$class
{
	$basicNew()
	{
		return new StStyleSheet();
	}

	$jsClass()
	{
		return StStyleSheet.prototype;
	}

}

export class StMediaList$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaList();
	}

	$jsClass()
	{
		return StMediaList.prototype;
	}

}

export class StMediaQueryList$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaQueryList();
	}

	$jsClass()
	{
		return StMediaQueryList.prototype;
	}

}

export class StMediaStream$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaStream();
	}

	$jsClass()
	{
		return StMediaStream.prototype;
	}

}

export class StClipboard$class extends StJsObject$class
{
	$basicNew()
	{
		return new StClipboard();
	}

	$jsClass()
	{
		return StClipboard.prototype;
	}

}

export class StCredentialsContainer$class extends StJsObject$class
{
	$basicNew()
	{
		return new StCredentialsContainer();
	}

	$jsClass()
	{
		return StCredentialsContainer.prototype;
	}

}

export class StGeolocation$class extends StJsObject$class
{
	$basicNew()
	{
		return new StGeolocation();
	}

	$jsClass()
	{
		return StGeolocation.prototype;
	}

}

export class StLockManager$class extends StJsObject$class
{
	$basicNew()
	{
		return new StLockManager();
	}

	$jsClass()
	{
		return StLockManager.prototype;
	}

}

export class StMediaCapabilities$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaCapabilities();
	}

	$jsClass()
	{
		return StMediaCapabilities.prototype;
	}

}

export class StMediaDevices$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaDevices();
	}

	$jsClass()
	{
		return StMediaDevices.prototype;
	}

}

export class StMediaSession$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMediaSession();
	}

	$jsClass()
	{
		return StMediaSession.prototype;
	}

}

export class StNavigator$class extends StJsObject$class
{
	$basicNew()
	{
		return new StNavigator();
	}

	$jsClass()
	{
		return StNavigator.prototype;
	}

}

export class StPermissions$class extends StJsObject$class
{
	$basicNew()
	{
		return new StPermissions();
	}

	$jsClass()
	{
		return StPermissions.prototype;
	}

}

export class StServiceWorkerContainer$class extends StJsObject$class
{
	$basicNew()
	{
		return new StServiceWorkerContainer();
	}

	$jsClass()
	{
		return StServiceWorkerContainer.prototype;
	}

}

export class StStorageManager$class extends StJsObject$class
{
	$basicNew()
	{
		return new StStorageManager();
	}

	$jsClass()
	{
		return StStorageManager.prototype;
	}

}

export class StHistory$class extends StJsObject$class
{
	$basicNew()
	{
		return new StHistory();
	}

	$jsClass()
	{
		return StHistory.prototype;
	}

}

export class StScreen$class extends StJsObject$class
{
	$basicNew()
	{
		return new StScreen();
	}

	$jsClass()
	{
		return StScreen.prototype;
	}

}

export class StMessageEvent$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMessageEvent();
	}

	$jsClass()
	{
		return StMessageEvent.prototype;
	}

	$new$( type )
	{
		return this.$fromJs$( new MessageEvent( type.js ) );
	}

	$new$options$( type, options )
	{
		return this.$fromJs$( new MessageEvent( type.js, options.js ) );
	}

}

export class StMessagePort$class extends StJsObject$class
{
	$basicNew()
	{
		return new StMessagePort();
	}

	$jsClass()
	{
		return StMessagePort.prototype;
	}

}

export class StWorker$class extends StJsObject$class
{
	$basicNew()
	{
		return new StWorker();
	}

	$jsClass()
	{
		return StWorker.prototype;
	}

	$new$( url )
	{
		return this.$fromJs$( new Worker( url.js ) );
	}

	$new$options$( url, options )
	{
		return this.$fromJs$( new Worker( url.js, options.js ) );
	}

}

export class StWorkerOptions$class extends StJsObject$class
{
	$basicNew()
	{
		return new StWorkerOptions();
	}

	$jsClass()
	{
		return StWorkerOptions.prototype;
	}

	$new()
	{
		return this.$newEmpty();
	}

}

export class StSpeechSynthesis$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StSpeechSynthesis();
	}

	$jsClass()
	{
		return StSpeechSynthesis.prototype;
	}

}

export class StNode$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StNode();
	}

	$jsClass()
	{
		return StNode.prototype;
	}

	$fromJsSubNode$( jsNode )
	{
		let jsClassName = stNil;
		try {
		if( jsNode == null ) return stNil;
		jsClassName = stString$class.$fromJs$( jsNode.constructor.name );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Text' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stText$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Attr' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stAttr$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'CharacterData' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stCharacterData$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Text' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stText$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Comment' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stComment$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'Document' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stDocument$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLDocument' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stDocument$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'DocumentFragment' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stDocumentFragment$class.$fromJs$( jsNode ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'DocumentType' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stDocumentType$class.$fromJs$( jsNode ) );
			} ) );
		return stElement$class.$fromJsSubElement$( jsNode );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

}

export class StAnimation$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StAnimation();
	}

	$jsClass()
	{
		return StAnimation.prototype;
	}

}

export class StScreenOrientation$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StScreenOrientation();
	}

	$jsClass()
	{
		return StScreenOrientation.prototype;
	}

}

export class StVisualViewport$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StVisualViewport();
	}

	$jsClass()
	{
		return StVisualViewport.prototype;
	}

}

export class StWindow$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StWindow();
	}

	$jsClass()
	{
		return StWindow.prototype;
	}

	$new()
	{
		return this.$default();
	}

	$default()
	{
		return this.$fromJs$( window );
	}

	$isFirefox()
	{
		return this.$default().$navigator().$userAgent().$includes$( stString$class.$fromJs$( 'Firefox' ) );
	}

	$isChromium()
	{
		return this.$default().$navigator().$userAgent().$includes$( stString$class.$fromJs$( 'Chrome' ) );
	}

	$isMac()
	{
		return this.$default().$navigator().$platform().$startsWith$( stString$class.$fromJs$( 'Mac' ) );
	}

	$isLinux()
	{
		return this.$default().$navigator().$platform().$startsWith$( stString$class.$fromJs$( 'Linux' ) );
	}

}

export class StWorkerGlobalScope$class extends StEventTarget$class
{
	$basicNew()
	{
		return new StWorkerGlobalScope();
	}

	$jsClass()
	{
		return StWorkerGlobalScope.prototype;
	}

	$default()
	{
		return this.$fromJs$( self );
	}

}

export class StRange$class extends StAbstractRange$class
{
	$basicNew()
	{
		return new StRange();
	}

	$jsClass()
	{
		return StRange.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Range() );
	}

}

export class StCssImportRule$class extends StCssRule$class
{
	$basicNew()
	{
		return new StCssImportRule();
	}

	$jsClass()
	{
		return StCssImportRule.prototype;
	}

}

export class StCssStyleRule$class extends StCssRule$class
{
	$basicNew()
	{
		return new StCssStyleRule();
	}

	$jsClass()
	{
		return StCssStyleRule.prototype;
	}

}

export class StCssStyleSheet$class extends StStyleSheet$class
{
	$basicNew()
	{
		return new StCssStyleSheet();
	}

	$jsClass()
	{
		return StCssStyleSheet.prototype;
	}

	$new()
	{
		return this.$fromJs$( new CSSStyleSheet() );
	}

}

export class StDocument$class extends StNode$class
{
	$basicNew()
	{
		return new StDocument();
	}

	$jsClass()
	{
		return StDocument.prototype;
	}

	$new()
	{
		return this.$fromJs$( document.implementation.createHTMLDocument() );
	}

	$default()
	{
		return this.$fromJs$( document );
	}

	$getElementById$( id )
	{
		return this.$default().$getElementById$( id );
	}

	$getElementById$class$( id, class$ )
	{
		return this.$default().$getElementById$class$( id, class$ );
	}

}

export class StDocumentFragment$class extends StNode$class
{
	$basicNew()
	{
		return new StDocumentFragment();
	}

	$jsClass()
	{
		return StDocumentFragment.prototype;
	}

	$new()
	{
		return this.$fromJs$( new DocumentFragment() );
	}

}

export class StDocumentType$class extends StNode$class
{
	$basicNew()
	{
		return new StDocumentType();
	}

	$jsClass()
	{
		return StDocumentType.prototype;
	}

}

export class StElement$class extends StNode$class
{
	$basicNew()
	{
		return new StElement();
	}

	$jsClass()
	{
		return StElement.prototype;
	}

	$new()
	{
		this.$error$( stString$class.$fromJs$( 'Element is an abstract class that cannot be instantiated. Use Document.createElement: .' ) );
		return this;
	}

	$fromJsSubElement$( jsElement )
	{
		let jsClassName = stNil;
		let localName = stNil;
		try {
		if( jsElement == null ) return stNil;
		jsClassName = stString$class.$fromJs$( jsElement.constructor.name );
		stWindow$class.$isFirefox().$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				localName = stJsObject$class.$fromJs$( jsElement ).$atJsProperty$( stString$class.$fromJs$( 'localName' ) );
				return localName.$$equeals( stString$class.$fromJs$( 'image' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				return jsClassName = stString$class.$fromJs$( 'HTMLImageElement' );
			} ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLAnchorElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlAnchorElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLButtonElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlButtonElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLFormElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlFormElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLInputElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlInputElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLLabelElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlLabelElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTextAreaElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTextAreaElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLSpanElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlSpanElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLBodyElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlBodyElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLHtmlElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlHtmlElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLParagraphElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlParagraphElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLImageElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlImageElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableCellElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableCellElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableRowElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableRowElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLDivElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlDivElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLScriptElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlScriptElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLSlotElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlSlotElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLFieldSetElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlFieldSetElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLMetaElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlMetaElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLLinkElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlLinkElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTitleElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTitleElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLBRElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlBrElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLEmbedElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlEmbedElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLIFrameElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlIframeElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLHeadElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlHeadElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLUnknownElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlUnknownElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTemplateElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTemplateElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableCaptionElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableCaptionElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableCellElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableCellElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableRowElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableRowElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLTableSectionElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlTableSectionElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLDataListElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlDataListElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLOptionElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlOptionElement$class.$fromJs$( jsElement ) );
			} ) );
		jsClassName.$$equeals( stString$class.$fromJs$( 'HTMLCanvasElement' ) ).$ifTrue$( stBlock$class.$fromJs$( (  ) => {
				throw new BlockReturn( stHtmlCanvasElement$class.$fromJs$( jsElement ) );
			} ) );
		return this.$error$( stString$class.$fromJs$( 'Element.fromJsSubElement: Unknown JS element class: ' ).$$comma( jsClassName ) );
		}
		catch( exception ) {
			if( exception.constructor === BlockReturn )
				return exception.value;
			throw exception;
		}
	}

	$fromJsSubElements$( jsArray )
	{
		return stArray$class.$fromJs$elementConverter$( jsArray, stBlock$class.$fromJs$( ( jsHtmlElement ) => {
				return stElement$class.$fromJsSubElement$( jsHtmlElement );
			} ) );
	}

}

export class StAttr$class extends StNode$class
{
	$basicNew()
	{
		return new StAttr();
	}

	$jsClass()
	{
		return StAttr.prototype;
	}

}

export class StCharacterData$class extends StNode$class
{
	$basicNew()
	{
		return new StCharacterData();
	}

	$jsClass()
	{
		return StCharacterData.prototype;
	}

}

export class StDedicatedWorkerGlobalScope$class extends StWorkerGlobalScope$class
{
	$basicNew()
	{
		return new StDedicatedWorkerGlobalScope();
	}

	$jsClass()
	{
		return StDedicatedWorkerGlobalScope.prototype;
	}

}

export class StShadowRoot$class extends StDocumentFragment$class
{
	$basicNew()
	{
		return new StShadowRoot();
	}

	$jsClass()
	{
		return StShadowRoot.prototype;
	}

}

export class StHtmlElement$class extends StElement$class
{
	$basicNew()
	{
		return new StHtmlElement();
	}

	$jsClass()
	{
		return StHtmlElement.prototype;
	}

}

export class StComment$class extends StCharacterData$class
{
	$basicNew()
	{
		return new StComment();
	}

	$jsClass()
	{
		return StComment.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Comment() );
	}

	$new$( string )
	{
		return this.$fromJs$( new Comment( string.js ) );
	}

}

export class StText$class extends StCharacterData$class
{
	$basicNew()
	{
		return new StText();
	}

	$jsClass()
	{
		return StText.prototype;
	}

	$new()
	{
		return this.$fromJs$( new Text() );
	}

	$new$( string )
	{
		return this.$fromJs$( new Text( string.js ) );
	}

}

export class StHtmlCanvasElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlCanvasElement();
	}

	$jsClass()
	{
		return StHtmlCanvasElement.prototype;
	}

}

export class StHtmlAnchorElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlAnchorElement();
	}

	$jsClass()
	{
		return StHtmlAnchorElement.prototype;
	}

}

export class StHtmlBodyElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlBodyElement();
	}

	$jsClass()
	{
		return StHtmlBodyElement.prototype;
	}

}

export class StHtmlBrElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlBrElement();
	}

	$jsClass()
	{
		return StHtmlBrElement.prototype;
	}

}

export class StHtmlButtonElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlButtonElement();
	}

	$jsClass()
	{
		return StHtmlButtonElement.prototype;
	}

}

export class StHtmlDataListElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlDataListElement();
	}

	$jsClass()
	{
		return StHtmlDataListElement.prototype;
	}

}

export class StHtmlDivElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlDivElement();
	}

	$jsClass()
	{
		return StHtmlDivElement.prototype;
	}

}

export class StHtmlEmbedElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlEmbedElement();
	}

	$jsClass()
	{
		return StHtmlEmbedElement.prototype;
	}

}

export class StHtmlFieldSetElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlFieldSetElement();
	}

	$jsClass()
	{
		return StHtmlFieldSetElement.prototype;
	}

}

export class StHtmlFormElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlFormElement();
	}

	$jsClass()
	{
		return StHtmlFormElement.prototype;
	}

}

export class StHtmlHeadElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlHeadElement();
	}

	$jsClass()
	{
		return StHtmlHeadElement.prototype;
	}

}

export class StHtmlHtmlElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlHtmlElement();
	}

	$jsClass()
	{
		return StHtmlHtmlElement.prototype;
	}

}

export class StHtmlIframeElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlIframeElement();
	}

	$jsClass()
	{
		return StHtmlIframeElement.prototype;
	}

}

export class StHtmlImageElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlImageElement();
	}

	$jsClass()
	{
		return StHtmlImageElement.prototype;
	}

}

export class StHtmlInputElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlInputElement();
	}

	$jsClass()
	{
		return StHtmlInputElement.prototype;
	}

}

export class StHtmlLabelElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlLabelElement();
	}

	$jsClass()
	{
		return StHtmlLabelElement.prototype;
	}

}

export class StHtmlLinkElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlLinkElement();
	}

	$jsClass()
	{
		return StHtmlLinkElement.prototype;
	}

}

export class StHtmlMetaElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlMetaElement();
	}

	$jsClass()
	{
		return StHtmlMetaElement.prototype;
	}

}

export class StHtmlOptionElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlOptionElement();
	}

	$jsClass()
	{
		return StHtmlOptionElement.prototype;
	}

}

export class StHtmlParagraphElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlParagraphElement();
	}

	$jsClass()
	{
		return StHtmlParagraphElement.prototype;
	}

}

export class StHtmlScriptElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlScriptElement();
	}

	$jsClass()
	{
		return StHtmlScriptElement.prototype;
	}

	$supports$( type )
	{
		return stBoolean$class.$fromJs$( HTMLScriptElement.supports( type.js ) );
	}

}

export class StHtmlSlotElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlSlotElement();
	}

	$jsClass()
	{
		return StHtmlSlotElement.prototype;
	}

}

export class StHtmlSpanElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlSpanElement();
	}

	$jsClass()
	{
		return StHtmlSpanElement.prototype;
	}

}

export class StHtmlTemplateElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTemplateElement();
	}

	$jsClass()
	{
		return StHtmlTemplateElement.prototype;
	}

}

export class StHtmlTextAreaElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTextAreaElement();
	}

	$jsClass()
	{
		return StHtmlTextAreaElement.prototype;
	}

}

export class StHtmlTitleElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTitleElement();
	}

	$jsClass()
	{
		return StHtmlTitleElement.prototype;
	}

}

export class StHtmlUnknownElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlUnknownElement();
	}

	$jsClass()
	{
		return StHtmlUnknownElement.prototype;
	}

}

export class StHtmlTableCaptionElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTableCaptionElement();
	}

	$jsClass()
	{
		return StHtmlTableCaptionElement.prototype;
	}

}

export class StHtmlTableCellElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTableCellElement();
	}

	$jsClass()
	{
		return StHtmlTableCellElement.prototype;
	}

	$new()
	{
		return this.$fromJs$( new HTMLTableCellElement() );
	}

}

export class StHtmlTableElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTableElement();
	}

	$jsClass()
	{
		return StHtmlTableElement.prototype;
	}

	$new()
	{
		return this.$fromJs$( new HTMLTableElement() );
	}

}

export class StHtmlTableRowElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTableRowElement();
	}

	$jsClass()
	{
		return StHtmlTableRowElement.prototype;
	}

	$new()
	{
		return this.$fromJs$( new HTMLTableRowElement() );
	}

}

export class StHtmlTableSectionElement$class extends StHtmlElement$class
{
	$basicNew()
	{
		return new StHtmlTableSectionElement();
	}

	$jsClass()
	{
		return StHtmlTableSectionElement.prototype;
	}

}

export let stBrowserApp$class = new StBrowserApp$class();
export let stComponent$class = new StComponent$class();
export let stLanguage$class = new StLanguage$class();
export let stLanguageCode$class = new StLanguageCode$class();
export let stFetch$class = new StFetch$class();
export let stAbstractRange$class = new StAbstractRange$class();
export let stCustomElementRegistry$class = new StCustomElementRegistry$class();
export let stDomImplementation$class = new StDomImplementation$class();
export let stDomTokenList$class = new StDomTokenList$class();
export let stLocation$class = new StLocation$class();
export let stNamedNodeMap$class = new StNamedNodeMap$class();
export let stSelection$class = new StSelection$class();
export let stStorage$class = new StStorage$class();
export let stValidityState$class = new StValidityState$class();
export let stCanvasGradient$class = new StCanvasGradient$class();
export let stCanvasPattern$class = new StCanvasPattern$class();
export let stCanvasRenderingContext2d$class = new StCanvasRenderingContext2d$class();
export let stContextAttributes$class = new StContextAttributes$class();
export let stDomMatrix$class = new StDomMatrix$class();
export let stDomPoint$class = new StDomPoint$class();
export let stImageBitmap$class = new StImageBitmap$class();
export let stImageData$class = new StImageData$class();
export let stOffscreenCanvas$class = new StOffscreenCanvas$class();
export let stPath2d$class = new StPath2d$class();
export let stTextMetrics$class = new StTextMetrics$class();
export let stCssStyleDeclaration$class = new StCssStyleDeclaration$class();
export let stCssRule$class = new StCssRule$class();
export let stStyleSheet$class = new StStyleSheet$class();
export let stMediaList$class = new StMediaList$class();
export let stMediaQueryList$class = new StMediaQueryList$class();
export let stMediaStream$class = new StMediaStream$class();
export let stClipboard$class = new StClipboard$class();
export let stCredentialsContainer$class = new StCredentialsContainer$class();
export let stGeolocation$class = new StGeolocation$class();
export let stLockManager$class = new StLockManager$class();
export let stMediaCapabilities$class = new StMediaCapabilities$class();
export let stMediaDevices$class = new StMediaDevices$class();
export let stMediaSession$class = new StMediaSession$class();
export let stNavigator$class = new StNavigator$class();
export let stPermissions$class = new StPermissions$class();
export let stServiceWorkerContainer$class = new StServiceWorkerContainer$class();
export let stStorageManager$class = new StStorageManager$class();
export let stHistory$class = new StHistory$class();
export let stScreen$class = new StScreen$class();
export let stMessageEvent$class = new StMessageEvent$class();
export let stMessagePort$class = new StMessagePort$class();
export let stWorker$class = new StWorker$class();
export let stWorkerOptions$class = new StWorkerOptions$class();
export let stSpeechSynthesis$class = new StSpeechSynthesis$class();
export let stNode$class = new StNode$class();
export let stAnimation$class = new StAnimation$class();
export let stScreenOrientation$class = new StScreenOrientation$class();
export let stVisualViewport$class = new StVisualViewport$class();
export let stWindow$class = new StWindow$class();
export let stWorkerGlobalScope$class = new StWorkerGlobalScope$class();
export let stRange$class = new StRange$class();
export let stCssImportRule$class = new StCssImportRule$class();
export let stCssStyleRule$class = new StCssStyleRule$class();
export let stCssStyleSheet$class = new StCssStyleSheet$class();
export let stDocument$class = new StDocument$class();
export let stDocumentFragment$class = new StDocumentFragment$class();
export let stDocumentType$class = new StDocumentType$class();
export let stElement$class = new StElement$class();
export let stAttr$class = new StAttr$class();
export let stCharacterData$class = new StCharacterData$class();
export let stDedicatedWorkerGlobalScope$class = new StDedicatedWorkerGlobalScope$class();
export let stShadowRoot$class = new StShadowRoot$class();
export let stHtmlElement$class = new StHtmlElement$class();
export let stComment$class = new StComment$class();
export let stText$class = new StText$class();
export let stHtmlCanvasElement$class = new StHtmlCanvasElement$class();
export let stHtmlAnchorElement$class = new StHtmlAnchorElement$class();
export let stHtmlBodyElement$class = new StHtmlBodyElement$class();
export let stHtmlBrElement$class = new StHtmlBrElement$class();
export let stHtmlButtonElement$class = new StHtmlButtonElement$class();
export let stHtmlDataListElement$class = new StHtmlDataListElement$class();
export let stHtmlDivElement$class = new StHtmlDivElement$class();
export let stHtmlEmbedElement$class = new StHtmlEmbedElement$class();
export let stHtmlFieldSetElement$class = new StHtmlFieldSetElement$class();
export let stHtmlFormElement$class = new StHtmlFormElement$class();
export let stHtmlHeadElement$class = new StHtmlHeadElement$class();
export let stHtmlHtmlElement$class = new StHtmlHtmlElement$class();
export let stHtmlIframeElement$class = new StHtmlIframeElement$class();
export let stHtmlImageElement$class = new StHtmlImageElement$class();
export let stHtmlInputElement$class = new StHtmlInputElement$class();
export let stHtmlLabelElement$class = new StHtmlLabelElement$class();
export let stHtmlLinkElement$class = new StHtmlLinkElement$class();
export let stHtmlMetaElement$class = new StHtmlMetaElement$class();
export let stHtmlOptionElement$class = new StHtmlOptionElement$class();
export let stHtmlParagraphElement$class = new StHtmlParagraphElement$class();
export let stHtmlScriptElement$class = new StHtmlScriptElement$class();
export let stHtmlSlotElement$class = new StHtmlSlotElement$class();
export let stHtmlSpanElement$class = new StHtmlSpanElement$class();
export let stHtmlTemplateElement$class = new StHtmlTemplateElement$class();
export let stHtmlTextAreaElement$class = new StHtmlTextAreaElement$class();
export let stHtmlTitleElement$class = new StHtmlTitleElement$class();
export let stHtmlUnknownElement$class = new StHtmlUnknownElement$class();
export let stHtmlTableCaptionElement$class = new StHtmlTableCaptionElement$class();
export let stHtmlTableCellElement$class = new StHtmlTableCellElement$class();
export let stHtmlTableElement$class = new StHtmlTableElement$class();
export let stHtmlTableRowElement$class = new StHtmlTableRowElement$class();
export let stHtmlTableSectionElement$class = new StHtmlTableSectionElement$class();

stBrowserApp$class.$superclass$( stObject$class );
stComponent$class.$superclass$( stObject$class );
stLanguage$class.$superclass$( stObject$class );
stLanguageCode$class.$superclass$( stObject$class );
stFetch$class.$superclass$( stObject$class );
stAbstractRange$class.$superclass$( stJsObject$class );
stCustomElementRegistry$class.$superclass$( stJsObject$class );
stDomImplementation$class.$superclass$( stJsObject$class );
stDomTokenList$class.$superclass$( stJsObject$class );
stLocation$class.$superclass$( stJsObject$class );
stNamedNodeMap$class.$superclass$( stJsObject$class );
stSelection$class.$superclass$( stJsObject$class );
stStorage$class.$superclass$( stJsObject$class );
stValidityState$class.$superclass$( stJsObject$class );
stCanvasGradient$class.$superclass$( stJsObject$class );
stCanvasPattern$class.$superclass$( stJsObject$class );
stCanvasRenderingContext2d$class.$superclass$( stJsObject$class );
stContextAttributes$class.$superclass$( stJsObject$class );
stDomMatrix$class.$superclass$( stJsObject$class );
stDomPoint$class.$superclass$( stJsObject$class );
stImageBitmap$class.$superclass$( stJsObject$class );
stImageData$class.$superclass$( stJsObject$class );
stOffscreenCanvas$class.$superclass$( stJsObject$class );
stPath2d$class.$superclass$( stJsObject$class );
stTextMetrics$class.$superclass$( stJsObject$class );
stCssStyleDeclaration$class.$superclass$( stJsObject$class );
stCssRule$class.$superclass$( stJsObject$class );
stStyleSheet$class.$superclass$( stJsObject$class );
stMediaList$class.$superclass$( stJsObject$class );
stMediaQueryList$class.$superclass$( stJsObject$class );
stMediaStream$class.$superclass$( stJsObject$class );
stClipboard$class.$superclass$( stJsObject$class );
stCredentialsContainer$class.$superclass$( stJsObject$class );
stGeolocation$class.$superclass$( stJsObject$class );
stLockManager$class.$superclass$( stJsObject$class );
stMediaCapabilities$class.$superclass$( stJsObject$class );
stMediaDevices$class.$superclass$( stJsObject$class );
stMediaSession$class.$superclass$( stJsObject$class );
stNavigator$class.$superclass$( stJsObject$class );
stPermissions$class.$superclass$( stJsObject$class );
stServiceWorkerContainer$class.$superclass$( stJsObject$class );
stStorageManager$class.$superclass$( stJsObject$class );
stHistory$class.$superclass$( stJsObject$class );
stScreen$class.$superclass$( stJsObject$class );
stMessageEvent$class.$superclass$( stJsObject$class );
stMessagePort$class.$superclass$( stJsObject$class );
stWorker$class.$superclass$( stJsObject$class );
stWorkerOptions$class.$superclass$( stJsObject$class );
stSpeechSynthesis$class.$superclass$( stEventTarget$class );
stNode$class.$superclass$( stEventTarget$class );
stAnimation$class.$superclass$( stEventTarget$class );
stScreenOrientation$class.$superclass$( stEventTarget$class );
stVisualViewport$class.$superclass$( stEventTarget$class );
stWindow$class.$superclass$( stEventTarget$class );
stWorkerGlobalScope$class.$superclass$( stEventTarget$class );
stRange$class.$superclass$( stAbstractRange$class );
stCssImportRule$class.$superclass$( stCssRule$class );
stCssStyleRule$class.$superclass$( stCssRule$class );
stCssStyleSheet$class.$superclass$( stStyleSheet$class );
stDocument$class.$superclass$( stNode$class );
stDocumentFragment$class.$superclass$( stNode$class );
stDocumentType$class.$superclass$( stNode$class );
stElement$class.$superclass$( stNode$class );
stAttr$class.$superclass$( stNode$class );
stCharacterData$class.$superclass$( stNode$class );
stDedicatedWorkerGlobalScope$class.$superclass$( stWorkerGlobalScope$class );
stShadowRoot$class.$superclass$( stDocumentFragment$class );
stHtmlElement$class.$superclass$( stElement$class );
stComment$class.$superclass$( stCharacterData$class );
stText$class.$superclass$( stCharacterData$class );
stHtmlCanvasElement$class.$superclass$( stHtmlElement$class );
stHtmlAnchorElement$class.$superclass$( stHtmlElement$class );
stHtmlBodyElement$class.$superclass$( stHtmlElement$class );
stHtmlBrElement$class.$superclass$( stHtmlElement$class );
stHtmlButtonElement$class.$superclass$( stHtmlElement$class );
stHtmlDataListElement$class.$superclass$( stHtmlElement$class );
stHtmlDivElement$class.$superclass$( stHtmlElement$class );
stHtmlEmbedElement$class.$superclass$( stHtmlElement$class );
stHtmlFieldSetElement$class.$superclass$( stHtmlElement$class );
stHtmlFormElement$class.$superclass$( stHtmlElement$class );
stHtmlHeadElement$class.$superclass$( stHtmlElement$class );
stHtmlHtmlElement$class.$superclass$( stHtmlElement$class );
stHtmlIframeElement$class.$superclass$( stHtmlElement$class );
stHtmlImageElement$class.$superclass$( stHtmlElement$class );
stHtmlInputElement$class.$superclass$( stHtmlElement$class );
stHtmlLabelElement$class.$superclass$( stHtmlElement$class );
stHtmlLinkElement$class.$superclass$( stHtmlElement$class );
stHtmlMetaElement$class.$superclass$( stHtmlElement$class );
stHtmlOptionElement$class.$superclass$( stHtmlElement$class );
stHtmlParagraphElement$class.$superclass$( stHtmlElement$class );
stHtmlScriptElement$class.$superclass$( stHtmlElement$class );
stHtmlSlotElement$class.$superclass$( stHtmlElement$class );
stHtmlSpanElement$class.$superclass$( stHtmlElement$class );
stHtmlTemplateElement$class.$superclass$( stHtmlElement$class );
stHtmlTextAreaElement$class.$superclass$( stHtmlElement$class );
stHtmlTitleElement$class.$superclass$( stHtmlElement$class );
stHtmlUnknownElement$class.$superclass$( stHtmlElement$class );
stHtmlTableCaptionElement$class.$superclass$( stHtmlElement$class );
stHtmlTableCellElement$class.$superclass$( stHtmlElement$class );
stHtmlTableElement$class.$superclass$( stHtmlElement$class );
stHtmlTableRowElement$class.$superclass$( stHtmlElement$class );
stHtmlTableSectionElement$class.$superclass$( stHtmlElement$class );

stClass$class.$classes().$add$( stBrowserApp$class );
stClass$class.$classes().$add$( stComponent$class );
stClass$class.$classes().$add$( stLanguage$class );
stClass$class.$classes().$add$( stLanguageCode$class );
stClass$class.$classes().$add$( stFetch$class );
stClass$class.$classes().$add$( stAbstractRange$class );
stClass$class.$classes().$add$( stCustomElementRegistry$class );
stClass$class.$classes().$add$( stDomImplementation$class );
stClass$class.$classes().$add$( stDomTokenList$class );
stClass$class.$classes().$add$( stLocation$class );
stClass$class.$classes().$add$( stNamedNodeMap$class );
stClass$class.$classes().$add$( stSelection$class );
stClass$class.$classes().$add$( stStorage$class );
stClass$class.$classes().$add$( stValidityState$class );
stClass$class.$classes().$add$( stCanvasGradient$class );
stClass$class.$classes().$add$( stCanvasPattern$class );
stClass$class.$classes().$add$( stCanvasRenderingContext2d$class );
stClass$class.$classes().$add$( stContextAttributes$class );
stClass$class.$classes().$add$( stDomMatrix$class );
stClass$class.$classes().$add$( stDomPoint$class );
stClass$class.$classes().$add$( stImageBitmap$class );
stClass$class.$classes().$add$( stImageData$class );
stClass$class.$classes().$add$( stOffscreenCanvas$class );
stClass$class.$classes().$add$( stPath2d$class );
stClass$class.$classes().$add$( stTextMetrics$class );
stClass$class.$classes().$add$( stCssStyleDeclaration$class );
stClass$class.$classes().$add$( stCssRule$class );
stClass$class.$classes().$add$( stStyleSheet$class );
stClass$class.$classes().$add$( stMediaList$class );
stClass$class.$classes().$add$( stMediaQueryList$class );
stClass$class.$classes().$add$( stMediaStream$class );
stClass$class.$classes().$add$( stClipboard$class );
stClass$class.$classes().$add$( stCredentialsContainer$class );
stClass$class.$classes().$add$( stGeolocation$class );
stClass$class.$classes().$add$( stLockManager$class );
stClass$class.$classes().$add$( stMediaCapabilities$class );
stClass$class.$classes().$add$( stMediaDevices$class );
stClass$class.$classes().$add$( stMediaSession$class );
stClass$class.$classes().$add$( stNavigator$class );
stClass$class.$classes().$add$( stPermissions$class );
stClass$class.$classes().$add$( stServiceWorkerContainer$class );
stClass$class.$classes().$add$( stStorageManager$class );
stClass$class.$classes().$add$( stHistory$class );
stClass$class.$classes().$add$( stScreen$class );
stClass$class.$classes().$add$( stMessageEvent$class );
stClass$class.$classes().$add$( stMessagePort$class );
stClass$class.$classes().$add$( stWorker$class );
stClass$class.$classes().$add$( stWorkerOptions$class );
stClass$class.$classes().$add$( stSpeechSynthesis$class );
stClass$class.$classes().$add$( stNode$class );
stClass$class.$classes().$add$( stAnimation$class );
stClass$class.$classes().$add$( stScreenOrientation$class );
stClass$class.$classes().$add$( stVisualViewport$class );
stClass$class.$classes().$add$( stWindow$class );
stClass$class.$classes().$add$( stWorkerGlobalScope$class );
stClass$class.$classes().$add$( stRange$class );
stClass$class.$classes().$add$( stCssImportRule$class );
stClass$class.$classes().$add$( stCssStyleRule$class );
stClass$class.$classes().$add$( stCssStyleSheet$class );
stClass$class.$classes().$add$( stDocument$class );
stClass$class.$classes().$add$( stDocumentFragment$class );
stClass$class.$classes().$add$( stDocumentType$class );
stClass$class.$classes().$add$( stElement$class );
stClass$class.$classes().$add$( stAttr$class );
stClass$class.$classes().$add$( stCharacterData$class );
stClass$class.$classes().$add$( stDedicatedWorkerGlobalScope$class );
stClass$class.$classes().$add$( stShadowRoot$class );
stClass$class.$classes().$add$( stHtmlElement$class );
stClass$class.$classes().$add$( stComment$class );
stClass$class.$classes().$add$( stText$class );
stClass$class.$classes().$add$( stHtmlCanvasElement$class );
stClass$class.$classes().$add$( stHtmlAnchorElement$class );
stClass$class.$classes().$add$( stHtmlBodyElement$class );
stClass$class.$classes().$add$( stHtmlBrElement$class );
stClass$class.$classes().$add$( stHtmlButtonElement$class );
stClass$class.$classes().$add$( stHtmlDataListElement$class );
stClass$class.$classes().$add$( stHtmlDivElement$class );
stClass$class.$classes().$add$( stHtmlEmbedElement$class );
stClass$class.$classes().$add$( stHtmlFieldSetElement$class );
stClass$class.$classes().$add$( stHtmlFormElement$class );
stClass$class.$classes().$add$( stHtmlHeadElement$class );
stClass$class.$classes().$add$( stHtmlHtmlElement$class );
stClass$class.$classes().$add$( stHtmlIframeElement$class );
stClass$class.$classes().$add$( stHtmlImageElement$class );
stClass$class.$classes().$add$( stHtmlInputElement$class );
stClass$class.$classes().$add$( stHtmlLabelElement$class );
stClass$class.$classes().$add$( stHtmlLinkElement$class );
stClass$class.$classes().$add$( stHtmlMetaElement$class );
stClass$class.$classes().$add$( stHtmlOptionElement$class );
stClass$class.$classes().$add$( stHtmlParagraphElement$class );
stClass$class.$classes().$add$( stHtmlScriptElement$class );
stClass$class.$classes().$add$( stHtmlSlotElement$class );
stClass$class.$classes().$add$( stHtmlSpanElement$class );
stClass$class.$classes().$add$( stHtmlTemplateElement$class );
stClass$class.$classes().$add$( stHtmlTextAreaElement$class );
stClass$class.$classes().$add$( stHtmlTitleElement$class );
stClass$class.$classes().$add$( stHtmlUnknownElement$class );
stClass$class.$classes().$add$( stHtmlTableCaptionElement$class );
stClass$class.$classes().$add$( stHtmlTableCellElement$class );
stClass$class.$classes().$add$( stHtmlTableElement$class );
stClass$class.$classes().$add$( stHtmlTableRowElement$class );
stClass$class.$classes().$add$( stHtmlTableSectionElement$class );


//# sourceMappingURL=Browser.js.map
