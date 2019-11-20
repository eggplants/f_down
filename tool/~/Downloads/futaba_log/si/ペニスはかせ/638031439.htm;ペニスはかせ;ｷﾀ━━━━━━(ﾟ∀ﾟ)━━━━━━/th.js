//this script code is cited and edited
//original source: https://tsumanne.net/sa/src/b.0912.js
var Opera= ( navigator.userAgent.indexOf("Opera" ) != -1 );
var MSIE = ( navigator.userAgent.indexOf( "MSIE" ) != -1 ) && !Opera;
var Gecko= ( navigator.userAgent.indexOf("Gecko/") != -1 ) && !Opera;
var Firefox= ( navigator.userAgent.indexOf("Firefox/" ) != -1 );

document.getCookie=function(name)
{

	name += '=';
	var str   = document.cookie + ';';
	var start = str.indexOf(name);
	if( start != -1 ){
		var end = str.indexOf( ';' , start );
		return decodeURI(str.substring( start + name.length, end ));
	}
	return false;
}


var board=window.location.href.match(/sa|si|tj|my|sp/);

//スタイル設定
if(document.head=document.getElementsByTagName('head')[0]){
	var meta=document.head.appendChild(document.createElement('meta'));
	meta.setAttribute('name','viewport');
	meta.setAttribute('content','width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=yes');
	meta=document.head.appendChild(document.createElement('meta'));
	meta.setAttribute('name','format-detection');
	meta.setAttribute('content','telephone=no');
	meta=document.head.appendChild(document.createElement('link'));
	meta.setAttribute('href','./th.css');
	meta.setAttribute('rel','stylesheet');
	if(document.cookie.indexOf('nt=1')!=-1)
	{
		meta=document.head.appendChild(document.createElement('link'));
		meta.setAttribute('href','//tsumanne.net/sa/src/nt.css');
		meta.setAttribute('rel','stylesheet');
	}
}



