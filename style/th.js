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

//�X�^�C���ݒ�
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

//index�����N�ǉ�
function addIndex(ar){
	var p=document.getElementsByTagName('p');
	if(p=p[0]){
		p.appendChild(document.createElement('br'));
		p.appendChild(document.createTextNode('index:'));
		for(var i=0;ar[i];i++){
			var a=p.appendChild(document.createElement('a'));
			/*if(document.referrer.indexOf('index2.php')!=-1)
			{
				a.href='//tsumanne.net/'+board+'/index2.php/'+encodeURIComponent(ar[i]);
			}
			else
			{*/
				a.href='/'+board+'/'+encodeURIComponent(ar[i]);
			//}
			a.appendChild(document.createTextNode(ar[i]));
			p.appendChild(document.createTextNode(' '));
		}
	}
	if(ar.length)
	{
		var amz = document.getElementsByTagName('hr')
		amz=document.body.insertBefore(document.createElement('div'),amz[amz.length-1].nextSibling);
		amz.setAttribute('id','amazon');
		amz.id='amazon';
		amz.appendChild(document.createElement('ul'));

		var script = document.createElement('script');
		script.setAttribute('src','/amz/json.php?cb=insertAmazon&kw='+encodeURIComponent(ar[Math.floor( Math.random() * ar.length )]));
		script.setAttribute('type','text/javascript');
		document.body.appendChild(script);
	}
}

//del form
function createDelForm(){
	if(document.getElementById('delform')) return;
	var sub = [
		'�����E���J�E���_�ʑ�',
		'�����E���E',
		'�l���E�v���C�o�V�[',
		'���܂Ƃ��E�X�g�[�J�[',
		'�N�Q�E�W�Q',
		'�f�}�E�s��',
		'�r�炵�E�����点�E�����̌�',
		'�����|���m�摜(�R��)',
		'�����摜�E���C���摜(�R��)',
		'�����O�o���摜'
	];
	var form=document.body.insertBefore(document.createElement('form'),document.getElementsByTagName('hr')[0]);
	form.action='/'+board+'/del.php';
	form.method='post';
	form.id='delform';
	form.setAttribute('accept-charset','utf-8');
	form=form.appendChild(document.createElement('fieldset'));
	form.legend=form.appendChild(document.createElement('legend'));
	form.legend.appendChild(document.createTextNode('�s�K�؃X���b�h�̕�'));
	var ul=form.appendChild(document.createElement('ul'));
	
	var m=window.location.href.match(/[0-9]+\/[0-9]+\/[0-9]+\/([0-9]+)/);

	form._id=document.createElement('input');
	form._id.type='hidden';
	form._id.name='_id';
	form._id.value=m[1];
	form.appendChild(form._id);
	
	form.send=document.createElement('input');
	form.send.type='submit';
	form.send.name='submit';
	form.send.value='��';
	form.send.disabled=true;
	form.appendChild(form.send);

	form.close=document.createElement('input');
	form.close.type='button';
	form.close.value='����';
	form.close.onclick=function(){
		this.form.parentNode.removeChild(this.form);
	}
	form.appendChild(form.close);

	for(var i=0;sub[i];i++){
		var li=ul.appendChild(document.createElement('li'));
		li=li.appendChild(document.createElement('label'));
		input=document.createElement('input');
		input.type='radio';
		input.name='sub';
		input.value=i;
		input.onclick=function(){form.send.disabled=false;}
		li.appendChild(input);
		li.appendChild(document.createTextNode(sub[i]));
	}
}

function insertAmazon(obj)
{
	obj.sort(function (a,b)
	{
		{
			var i = Math.ceil(Math.random()*100)%2;
			if(i == 0)
			{
				return -1;
			}
			else
			{
				return 1;
			}
		}
	});
	obj.length=4;
	var ul=document.getElementById('amazon').getElementsByTagName('ul')[0];
	for(var i=0;obj[i];i++)
	{
		var li=ul.appendChild(document.createElement('li'));
		var a=li.appendChild(document.createElement('a'));
		a.setAttribute('href',obj[i].Url);
		if(obj[i].SmallImage)
		{
			var img=document.createElement('img');
			img.setAttribute('src',obj[i].SmallImage);
			img.setAttribute('width',obj[i].SmallImageWidth);
			img.setAttribute('height',obj[i].SmallImageHeight);
			img.setAttribute('alt','');
			a.appendChild(img);
		}
		a.appendChild(document.createTextNode(obj[i].Title));
		li.appendChild(document.createTextNode(obj[i].Price));
	}
}

function goButtom()
{
	document.body.scrollTop = document.body.scrollHeight;
}


