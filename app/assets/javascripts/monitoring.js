$(function(){
		$('li.show').on('click', function(){
			if($(this).find('ul').attr('class')==='showed')
			{$(this).find('ul').hide().removeAttr('class');}
			else{$('ul.showed').removeAttr('class').hide();
			$(this).find('ul').show().addClass('showed');}
		});
});