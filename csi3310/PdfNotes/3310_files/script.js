
function LoadSld( slideId )
{
	if( !g_supportsPPTHTML ) return
	if( slideId )
		parent.SldUpdated(slideId)
	g_origSz=parseInt(SlideObj.style.fontSize)
	g_origH=SlideObj.style.posHeight
	g_origW=SlideObj.style.posWidth
	g_scaleHyperlinks=(document.all.tags("AREA").length>0)
	if( g_scaleHyperlinks )
		InitHLinkArray()
	if( g_scaleInFrame||(IsWin("PPTSld") && parent.IsFullScrMode() ) )
		document.body.scroll="no"
	_RSW()
	if( IsWin("PPTSld") && parent.IsFullScrMode() )	{
		document.oncontextmenu=parent._CM;
		self.focus()
	}
}
function MakeSldVis( fTrans ) 
{
	fTrans=fTrans && g_showAnimation
	if( fTrans )
	{
		if( g_bgSound ) {
			idx=g_bgSound.indexOf(",");
			pptSound.src=g_bgSound.substr( 0, idx );
			pptSound.loop= -(parseInt(g_bgSound.substr(idx+1)));
		}
		SlideObj.filters.revealtrans.Apply()
	}
	SlideObj.style.visibility="visible"
	if( fTrans )
		SlideObj.filters.revealtrans.Play()
}
function MakeNotesVis() 
{
	if( !IsNts() ) return false 
	SlideObj.style.display="none"
	nObj = document.all.item("NotesObj")
	parent.SetHasNts(0)
	if( nObj ) { 
		nObj.style.display=""
		parent.SetHasNts(1)
	}
	return 1
}
function Redirect( frmId,sId )
{
	var str=document.location.hash,idx=str.indexOf('#')
	if(idx>=0) str=str.substr(1);
	if( window.name != frmId && ( sId != str) ) {
		obj = document.all.item("Main-File")
		window.location.href=obj.href+"#"+sId
		return 1
	}
	return 0
}
function HideMenu() { if( frames["PPTSld"] && PPTSld.document.all.item("ctxtmenu") && PPTSld.ctxtmenu.style.display!="none" ) { PPTSld.ctxtmenu.style.display='none'; return true } return false }
function IsWin( name ) { return window.name == name }
function IsNts() { return IsWin("PPTNts") }
function IsSldOrNts() { return( IsWin("PPTSld")||IsWin("PPTNts") ) }
function SupportsPPTAnimation() { return( navigator.platform == "Win32" && navigator.appVersion.indexOf("Windows")>0 ) }
function SupportsPPTHTML()
{
	var appVer=navigator.appVersion, msie=appVer.indexOf("MSIE "), ver=0
	if( msie >= 0 )
		ver=parseFloat( appVer.substring( msie+5, appVer.indexOf(";",msie) ) )
	else
		ver=parseInt(appVer)

	return( ver >= 4 && msie >= 0 )
}
var MHTMLPrefix = CalculateMHTMLPrefix(); 
function CalculateMHTMLPrefix()
{
	if ( document.location.protocol == 'mhtml:') { 
		href=new String(document.location.href) 
		Start=href.indexOf('!')+1 
		End=href.lastIndexOf('/')+1 
		if (End < Start) 
			return href.substring(0, Start) 
		else 
		return href.substring(0, End) 
	}
	return '';
}

function _RSW()
{
	if( !g_supportsPPTHTML || IsNts() ||
	  ( !g_scaleInFrame && (( window.name != "PPTSld" ) || !parent.IsFullScrMode()) ) )
		return

	cltWidth=document.body.clientWidth
	cltHeight=document.body.clientHeight
	factor=(1.0*cltWidth)/g_origW
	if( cltHeight < g_origH*factor )
		factor=(1.0*cltHeight)/g_origH

	newSize = g_origSz * factor
	if( newSize < 1 ) newSize=1

	s=SlideObj.style
	s.fontSize=newSize+"px"
	s.posWidth=g_origW*factor
	s.posHeight=g_origH*factor
	s.posLeft=(cltWidth-s.posWidth)/2
	s.posTop=(cltHeight-s.posHeight)/2

	if( g_scaleHyperlinks )
		ScaleHyperlinks( factor )
}

function _KPH()
{ 
  if( IsNts() ) return;

  if( !parent.IsFramesMode() && event.keyCode == 27 && !parent.HideMenu() )
    parent.window.close( self );
  else if( event.keyCode == 32 )
  {
    if( window.name == "PPTSld" )
      parent.PPTSld.DocumentOnClick();
    else
      parent.GoToNextSld();
  }
}

function DocumentOnClick()
{
	if( IsNts() || parent.HideMenu() ) return;
	if( ( g_allowAdvOnClick && !parent.IsFramesMode() ) ||
	    (event && (event.keyCode==32) ) )
		parent.GoToNextSld();
}



var g_supportsPPTHTML = SupportsPPTHTML(), g_scaleInFrame = true, gId="", g_bgSound="",
    g_scaleHyperlinks = false, g_allowAdvOnClick = true, g_showInBrowser = false;
var g_showAnimation = g_supportsPPTHTML && SupportsPPTAnimation() && ( (window.name=="PPTSld" && !parent.IsFramesMode()) || g_showInBrowser );var g_hasTrans = false, g_autoTrans = false, g_transSecs = 0;
var g_animManager = null;