function beforeOnload(){
	//�����N�}��
	//var p=document.getElementsByTagName('p');
	var p=document.body.insertBefore(document.createElement('p'),document.body.firstChild);
	var a;
	//if(p=p[0]){

		p.insertBefore(document.createTextNode('] '),p.firstChild);
		a=p.insertBefore(document.createElement('a'),p.firstChild);
		a.appendChild(document.createTextNode('�u�v�b�`�['));
		a.href="../../../../../";
		/*if(document.referrer.indexOf('index2.php')!=-1)
		{
			a.href+='index2.php/';
		}*/
		p.insertBefore(document.createTextNode('['),p.firstChild);

		var url=window.location.href.split('/');
		p.insertBefore(document.createTextNode('] '),p.firstChild);
		a=p.insertBefore(document.createElement('a'),p.firstChild);
		a.appendChild(document.createTextNode('mht�ŕۑ�'));
		a.href='/'+board+'/mht.php?id='+url[8];
		p.insertBefore(document.createTextNode('['),p.firstChild);
		
		p.insertBefore(document.createTextNode('] '),p.firstChild);
		a=p.insertBefore(document.createElement('a'),p.firstChild);
		a.appendChild(document.createTextNode('del'));
		a.href="javascript:createDelForm()";
		p.insertBefore(document.createTextNode('['),p.firstChild);
		
		a=document.createElement('a');
		a.href='javascript:goButtom()';
		a.appendChild(document.createTextNode('��'));
		p.appendChild(a);
	//}

	//�I�[�g�����N
	var bq=document.getElementsByTagName('blockquote');
	for(var i=0;bq[i];i++){

		//�����̃e�L�X�g�m�[�h�̋󔒏���
		if(bq[i].lastChild.nodeValue&&bq[i].lastChild.nodeValue[bq[i].lastChild.nodeValue.length-1]==' ')bq[i].lastChild.nodeValue=bq[i].lastChild.nodeValue.substr(0,bq[i].lastChild.nodeValue.length-1);

		for(var j=0;bq[i].childNodes[j];j++){
			var n=bq[i].childNodes[j];
			if(n.nodeType==3)
			{
				//if(!Firefox)
				//{
					//�o�t�������N
					if(n.nodeValue.match(/^http:\/\/[a-zA-Z0-9_-]+\.2chan\.net\/b\/res\/[0-9]+\.htm$/)){
						var a=document.createElement('a');
						a.appendChild(document.createTextNode(n.nodeValue));
						a.href='/url.php?u='+encodeURIComponent(n.nodeValue);
						bq[i].replaceChild(a,n);
						
					//���̃T�C�g&�T�b�`�[
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

		//�ړI�̃e�L�X�g���܂�blockquote������
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

		//���p�|�b�v�A�b�v
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


	//�N���b�N�摜�}��
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
/*
	var d=new Date();
	if(d.getDate()==1)
	{
		var bq=document.getElementsByTagName('blockquote');
		for(var i=0; bq[i];i++)
		{
			for(var j=0;bq[i].childNodes[j];j++)
			{
				if(bq[i].childNodes[j].nodeType==3)
				{
					var tex=[
						'�_��[���^','�_���[�̂��[�^','�_�������[���^','�_�p�b�J�[���^'
					];
					bq[i].childNodes[j].nodeValue=bq[i].childNodes[j].nodeValue.replace(/�[/g,tex[Math.floor( Math.random() * tex.length ) ]);
					bq[i].childNodes[j].nodeValue=bq[i].childNodes[j].nodeValue.replace(/��$/g,'�Ȃ̂ł�');
					bq[i].childNodes[j].nodeValue=bq[i].childNodes[j].nodeValue.replace(/��/g,'�݂��');
					bq[i].childNodes[j].nodeValue=bq[i].childNodes[j].nodeValue.replace(/�~/g,'�~���~');
					tex=['�ւ�Ȃ́[�ւ�Ȃ́[','���傢�ł��@���傢�Ȃ̂ł�','�ǂ��ɂ���́`�Ȃ��܂����킽�`���̂����܁`�A�������`�Ă��������`','���E�̊�@�Ȃ̂�!','�܂��Ă�����','�͂�?','�Ȃ񂾂�c�����������Ă�!','�܁A���킮�قǂł��Ȃ����c','�삠�������������[���ǂ����炫���̂�?','�ӂ��[','�ȁJ��J�����J�܁J���J��J�I���J���J�́J��J�[!','�܂񂼂�','����������E�E���','�y�b�I','�͂����͂��������̂ł�','','','',''];
				}
			}
			bq[i].appendChild(document.createElement('br'));
			bq[i].appendChild(document.createTextNode(tex[Math.floor( Math.random() * tex.length )]));
		}
	}*/
}
