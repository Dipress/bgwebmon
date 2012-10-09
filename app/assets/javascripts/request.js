// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

	//$('button#searchplace').on('click', function(e){e.preventDefault();});
	   	function create () {
	        var myMap = new ymaps.Map("requestmap", {
	            center: [44.95125342343973, 34.10235297851568],
	            zoom: 8,
	            behaviors: ['default', 'scrollZoom']
	        });

            myCollection = new ymaps.GeoObjectCollection();

            $('button#searchplace').on('click', function (e) {
            	e.preventDefault();
                var search_query = $('input#street').val();
                ymaps.geocode(search_query, { results: 1 }).then(function (res) {
                	var coords = res.geoObjects.get(0).geometry.getCoordinates();
                	ymaps.geocode(coords).then(function (res) {
	                    var names = [];
	                    res.geoObjects.each(function (obj) {
	                        names.push(obj.properties.get('name'));
	                    });
	                    	//Вставляем данные в инпуты
	                    	//
	                    	$('input#requestfl_adress_connection').val(names.reverse().join(', '));
	                    	$('input#requestfl_latlng_connection').val(coords);
	                    	//
	                    	myMap.balloon.close();
		                    myMap.balloon.open(coords, {
		                        contentHeader: names.reverse().join(', '),
		                        contentBody: [coords[0].toPrecision(6),
		                                	  coords[1].toPrecision(6)].join(', ')
		                    });
                	});
                });
                return false;
            });

            myMap.events.add('click', function (e) {
                var coords = e.get('coordPosition');
                ymaps.geocode(coords).then(function (res) {
                    var names = [];
                    res.geoObjects.each(function (obj) {
                        names.push(obj.properties.get('name'));
                    });
                    	//Вставляем данные в инпуты
                    	//
	                    $('input#requestfl_adress_connection').val(names.reverse().join(', '));
	                    $('input#requestfl_latlng_connection').val(coords);
                    	//
                    	myMap.balloon.close();
	                    myMap.balloon.open(coords, {
	                        contentHeader: names.reverse().join(', '),
	                        contentBody: [coords[0].toPrecision(6),
	                                	  coords[1].toPrecision(6)].join(', ')
	                    });
                });
            });
	    }