var ENDSHOW_MESG="End of slide show, click to exit.", SCREEN_MODE="Frames", gIsEndShow=0, NUM_VIS_SLDS=371, SCRIPT_HREF="script.js", FULLSCR_HREF="fullscreen.htm";
var gCurSld = gPrevSld = 1, g_offset = 0, gNtsOpen = gHasNts = gOtlTxtExp = gNarrationPaused = false, gOtlOpen = true
window.gPPTHTML=SupportsPPTHTML()

function UpdNtsPane(){ PPTNts.location.replace( MHTMLPrefix+GetHrefObj( gCurSld ).mNtsHref ) }
function UpdNavPane( sldIndex ){ if(gNavLoaded) PPTNav.UpdNav() }
function UpdOtNavPane(){ if(gOtlNavLoaded) PPTOtlNav.UpdOtlNav() }
function UpdOtlPane(){ if(gOtlLoaded) PPTOtl.UpdOtl() }
function SetHasNts( fVal )
{
	if( gHasNts != fVal ) {
		gHasNts=fVal
		UpdNavPane()
	}
}
function ToggleOtlText()
{
	gOtlTxtExp=!gOtlTxtExp
	UpdOtlPane()
}
function ToggleOtlPane()
{
	frmset=document.all("PPTHorizAdjust")
	frm=document.all("PPTOtl")

	if( gOtlOpen )
		frmset.cols="*,100%"
	else
		frmset.cols="20%,80%"

	gOtlOpen=!gOtlOpen
	frm.noResize=!frm.noResize
	UpdOtNavPane()
}
function ToggleNtsPane()
{
	frmset=document.all("PPTVertAdjust")
	frm=document.all("PPTNts")

	if( gNtsOpen )
		frmset.rows="100%,*"
	else
		frmset.rows="80%,20%"

	gNtsOpen=!gNtsOpen
	UpdNtsPane()
}
function FullScreen(){ window.open( MHTMLPrefix+FULLSCR_HREF,null,"fullscreen=yes" ) }
function ToggleVNarration()
{
	rObj=PPTSld.document.all("NSPlay")
	if( rObj ) {
		if( gNarrationPaused )
			rObj.Play()
		else
			rObj.Pause()

		gNarrationPaused=!gNarrationPaused
	}
}
function GetCurSldNum()
{   
	obj=GetHrefObj(gCurSld)
	if( obj.mOrigVis == 1 )
		return obj.mSldIdx
	else   
		return gCurSld
}
function GetNumSlds()
{   
	if( GetHrefObj(gCurSld).mOrigVis == 1 )
		return NUM_VIS_SLDS
	else
		return gDocTable.length
}
function GetSldNum( href )
{
	for(ii=0; ii<gDocTable.length; ii++) {
		if ( gDocTable[ii].mSldHref == href )
			return ii+1
	}
	return 1
}
function GetHrefObj( sldIdx ){ return gDocTable[sldIdx-1] }
function IsFramesMode(){ return ( SCREEN_MODE == "Frames" ) }
function IsFullScrMode(){ return ( SCREEN_MODE == "FullScreen" ) }
function GoToNextSld()
{   
	ii=gCurSld + 1
	if( GetHrefObj( ii-1 ).mOrigVis == 0 ) {
		if( ii<=gDocTable.length ) {
			obj=GetHrefObj(ii)
			obj.mVis=1
			GoToSld(obj.mSldHref)
			return
		}		
	}
	else {
		obj=GetHrefObj( ii )
		while ( obj && ( obj.mOrigVis == 0 ) )
			obj=GetHrefObj(ii++)
		if( obj && obj.mOrigVis ) {
			GoToSld(obj.mSldHref)	
			return
		}	
	}
	if( !IsFramesMode() ) EndShow()
}
function GoToPrevSld()
{
	ii=gCurSld-1
	if( ii > 0 ) {      
		obj=GetHrefObj(ii)
		while ( ( obj.mVis == 0 ) && ( ii>0 ) )
			obj=GetHrefObj(ii--)
		GoToSld(obj.mSldHref)
	}
}
function GoToFirst(){ GoToSld( GetHrefObj(1).mSldHref ) }
function GoToLast()
{
	ii=gDocTable.length
	if( ii != gCurSld )
		GoToSld( GetHrefObj(ii).mSldHref )
}
function GoToSld( href )
{
	if( PPTSld.event ) PPTSld.event.cancelBubble=true
	GetHrefObj( GetSldNum(href) ).mVis=1
	PPTSld.location.href=MHTMLPrefix+href
}
function SldUpdated( id )
{
	if( id == GetHrefObj(gCurSld).mSldHref ) return
	gPrevSld=gCurSld
	gCurSld=GetSldNum(id)
	if( IsFramesMode() ) {
		UpdNavPane(); UpdOtlPane(); UpdNtsPane()
	}
}

