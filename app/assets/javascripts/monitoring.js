function AjaxReq(ul,lid){
	this.ul = $(ul)
	this.lid = lid
}

AjaxReq.prototype.ERequest = function(){
	ea = new AjaxReq(this.ul, this.lid);
	$.ajax({
		url : '/errorlist/'+this.lid,
		dataType: "json"
	}).done(function(data){
		ea.PutErrors(data);
	});
	$(this.ul).html("");
	popup.Resize();
}

AjaxReq.prototype.PRequest = function(){
	ea = new AjaxReq(this.ul, this.lid);
	$.ajax({
		url : '/payments/'+this.lid,
		dataType: "json"
	}).done(function(data){
		ea.PutPays(data);
	});
	$(this.ul).html("");
	popup.Resize();
}

AjaxReq.prototype.GRequest = function(hour){
	ea = new AjaxReq(this.ul, this.lid);
	var time = hour;
	$(this.ul).html("<ul class=\"gtime\">"+
	"<li class=\"hourli\" lid=\""+this.lid+"\" time=\"6\">6 часов</li>"+
	"<li class=\"hourli\" lid=\""+this.lid+"\" time=\"24\">1 день</li>"+
	"<li class=\"hourli\" lid=\""+this.lid+"\" time=\"72\">3 дня</li>"+
	"<li class=\"hourli\" lid=\""+this.lid+"\" time=\"168\">1 неделя</li>"+
	"<li class=\"hourli\" lid=\""+this.lid+"\" time=\"336\">2 недели</li>"+
	"</ul>");

	$.each($('li.hourli'), function(i,v){
		$(v).click(function(){
			ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'));
			ea.GRequest($(this).attr('time'));
		});
	});

	$.ajax({
		url : '/graph/'+this.lid+'/'+time,
		dataType : "text"
	}).done(function(data){
		$(ea.ul).append("<img src=\"" + data + "\"/>");
	});
}

AjaxReq.prototype.TRequest = function(cid){
	ea = new AjaxReq(this.ul, this.lid);
	$(this.ul).html("");
	$.ajax({
		url : '/tp/' + this.lid,
		dataType : "json"
	}).done(function(data){
		$.each(data[0].tplans, function(index, value){
			$(ea.ul).append("<div>"+value.title+" - "+value.cost+"0грн.</div>");
		});
		$(ea.ul).append("<div>Общая стоимость: "+data[0].allcost+" грн.</div>");
	});
}

AjaxReq.prototype.CodToString = function(code){
	if(code == 2)
		return "Ошибка пароля"
	else if(code == 3)
		return "Тариф не найден"
	else if(code == 4)
		return "Ошибка баланса"
	else if(code == 11)
		return "Цена не найдена"
	else if(code == 18)
		return "REALM запрещен"
	else if(code == 21)
		return "Лимит сессий"
	else if(code == 33)
		return "Договор закрыт"
}

AjaxReq.prototype.PutErrors = function(data){
	var ul = this.ul,
		ea = this;
	if(data != ""){
		$.each(data, function(index,val){
			$(ul).append("<div class=\"error\">"+val.date+" - "+ea.CodToString(val.error_code)+"</div>");
		});
	}
	else{
		$(ul).append("<div class=\"error\">Ошибок нет</div>");	
	}
}

AjaxReq.prototype.PutPays = function(data){
	var ul = this.ul,
		ea = this;
	if(data != ""){
		$.each(data, function(index,val){
			$(ul).prepend("<div class=\"pay\">"+val.date+" - "+val.summa+"грн.   "+val.comment+"</div>");
		});
	}
	else{
		$(ul).prepend("<div class=\"pay\">Платежей нет</div>");	
	}

}

function Popup(popup,wheight,wwidth){
	this.container = $(popup);
	this.pbackground = $(this.container).children('div').eq(0);
	this.pscreen = $(this.container).children('div').eq(1);
	this.wheight = wheight;
	this.wwidth = wwidth;
}

Popup.prototype.ToggleIt = function(){
	$(this.container).toggle();
}

Popup.prototype.Resize = function(){
	$(this.pbackground).css({'height':$('body').height(), 'margin-top':$(window).scrollTop()-28});
	this.Center();
}

Popup.prototype.Center = function(){
	$(this.pscreen).css({'margin-left':this.GetMargW(),'margin-top':this.GetMargH()-28});
}

Popup.prototype.GetMargW = function(){
	return (this.wwidth - this.pscreen.width()+32)/2
}

Popup.prototype.GetMargH = function(){
	return (this.wheight - this.pscreen.height()+32)/2+$(window).scrollTop()
}

function ContentPlacer(contentblock, bodywidth, liwidth) {
	this.contentblock = $(contentblock);
	this.bodywidth = bodywidth;
	this.liwidth = liwidth;

	this.cwidth = 0
}

ContentPlacer.prototype.DWR = function(dividend, divider){
	var remainder = dividend % divider,
		newdividend = (dividend - remainder) / divider
	return newdividend;
}

ContentPlacer.prototype.SetContentWidth = function(){
	var liwidth = this.liwidth+9;
	this.cwidth = this.DWR(this.bodywidth,liwidth) * liwidth;
	this.contentblock.css({'width': this.cwidth});
}

ContentPlacer.prototype.SetMargin = function(){
	var marg = (this.bodywidth - this.cwidth)/2;
	this.contentblock.css({'margin-left':marg+2});
}

$(function(){
	popup = new Popup($('div#popup'),$(window).height(),$(window).width());
	popup.Resize();
	$('a.aerror').on('click', function(e){
		e.preventDefault();
		popup.ToggleIt();
		ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'));
		$('div#popupscreen').css({'width':'400px','height':'400px'});
		popup.Resize();
		ea.ERequest();
	});
	$('a.apays').on('click', function(e){
		e.preventDefault();
		popup.ToggleIt();
		ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'));
		$('div#popupscreen').css({'width':'400px','height':'400px'});
		popup.Resize();
		ea.PRequest();
	});
	$('a.agraph').on('click', function(e){
		e.preventDefault();
		popup.ToggleIt();
			popup = new Popup($('div#popup'),$(window).height(),$(window).width());
		ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'));
		$('div#popupscreen').css({'width':'957px','height':'333px'});
		popup.Resize();
		ea.GRequest(6);
	});
	
	$('div#popupclose').on('click', function(){
		popup.ToggleIt();
	});

	$('a.atariffs').on('click', function(e){
		e.preventDefault();
		popup.ToggleIt();
			popup = new Popup($('div#popup'),$(window).height(),$(window).width());
		ea = new AjaxReq($('div#popupcontent'), $(this).attr('lid'));
		$('div#popupscreen').css({'width':'400px','height':'400px'});
		popup.Resize();
		ea.TRequest();
	});

	var liwidth = $('ul#content').children('li').eq(0).width(),
	bodywidth = $(window).width();

	cplacer = new ContentPlacer($('ul#content'),bodywidth, liwidth);
	cplacer.SetContentWidth();
	cplacer.SetMargin();

	$(window).resize(function(){
		popup.wheight = $(window).height();
		popup.wwidth = $(window).width();
		popup.Resize();

		cplacer.bodywidth = $(window).width();
		cplacer.SetContentWidth();
		cplacer.SetMargin();
	});

	$(window).scroll(function(){
		popup.Resize();
	});
});