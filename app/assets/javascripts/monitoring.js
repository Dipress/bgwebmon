function ErrorsAjax(ul,lid){
	this.ul = $(ul)
	this.lid = lid
}

ErrorsAjax.prototype.Request = function(){
	ea = new ErrorsAjax(this.ul, this.lid);
	$.ajax({
		url : '/errorlist/'+this.lid,
		dataType: "json"
	}).done(function(data){
		ea.PutErrors(data);
	});
	$(this.ul).html("");
}

ErrorsAjax.prototype.CodToString = function(code){
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

ErrorsAjax.prototype.NiceTime = function(time){
	time = time.replace(new RegExp("T",'g')," ");
	time = time.replace(new RegExp("Z",'g')," ");
	return time;
}

ErrorsAjax.prototype.PutErrors = function(data){
	var ul = this.ul,
		ea = this;
	$(ul).prepend("</ul>");
	$.each(data, function(index,val){
		$(ul).prepend("<li class=\"error\">"+ea.NiceTime(val.dt)+" - "+ea.CodToString(val.error_code)+"</li>");
	});
	$(ul).prepend("<ul>");
	console.log($(ul));
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
	$(this.pbackground).css({'height':$('body').height()});
	this.Center();
}

Popup.prototype.Center = function(){
	$(this.pscreen).css({'margin-left':this.GetMargW(),'margin-top':this.GetMargH()});
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
	$('a').on('click', function(e){
		e.preventDefault();
		popup.ToggleIt();
		ea = new ErrorsAjax($('div#popupcontent'), $(this).attr('lid'));
		ea.Request();
	});
	$('div#popupclose').on('click', function(){
		popup.ToggleIt();
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