function PrevSldViewed(){ GoToSld( GetHrefObj(gPrevSld).mSldHref ) }
function HasPrevSld() { return ( gIsEndShow || ( gCurSld != 1 && GetHrefObj( gCurSld-1 ).mVis == 1 )||( GetCurSldNum() > 1 ) ) }
function HasNextSld() { return (GetCurSldNum() != GetNumSlds()) }
function EndShow()
{
	if( PPTSld.event ) PPTSld.event.cancelBubble=true

	doc=PPTSld.document
	doc.open()
	doc.writeln('<html><head><script defer>function CloseWindow(){ if( parent.HideMenu() ) return; if( !parent.IsFramesMode() && event && (event.keyCode==27 || event.keyCode==32 || event.type=="click" ) ) parent.window.close( self ); } function Unload() { parent.gIsEndShow=0; } function SetupEndShow() { parent.gIsEndShow=1; document.body.scroll="no"; document.onkeypress=CloseWindow; document.onclick=CloseWindow; document.oncontextmenu=parent._CM; }</script></head><body bgcolor=black onload=SetupEndShow() onunload=Unload()><center><p><font face=Tahoma color=white size=2><br><b>' + ENDSHOW_MESG + '</b></font></p></center></body></html>')
	doc.close()
}
function SetSldVisited(){ gDocTable[gCurSld-1].mVisited=true }
function IsSldVisited(){ return gDocTable[gCurSld-1].mVisited }
function hrefList( sldHref, visible, sldIdx )
{
	this.mSldHref= this.mNtsHref = sldHref
	this.mSldIdx = sldIdx
	this.mOrigVis= this.mVis = visible
	this.mVisited= false
}
var gDocTable = new Array(
   new hrefList("slide0001.htm", 1, 1),
   new hrefList("slide0003.htm", 1, 2),
   new hrefList("slide0002.htm", 1, 3),
   new hrefList("slide0006.htm", 1, 4),
   new hrefList("slide0004.htm", 1, 5),
   new hrefList("slide0007.htm", 1, 6),
   new hrefList("slide0008.htm", 1, 7),
   new hrefList("slide0005.htm", 1, 8),
   new hrefList("slide0009.htm", 1, 9),
   new hrefList("slide0010.htm", 1, 10),
   new hrefList("slide0011.htm", 1, 11),
   new hrefList("slide0012.htm", 1, 12),
   new hrefList("slide0013.htm", 1, 13),
   new hrefList("slide0014.htm", 1, 14),
   new hrefList("slide0015.htm", 1, 15),
   new hrefList("slide0016.htm", 1, 16),
   new hrefList("slide0017.htm", 1, 17),
   new hrefList("slide0018.htm", 1, 18),
   new hrefList("slide0019.htm", 1, 19),
   new hrefList("slide0020.htm", 1, 20),
   new hrefList("slide0021.htm", 1, 21),
   new hrefList("slide0022.htm", 1, 22),
   new hrefList("slide0023.htm", 1, 23),
   new hrefList("slide0024.htm", 1, 24),
   new hrefList("slide0025.htm", 1, 25),
   new hrefList("slide0026.htm", 1, 26),
   new hrefList("slide0027.htm", 1, 27),
   new hrefList("slide0028.htm", 1, 28),
   new hrefList("slide0029.htm", 1, 29),
   new hrefList("slide0030.htm", 1, 30),
   new hrefList("slide0031.htm", 1, 31),
   new hrefList("slide0032.htm", 1, 32),
   new hrefList("slide0033.htm", 1, 33),
   new hrefList("slide0034.htm", 1, 34),
   new hrefList("slide0035.htm", 1, 35),
   new hrefList("slide0036.htm", 1, 36),
   new hrefList("slide0037.htm", 1, 37),
   new hrefList("slide0038.htm", 1, 38),
   new hrefList("slide0039.htm", 1, 39),
   new hrefList("slide0040.htm", 1, 40),
   new hrefList("slide0041.htm", 1, 41),
   new hrefList("slide0042.htm", 1, 42),
   new hrefList("slide0043.htm", 1, 43),
   new hrefList("slide0044.htm", 1, 44),
   new hrefList("slide0045.htm", 1, 45),
   new hrefList("slide0046.htm", 1, 46),
   new hrefList("slide0047.htm", 1, 47),
   new hrefList("slide0048.htm", 1, 48),
   new hrefList("slide0049.htm", 1, 49),
   new hrefList("slide0050.htm", 1, 50),
   new hrefList("slide0051.htm", 1, 51),
   new hrefList("slide0052.htm", 1, 52),
   new hrefList("slide0053.htm", 1, 53),
   new hrefList("slide0054.htm", 1, 54),
   new hrefList("slide0055.htm", 1, 55),
   new hrefList("slide0056.htm", 1, 56),
   new hrefList("slide0057.htm", 1, 57),
   new hrefList("slide0058.htm", 1, 58),
   new hrefList("slide0059.htm", 1, 59),
   new hrefList("slide0060.htm", 1, 60),
   new hrefList("slide0061.htm", 1, 61),
   new hrefList("slide0062.htm", 1, 62),
   new hrefList("slide0063.htm", 1, 63),
   new hrefList("slide0064.htm", 1, 64),
   new hrefList("slide0065.htm", 1, 65),
   new hrefList("slide0066.htm", 1, 66),
   new hrefList("slide0067.htm", 1, 67),
   new hrefList("slide0068.htm", 1, 68),
   new hrefList("slide0069.htm", 1, 69),
   new hrefList("slide0070.htm", 1, 70),
   new hrefList("slide0071.htm", 1, 71),
   new hrefList("slide0072.htm", 1, 72),
   new hrefList("slide0073.htm", 1, 73),
   new hrefList("slide0074.htm", 1, 74),
   new hrefList("slide0075.htm", 1, 75),
   new hrefList("slide0076.htm", 1, 76),
   new hrefList("slide0077.htm", 1, 77),
   new hrefList("slide0078.htm", 1, 78),
   new hrefList("slide0079.htm", 1, 79),
   new hrefList("slide0080.htm", 1, 80),
   new hrefList("slide0081.htm", 1, 81),
   new hrefList("slide0082.htm", 1, 82),
   new hrefList("slide0083.htm", 1, 83),
   new hrefList("slide0084.htm", 1, 84),
   new hrefList("slide0085.htm", 1, 85),
   new hrefList("slide0086.htm", 1, 86),
   new hrefList("slide0087.htm", 1, 87),
   new hrefList("slide0088.htm", 1, 88),
   new hrefList("slide0089.htm", 1, 89),
   new hrefList("slide0090.htm", 1, 90),
   new hrefList("slide0091.htm", 1, 91),
   new hrefList("slide0092.htm", 1, 92),
   new hrefList("slide0093.htm", 1, 93),
   new hrefList("slide0094.htm", 1, 94),
   new hrefList("slide0095.htm", 1, 95),
   new hrefList("slide0096.htm", 1, 96),
   new hrefList("slide0097.htm", 1, 97),
   new hrefList("slide0098.htm", 1, 98),
   new hrefList("slide0099.htm", 1, 99),
   new hrefList("slide0100.htm", 1, 100),
   new hrefList("slide0101.htm", 1, 101),
   new hrefList("slide0102.htm", 1, 102),
   new hrefList("slide0103.htm", 1, 103),
   new hrefList("slide0104.htm", 1, 104),
   new hrefList("slide0105.htm", 1, 105),
   new hrefList("slide0106.htm", 1, 106),
   new hrefList("slide0107.htm", 1, 107),
   new hrefList("slide0108.htm", 1, 108),
   new hrefList("slide0109.htm", 1, 109),
   new hrefList("slide0110.htm", 1, 110),
   new hrefList("slide0111.htm", 1, 111),
   new hrefList("slide0112.htm", 1, 112),
   new hrefList("slide0113.htm", 1, 113),
   new hrefList("slide0114.htm", 1, 114),
   new hrefList("slide0115.htm", 1, 115),
   new hrefList("slide0116.htm", 1, 116),
   new hrefList("slide0117.htm", 1, 117),
   new hrefList("slide0118.htm", 1, 118),
   new hrefList("slide0119.htm", 1, 119),
   new hrefList("slide0120.htm", 1, 120),
   new hrefList("slide0121.htm", 1, 121),
   new hrefList("slide0122.htm", 1, 122),
   new hrefList("slide0123.htm", 1, 123),
   new hrefList("slide0124.htm", 1, 124),
   new hrefList("slide0125.htm", 1, 125),
   new hrefList("slide0126.htm", 1, 126),
   new hrefList("slide0127.htm", 1, 127),
   new hrefList("slide0128.htm", 1, 128),
   new hrefList("slide0129.htm", 1, 129),
   new hrefList("slide0130.htm", 1, 130),
   new hrefList("slide0131.htm", 1, 131),
   new hrefList("slide0132.htm", 1, 132),
   new hrefList("slide0133.htm", 1, 133),
   new hrefList("slide0134.htm", 1, 134),
   new hrefList("slide0135.htm", 1, 135),
   new hrefList("slide0136.htm", 1, 136),
   new hrefList("slide0137.htm", 1, 137),
   new hrefList("slide0138.htm", 1, 138),
   new hrefList("slide0139.htm", 1, 139),
   new hrefList("slide0140.htm", 1, 140),
   new hrefList("slide0141.htm", 1, 141),
   new hrefList("slide0142.htm", 1, 142),
   new hrefList("slide0143.htm", 1, 143),
   new hrefList("slide0144.htm", 1, 144),
   new hrefList("slide0145.htm", 1, 145),
   new hrefList("slide0146.htm", 1, 146),
   new hrefList("slide0147.htm", 1, 147),
   new hrefList("slide0148.htm", 1, 148),
   new hrefList("slide0149.htm", 1, 149),
   new hrefList("slide0150.htm", 1, 150),
   new hrefList("slide0151.htm", 1, 151),
   new hrefList("slide0152.htm", 1, 152),
   new hrefList("slide0153.htm", 1, 153),
   new hrefList("slide0154.htm", 1, 154),
   new hrefList("slide0155.htm", 1, 155),
   new hrefList("slide0156.htm", 1, 156),
   new hrefList("slide0157.htm", 1, 157),
   new hrefList("slide0158.htm", 1, 158),
   new hrefList("slide0159.htm", 1, 159),
   new hrefList("slide0160.htm", 1, 160),
   new hrefList("slide0161.htm", 1, 161),
   new hrefList("slide0162.htm", 1, 162),
   new hrefList("slide0163.htm", 1, 163),
   new hrefList("slide0164.htm", 1, 164),
   new hrefList("slide0165.htm", 1, 165),
   new hrefList("slide0166.htm", 1, 166),
   new hrefList("slide0167.htm", 1, 167),
   new hrefList("slide0168.htm", 1, 168),
   new hrefList("slide0169.htm", 1, 169),
   new hrefList("slide0170.htm", 1, 170),
   new hrefList("slide0171.htm", 1, 171),
   new hrefList("slide0172.htm", 1, 172),
   new hrefList("slide0173.htm", 1, 173),
   new hrefList("slide0174.htm", 1, 174),
   new hrefList("slide0175.htm", 1, 175),
   new hrefList("slide0176.htm", 1, 176),
   new hrefList("slide0177.htm", 1, 177),
   new hrefList("slide0178.htm", 1, 178),
   new hrefList("slide0179.htm", 1, 179),
   new hrefList("slide0180.htm", 1, 180),
   new hrefList("slide0181.htm", 1, 181),
   new hrefList("slide0182.htm", 1, 182),
   new hrefList("slide0183.htm", 1, 183),
   new hrefList("slide0184.htm", 1, 184),
   new hrefList("slide0185.htm", 1, 185),
   new hrefList("slide0186.htm", 1, 186),
   new hrefList("slide0187.htm", 1, 187),
   new hrefList("slide0188.htm", 1, 188),
   new hrefList("slide0189.htm", 1, 189),
   new hrefList("slide0190.htm", 1, 190),
   new hrefList("slide0191.htm", 1, 191),
   new hrefList("slide0192.htm", 1, 192),
   new hrefList("slide0193.htm", 1, 193),
   new hrefList("slide0194.htm", 1, 194),
   new hrefList("slide0195.htm", 1, 195),
   new hrefList("slide0196.htm", 1, 196),
   new hrefList("slide0197.htm", 1, 197),
   new hrefList("slide0198.htm", 1, 198),
   new hrefList("slide0199.htm", 1, 199),
   new hrefList("slide0200.htm", 1, 200),
   new hrefList("slide0201.htm", 1, 201),
   new hrefList("slide0202.htm", 1, 202),
   new hrefList("slide0203.htm", 1, 203),
   new hrefList("slide0204.htm", 1, 204),
   new hrefList("slide0205.htm", 1, 205),
   new hrefList("slide0206.htm", 1, 206),
   new hrefList("slide0207.htm", 1, 207),
   new hrefList("slide0208.htm", 1, 208),
   new hrefList("slide0209.htm", 1, 209),
   new hrefList("slide0210.htm", 1, 210),
   new hrefList("slide0211.htm", 1, 211),
   new hrefList("slide0212.htm", 1, 212),
   new hrefList("slide0213.htm", 1, 213),
   new hrefList("slide0214.htm", 1, 214),
   new hrefList("slide0215.htm", 1, 215),
   new hrefList("slide0216.htm", 1, 216),
   new hrefList("slide0217.htm", 1, 217),
   new hrefList("slide0218.htm", 1, 218),
   new hrefList("slide0219.htm", 1, 219),
   new hrefList("slide0220.htm", 1, 220),
   new hrefList("slide0221.htm", 1, 221),
   new hrefList("slide0222.htm", 1, 222),
   new hrefList("slide0223.htm", 1, 223),
   new hrefList("slide0224.htm", 1, 224),
   new hrefList("slide0225.htm", 1, 225),
   new hrefList("slide0226.htm", 1, 226),
   new hrefList("slide0227.htm", 1, 227),
   new hrefList("slide0228.htm", 1, 228),
   new hrefList("slide0229.htm", 1, 229),
   new hrefList("slide0230.htm", 1, 230),
   new hrefList("slide0231.htm", 1, 231),
   new hrefList("slide0232.htm", 1, 232),
   new hrefList("slide0233.htm", 1, 233),
   new hrefList("slide0234.htm", 1, 234),
   new hrefList("slide0235.htm", 1, 235),
   new hrefList("slide0236.htm", 1, 236),
   new hrefList("slide0237.htm", 1, 237),
   new hrefList("slide0238.htm", 1, 238),
   new hrefList("slide0239.htm", 1, 239),
   new hrefList("slide0240.htm", 1, 240),
   new hrefList("slide0241.htm", 1, 241),
   new hrefList("slide0242.htm", 1, 242),
   new hrefList("slide0243.htm", 1, 243),
   new hrefList("slide0244.htm", 1, 244),
   new hrefList("slide0245.htm", 1, 245),
   new hrefList("slide0246.htm", 1, 246),
   new hrefList("slide0247.htm", 1, 247),
   new hrefList("slide0248.htm", 1, 248),
   new hrefList("slide0249.htm", 1, 249),
   new hrefList("slide0250.htm", 1, 250),
   new hrefList("slide0251.htm", 1, 251),
   new hrefList("slide0252.htm", 1, 252),
   new hrefList("slide0253.htm", 1, 253),
   new hrefList("slide0254.htm", 1, 254),
   new hrefList("slide0255.htm", 1, 255),
   new hrefList("slide0256.htm", 1, 256),
   new hrefList("slide0257.htm", 1, 257),
   new hrefList("slide0258.htm", 1, 258),
   new hrefList("slide0259.htm", 1, 259),
   new hrefList("slide0260.htm", 1, 260),
   new hrefList("slide0261.htm", 1, 261),
   new hrefList("slide0262.htm", 1, 262),
   new hrefList("slide0263.htm", 1, 263),
   new hrefList("slide0264.htm", 1, 264),
   new hrefList("slide0265.htm", 1, 265),
   new hrefList("slide0266.htm", 1, 266),
   new hrefList("slide0267.htm", 1, 267),
   new hrefList("slide0268.htm", 1, 268),
   new hrefList("slide0269.htm", 1, 269),
   new hrefList("slide0270.htm", 1, 270),
   new hrefList("slide0271.htm", 1, 271),
   new hrefList("slide0272.htm", 1, 272),
   new hrefList("slide0273.htm", 1, 273),
   new hrefList("slide0274.htm", 1, 274),
   new hrefList("slide0275.htm", 1, 275),
   new hrefList("slide0276.htm", 1, 276),
   new hrefList("slide0277.htm", 1, 277),
   new hrefList("slide0278.htm", 1, 278),
   new hrefList("slide0279.htm", 1, 279),
   new hrefList("slide0280.htm", 1, 280),
   new hrefList("slide0281.htm", 1, 281),
   new hrefList("slide0282.htm", 1, 282),
   new hrefList("slide0283.htm", 1, 283),
   new hrefList("slide0284.htm", 1, 284),
   new hrefList("slide0285.htm", 1, 285),
   new hrefList("slide0286.htm", 1, 286),
   new hrefList("slide0287.htm", 1, 287),
   new hrefList("slide0288.htm", 1, 288),
   new hrefList("slide0289.htm", 1, 289),
   new hrefList("slide0290.htm", 1, 290),
   new hrefList("slide0291.htm", 1, 291),
   new hrefList("slide0292.htm", 1, 292),
   new hrefList("slide0293.htm", 1, 293),
   new hrefList("slide0294.htm", 1, 294),
   new hrefList("slide0295.htm", 1, 295),
   new hrefList("slide0296.htm", 1, 296),
   new hrefList("slide0297.htm", 1, 297),
   new hrefList("slide0298.htm", 1, 298),
   new hrefList("slide0299.htm", 1, 299),
   new hrefList("slide0300.htm", 1, 300),
   new hrefList("slide0301.htm", 1, 301),
   new hrefList("slide0302.htm", 1, 302),
   new hrefList("slide0303.htm", 1, 303),
   new hrefList("slide0304.htm", 1, 304),
   new hrefList("slide0305.htm", 1, 305),
   new hrefList("slide0306.htm", 1, 306),
   new hrefList("slide0307.htm", 1, 307),
   new hrefList("slide0308.htm", 1, 308),
   new hrefList("slide0309.htm", 1, 309),
   new hrefList("slide0310.htm", 1, 310),
   new hrefList("slide0311.htm", 1, 311),
   new hrefList("slide0312.htm", 1, 312),
   new hrefList("slide0313.htm", 1, 313),
   new hrefList("slide0314.htm", 1, 314),
   new hrefList("slide0315.htm", 1, 315),
   new hrefList("slide0316.htm", 1, 316),
   new hrefList("slide0317.htm", 1, 317),
   new hrefList("slide0318.htm", 1, 318),
   new hrefList("slide0319.htm", 1, 319),
   new hrefList("slide0320.htm", 1, 320),
   new hrefList("slide0321.htm", 1, 321),
   new hrefList("slide0322.htm", 1, 322),
   new hrefList("slide0323.htm", 1, 323),
   new hrefList("slide0324.htm", 1, 324),
   new hrefList("slide0325.htm", 1, 325),
   new hrefList("slide0326.htm", 1, 326),
   new hrefList("slide0327.htm", 1, 327),
   new hrefList("slide0328.htm", 1, 328),
   new hrefList("slide0329.htm", 1, 329),
   new hrefList("slide0330.htm", 1, 330),
   new hrefList("slide0331.htm", 1, 331),
   new hrefList("slide0332.htm", 1, 332),
   new hrefList("slide0333.htm", 1, 333),
   new hrefList("slide0334.htm", 1, 334),
   new hrefList("slide0335.htm", 1, 335),
   new hrefList("slide0336.htm", 1, 336),
   new hrefList("slide0337.htm", 1, 337),
   new hrefList("slide0338.htm", 1, 338),
   new hrefList("slide0339.htm", 1, 339),
   new hrefList("slide0340.htm", 1, 340),
   new hrefList("slide0341.htm", 1, 341),
   new hrefList("slide0342.htm", 1, 342),
   new hrefList("slide0343.htm", 1, 343),
   new hrefList("slide0344.htm", 1, 344),
   new hrefList("slide0345.htm", 1, 345),
   new hrefList("slide0346.htm", 1, 346),
   new hrefList("slide0347.htm", 1, 347),
   new hrefList("slide0348.htm", 1, 348),
   new hrefList("slide0349.htm", 1, 349),
   new hrefList("slide0350.htm", 1, 350),
   new hrefList("slide0351.htm", 1, 351),
   new hrefList("slide0352.htm", 1, 352),
   new hrefList("slide0353.htm", 1, 353),
   new hrefList("slide0354.htm", 1, 354),
   new hrefList("slide0355.htm", 1, 355),
   new hrefList("slide0356.htm", 1, 356),
   new hrefList("slide0357.htm", 1, 357),
   new hrefList("slide0358.htm", 1, 358),
   new hrefList("slide0359.htm", 1, 359),
   new hrefList("slide0360.htm", 1, 360),
   new hrefList("slide0361.htm", 1, 361),
   new hrefList("slide0362.htm", 1, 362),
   new hrefList("slide0363.htm", 1, 363),
   new hrefList("slide0364.htm", 1, 364),
   new hrefList("slide0365.htm", 1, 365),
   new hrefList("slide0366.htm", 1, 366),
   new hrefList("slide0367.htm", 1, 367),
   new hrefList("slide0368.htm", 1, 368),
   new hrefList("slide0369.htm", 1, 369),
   new hrefList("slide0370.htm", 1, 370),
   new hrefList("slide0371.htm", 1, 371)
);

