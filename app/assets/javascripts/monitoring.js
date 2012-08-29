function Placer (contentblock,bodywidth, liwidth) {
	this.contentblock = $(contentblock);
	this.bodywidth = bodywidth;
	this.liwidth = liwidth;

	this.cwidth = 0
}

Placer.prototype.DWR = function(dividend, divider){
	var remainder = dividend % divider,
		newdividend = (dividend - remainder) / divider
	return newdividend;
}

Placer.prototype.SetContentWidth = function(){
	var liwidth = this.liwidth + 32;
	this.cwidth = this.DWR(this.bodywidth,liwidth) * (liwidth);
	this.contentblock.css({'width': this.cwidth});
}

Placer.prototype.SetMargin = function(){
	var marg = (this.bodywidth - this.cwidth)/2;
	this.contentblock.css({'margin-left':marg});
}

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
	$(ul).html("");
	$.each(data, function(index,val){
		$(ul).prepend("<li class=\"error\">"+ea.NiceTime(val.dt)+" - "+ea.CodToString(val.error_code)+"</li>");
	});
}

$(function(){
	var liwidth = $('ul#logins').children('li').eq(0).width(),
		bodywidth = $('body').width();

	placer = new Placer($('ul#logins'),bodywidth, liwidth);
	placer.SetContentWidth();
	placer.SetMargin();

	$(window).resize(function(){
		placer.bodywidth = $('body').width();
		placer.SetContentWidth();
		placer.SetMargin();
	});

	$('li.show').on('click', function(){
		$('div.showed').hide();
		$(this).find('div.showed').toggle(100,function(){
			if($(this).css('display') === 'block'){
				var inpval = $(this).siblings('input').attr('val');
				errorsajax = new ErrorsAjax($(this).find('ul'),inpval);
				errorsajax.Request();
			}
		});
	});
});