function beforeOnload(){
	//リンク挿入
	//var p=document.getElementsByTagName('p');
	var p=document.body.insertBefore(document.createElement('p'),document.body.firstChild);
	var a;

	//オートリンク
	var bq=document.getElementsByTagName('blockquote');
	for(var i=0;bq[i];i++){

		//末尾のテキストノードの空白除去
		if(bq[i].lastChild.nodeValue&&bq[i].lastChild.nodeValue[bq[i].lastChild.nodeValue.length-1]==' ')bq[i].lastChild.nodeValue=bq[i].lastChild.nodeValue.substr(0,bq[i].lastChild.nodeValue.length-1);

		for(var j=0;bq[i].childNodes[j];j++){
			var n=bq[i].childNodes[j];
			if(n.nodeType==3)
			{
				//if(!Firefox)
				//{
					//双葉内リンク
					if(n.nodeValue.match(/^http:\/\/[a-zA-Z0-9_-]+\.2chan\.net\/b\/res\/[0-9]+\.htm$/)){
						var a=document.createElement('a');
						a.appendChild(document.createTextNode(n.nodeValue));
						a.href='/url.php?u='+encodeURIComponent(n.nodeValue);
						bq[i].replaceChild(a,n);

					//他のサイト&サッチー
					}else if(n.nodeValue.match(/^https?:\/\/([a-zA-Z0-9_-]+\.)?(2chan\.net|tsumanne\.net|nijibox[0-9]\.com|kazumi386\.org:8801|google\.(co\.jp|com)|wikipedia\.org|youtu\.be|youtube\.com|amazon\.(co\.jp|com)|dlsite\.com)[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+$/)){
						var a=document.createElement('a');
						a.appendChild(document.createTextNode(n.nodeValue));
						a.href=n.nodeValue;
						bq[i].replaceChild(a,n);
					}
				//}
			}
		}
	}


//	if(!Firefox){

		//目的のテキストを含むblockquoteを検索
		function searchTextNode(str){
			var n = document.body.childNodes,hri=false,hrj=false;

			var getTextNode2=function(n,str){
				for(var i=0;n.childNodes[i];i++){
					switch(n.childNodes[i].nodeType){
						case(1):
							var a;
							if(a=getTextNode2(n.childNodes[i],str)) return a;
							break;
						case(3):
							if(n.childNodes[i].nodeValue.indexOf(str)!=-1) return n.childNodes[i];
							break;
					}
				}
				return false;
			}

			for(var i=0;n[i];i++){
				if(n[i].nodeName=='HR'){
					hri=i;
					break;
				}
			}
			if(!hri) return;

			for(var i=hri+1;n[i];i++){
				if(n[i].nodeName=='HR'){
					hrj=i;
					break;
				}
			}
			if(!hrj) hrj=n.length-1;

			var a;
			for(var i=hri+1;i<hrj;i++){
				if(a=getTextNode2(n[i],str)) return a;
			}
		}

		//引用ポップアップ
		var f=document.getElementsByTagName('font');
		for(var i=0;f[i];i++){
			if(f[i].getAttribute('color')=='#789922'){
				f[i].pop=function(){
					if(window.clientY&&window.clientY){
						var tn;
						if(!this.quote){
							if(tn=searchTextNode(this.firstChild.nodeValue.replace(/^>/,''))){
								if(tn==this.firstChild){
									this.onclick=function(){}
								}else{
									if(tn.parentNode.nodeName!='FONT'){
										if(tn.parentNode.parentNode.nodeName=='TD'){
											this.quote=tn.parentNode.parentNode.parentNode.parentNode.parentNode.cloneNode(true);
											this.quote.style.position='absolute';
											this.quote.style.top=window.clientY-5+'px';
											this.quote.style.left=window.clientX-5+'px';
											this.quote.style.border="solid 1px red";
											this.quote.style.backgroundColor="#FFE";
											this.quote.parent=this;
											this.quote.onclick=function(){
												this.parent.quote=false;
												document.body.removeChild(this);
											}
											document.body.appendChild(this.quote);
										}else{
											this.quote=document.createElement('div');
											this.quote.appendChild(tn.parentNode.cloneNode(true));
											this.quote.style.position='absolute';
											this.quote.style.top=window.clientY-5+'px';
											this.quote.style.left=window.clientX-5+'px';
											this.quote.style.border="solid 1px red";
											this.quote.style.backgroundColor="#FFE";
											this.quote.parent=this;
											this.quote.onclick=function(){
												this.parent.quote=false;
												document.body.removeChild(this);
											}
											document.body.appendChild(this.quote);
										}
									}
								}
							}
						}
					}
				}
				f[i].onclick=f[i].pop;
			}
		}
//	}


	//クリック画像挿入
	var a=Firefox ? (document.getElementById('attachment')?document.getElementById('attachment').getElementsByTagName('a'):new Array()) : document.getElementsByTagName('a');
	for(var i=0;a[i];i++){
		if(a[i].parentNode.nodeName=='FONT'){
			a[i].onmouseover=function(){
				if(this.parentNode.pop) this.parentNode.onclick=function(){};
			}
			a[i].onmouseout=function(){
				if(this.parentNode.pop) this.parentNode.onclick=this.parentNode.pop;
			}
		}
		if(a[i].href.match(/.(png|gif|jpe?g|bmp)$/,'i')){


			//time
			if(a[i].parentNode.nodeName.toUpperCase()=='TD'){
				a[i].onclick=function(){
					var bq=this.parentNode.getElementsByTagName('blockquote');
					if(bq&&bq[0]){
						var img=document.createElement('a');
						img.href=this.href;
						bq[0].insertBefore(img,bq[0].firstChild);
						img=img.appendChild(document.createElement('img'));
						img.src=this.href;
						img.setAttribute('alt',this.getAttribute('href'));
						//img.style.maxWidth='250px';
						//img.style.maxHeight='250px';
						this.onclick=function(){};
						return false;
					}
				}

			}else if(a[i].firstChild.nodeName.toUpperCase()!='IMG'){
				a[i].onclick=function(){
					var img=document.createElement('img');
					img.src=this.href;
					img.setAttribute('alt',this.getAttribute('href'));
					//img.style.maxWidth='250px';
					//img.style.maxHeight='250px';
					this.replaceChild(img,this.firstChild);
					this.onclick=function(){};
					return false;
				}
			}

		}else if(a[i].href.match(/mailto:.*/)){
			a[i].style.textDecoration='none';
			a[i].nextSibling.nodeValue=a[i].firstChild.nodeValue+a[i].nextSibling.nodeValue;
			a[i].firstChild.nodeValue='['+decodeURI(a[i].href).replace(/^mailto:/,'')+'] ';
			if(m=a[i].href.match(/mailto:.*((http|ftm|mms):\/\/.*)/)){
				a[i].href=m[1].match(/^http:\/\/[a-zA-Z0-9_-]+\.2chan\.net\/b\/res\/[0-9]+\.htm$/)?'/url.php?'+encodeURIComponent(m[1]):m[1];
			}
		}
	}

	a=document.getElementsByTagName('p')[0].getElementsByTagName('a');

	var ck=document.getCookie('LT');
	if(ck)
	{
		var js=document.createElement('script');
		js.setAttribute('type','text/javascript');
		js.setAttribute('src','../../../../../hit.php/'+ck);
		document.body.appendChild(js);
	}
}