function ImgBtn( oId,bId,w,action )
{
	var t=this
	t.Perform    = _IBP
	t.SetActive  = _IBSetA
	t.SetInactive= _IBSetI
	t.SetPressed = _IBSetP
	t.SetDisabled= _IBSetD
	t.Enabled    = _IBSetE
	t.ChangeIcon = null
	t.UserAction = action
	t.ChgState   = _IBUI
	t.mObjId   = oId
	t.mBorderId= bId
	t.mWidth   = w
	t.mIsOn    = t.mCurState = 0
}
function _IBSetA()
{
	if( this.mIsOn ) {
		obj=this.ChgState( gHiliteClr,gShadowClr,2 )
		obj.style.posTop=0
	}
}
function _IBSetI()
{
	if( this.mIsOn ) {
		obj=this.ChgState( gFaceClr,gFaceClr,1 )
		obj.style.posTop=0 
	}
}
function _IBSetP()
{
	if( this.mIsOn ) {
		obj=this.ChgState( gShadowClr,gHiliteClr,2 )
		obj.style.posLeft+=1; obj.style.posTop+=1
	}
}
function _IBSetD()
{  
	obj=this.ChgState( gFaceClr,gFaceClr,0 )
	obj.style.posTop=0 
}
function _IBSetE( state )
{
	var t=this
	GetObj( t.mBorderId ).style.visibility="visible"
	if( state != t.mIsOn ) {
		t.mIsOn=state
		if( state )
			t.SetInactive()
		else
			t.SetDisabled()
	}
}
function _IBP()
{
	var t=this
	if( t.mIsOn ) {
		if( t.UserAction != null )
			t.UserAction()
		if( t.ChangeIcon ) {
			obj=GetObj(t.mObjId)
			if( t.ChangeIcon() )
				obj.style.posLeft=obj.style.posLeft+(t.mCurState-4)*t.mWidth
			else
				obj.style.posLeft=obj.style.posLeft+(t.mCurState-0)*t.mWidth
		}
		t.SetActive()
	}  
}
function _IBUI( clr1,clr2,nextState )
{
	var t=this
	SetBorder( GetObj( t.mBorderId ),clr1,clr2 )
	obj=GetObj( t.mObjId )
	obj.style.posLeft=obj.style.posLeft+(t.mCurState-nextState)*t.mWidth-obj.style.posTop
	t.mCurState=nextState
	return obj
}
function TxtBtn( oId,oeId,action,chkState )
{
	var t=this
	t.Perform    = _TBP
	t.SetActive  = _TBSetA
	t.SetInactive= _TBSetI
	t.SetPressed = _TBSetP
	t.SetDisabled= _TBSetD
	t.SetEnabled = _TBSetE
	t.GetState   = chkState
	t.UserAction = action
	t.ChgState   = _TBUI
	t.mObjId      = oId
	t.m_elementsId= oeId
	t.mIsOn       = 1
}
function _TBSetA()
{
	var t=this
	if( t.mIsOn && !t.GetState() )
		t.ChgState( gHiliteClr,gShadowClr,0,0 )
}
function _TBSetI()
{
	var t=this
	if( t.mIsOn && !t.GetState() )
		t.ChgState( gFaceClr,gFaceClr,0,0 )
}
function _TBSetP()
{
	if( this.mIsOn )
		this.ChgState( gShadowClr,gHiliteClr,1,1 )
}
function _TBSetD()
{   
	this.ChgState( gFaceClr,gFaceClr,0,0 )
	this.mIsOn = 0
}
function _TBSetE()
{
	var t=this
	if( !t.GetState() )
		t.ChgState( gFaceClr,gFaceClr,0,0 )
	else
		t.ChgState( gShadowClr,gHiliteClr,1,1 )
	t.mIsOn = 1
}
function _TBP()
{
	var t=this
	if( t.mIsOn ) { 
		if( t.UserAction != null )
			t.UserAction()
		if( t.GetState() )
			t.SetPressed()
		else
			t.SetActive()
	}  
}
function _TBUI( clr1,clr2,lOffset,tOffset )
{
	SetBorder( GetObj( this.mObjId ),clr1,clr2 )
	Offset( GetObj( this.m_elementsId ),lOffset,tOffset )
}
function GetObj( objId ){ return document.all.item( objId ) }
function Offset( obj, top, left ){ obj.style.top=top; obj.style.left=left }
function SetBorder( obj, upperLeft, lowerRight )
{
	s=obj.style;
	s.borderStyle      = "solid"
	s.borderWidth      = 1 
	s.borderLeftColor  = s.borderTopColor = upperLeft
	s.borderBottomColor= s.borderRightColor = lowerRight
}
function GetBtnObj(){ return gBtnArr[window.event.srcElement.id] }
function BtnOnOver(){ b=GetBtnObj(); if( b != null ) b.SetActive() }
function BtnOnDown(){ b=GetBtnObj(); if( b != null ) b.SetPressed() }
function BtnOnOut(){ b=GetBtnObj(); if( b != null ) b.SetInactive() }
function BtnOnUp()
{
	b=GetBtnObj()
	if( b != null )
		b.Perform()
	else
		Upd()
}
function GetNtsState(){ return parent.gNtsOpen }
function GetOtlState(){ return parent.gOtlOpen }
function GetOtlTxtState(){ return parent.gOtlTxtExp }
function NtsBtnSetFlag( fVal )
{
	s=document.all.item( this.m_flagId ).style
	s.display="none"
	if( fVal )
		s.display=""
	else
		s.display="none"
}

var gHiliteClr="THREEDHIGHLIGHT",gShadowClr="THREEDSHADOW",gFaceClr="THREEDFACE"
var gBtnArr = new Array()
gBtnArr["nb_otl"] = new TxtBtn( "nb_otl","nb_otlElem",parent.ToggleOtlPane,GetOtlState )
gBtnArr["nb_nts"] = new TxtBtn( "nb_nts","nb_ntsElem",parent.ToggleNtsPane,GetNtsState )
gBtnArr["nb_prev"]= new ImgBtn( "nb_prev","nb_prevBorder",30,parent.GoToPrevSld )
gBtnArr["nb_next"]= new ImgBtn( "nb_next","nb_nextBorder",30,parent.GoToNextSld )
gBtnArr["nb_sldshw"]= new ImgBtn( "nb_sldshw","nb_sldshwBorder",18,parent.FullScreen )
gBtnArr["nb_voice"]  = new ImgBtn( "nb_voice","nb_voiceBorder",18,parent.ToggleVNarration )
gBtnArr["nb_otlTxt"]= new ImgBtn( "nb_otlTxt","nb_otlTxtBorder",23,parent.ToggleOtlText )
gBtnArr["nb_nts"].m_flagId= "notes_flag"
gBtnArr["nb_nts"].SetFlag = NtsBtnSetFlag
gBtnArr["nb_otlTxt"].ChangeIcon= GetOtlTxtState
var sNext="Next",sPrev="Previous",sEnd="End Show",sFont="Arial"
function ShowMenu()
{
	BuildMenu();
	var doc=PPTSld.document.body,x=PPTSld.event.clientX+doc.scrollLeft,y=PPTSld.event.clientY+doc.scrollTop

	m = PPTSld.document.all.item("ctxtmenu")
	m.style.pixelLeft=x
	if( (x+m.scrollWidth > doc.clientWidth)&&(x-m.scrollWidth > 0) )
		m.style.pixelLeft=x-m.scrollWidth

	m.style.pixelTop=y
	if( (y+m.scrollHeight > doc.clientHeight)&&(y-m.scrollHeight > 0) )
		m.style.pixelTop=y-m.scrollHeight

	m.style.display=""
}
function _CM()
{
	if( !parent.IsFullScrMode() ) return;
	if(!PPTSld.event.ctrlKey) {
		ShowMenu()
		return false
	} else
		HideMenu()
}
function BuildMenu()
{
	if( PPTSld.document.all.item("ctxtmenu") ) return

	var mObj=CreateItem( PPTSld.document.body )
	mObj.id="ctxtmenu"
	var s=mObj.style
	s.position="absolute"
	s.cursor="default"
	s.width="100px"
	SetCMBorder(mObj,"menu","black")

	var iObj=CreateItem( mObj )
	SetCMBorder( iObj, "threedhighlight","threedshadow" )
	iObj.style.padding=2
	CreateMenuItem( iObj,sNext,M_GoNextSld,M_True )
	CreateMenuItem( iObj,sPrev,M_GoPrevSld,M_HasPrevSld )
	var sObj=CreateItem( iObj )
	SetCMBorder(sObj,"menu","menu")
	var s=sObj.style
	s.borderTopColor="threedshadow"
	s.borderBottomColor="threedhighlight"
	s.height=1
	s.fontSize="0px"
	CreateMenuItem( iObj,sEnd,M_End,M_True )
}
function Highlight() { ChangeClr("activecaption","threedhighlight") }
function Deselect() { ChangeClr("threedface","menutext") }
function Perform()
{
	e=PPTSld.event.srcElement
	if( e.type=="menuitem" && e.IsActive() )
		e.Action()
	else
		PPTSld.event.cancelBubble=true
}
function ChangeClr( bg,clr )
{
	e=PPTSld.event.srcElement
	if( e.type=="menuitem" && e.IsActive() ) {
		e.style.backgroundColor=bg
		e.style.color=clr
	}
}

function M_HasPrevSld() { return( parent.HasPrevSld() ) }
function M_GoNextSld() { if( gIsEndShow ) M_End(); else GoToNextSld() }
function M_GoPrevSld() { if( gIsEndShow ) { history.back(); PPTSld.event.cancelBubble=true; } else GoToPrevSld() }
function M_True() { return true }
function M_End() { window.close( self ) }
function CreateMenuItem( node,text,action,eval )
{
	var e=CreateItem( node )
	e.type="menuitem"
	e.Action=action
	e.IsActive=eval
	e.innerHTML=text

	if( !e.IsActive() )
		e.style.color="threedshadow"
	e.onclick=Perform
	e.onmouseover=Highlight
	e.onmouseout=Deselect
	s=e.style;
	s.fontFamily=sFont
	s.fontSize="8pt"
	s.paddingLeft=2
}
function CreateItem( node )
{
	var elem=PPTSld.document.createElement("DIV")
	node.insertBefore( elem )
	return elem
}
function SetCMBorder( o,ltClr,rbClr )
{
	var s=o.style
	s.backgroundColor="menu"
	s.borderStyle="solid"
	s.borderWidth=1
	s.borderColor=ltClr+" "+rbClr+" "+rbClr+" "+ltClr
}