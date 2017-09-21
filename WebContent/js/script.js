					jssor_1_slider_init = function() {

						var jssor_1_SlideoTransitions = [
						  [{b:900,d:2000,x:-379,e:{x:7}}],
						  [{b:900,d:2000,x:-379,e:{x:7}}],
						  [{b:-1,d:1,o:-1,sX:2,sY:2},{b:0,d:900,x:-171,y:-341,o:1,sX:-2,sY:-2,e:{x:3,y:3,sX:3,sY:3}},{b:900,d:1600,x:-283,o:-1,e:{x:16}}]
						];

						var jssor_1_options = {
						  $AutoPlay: 1,
						  $SlideDuration: 800,
						  $SlideEasing: $Jease$.$OutQuint,
						  $CaptionSliderOptions: {
							$Class: $JssorCaptionSlideo$,
							$Transitions: jssor_1_SlideoTransitions
						  },
						  $ArrowNavigatorOptions: {
							$Class: $JssorArrowNavigator$
						  },
						  $BulletNavigatorOptions: {
							$Class: $JssorBulletNavigator$
						  }
						};

						var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

						/*#region responsive code begin*/
						/*remove responsive code if you don't want the slider scales while window resizing*/
						function ScaleSlider() {
							var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
							if (refSize) {
								refSize = Math.min(refSize, 3000);
								jssor_1_slider.$ScaleWidth(refSize);
							}
							else {
								window.setTimeout(ScaleSlider, 30);
							}
						}
						ScaleSlider();
						$Jssor$.$AddEvent(window, "load", ScaleSlider);
						$Jssor$.$AddEvent(window, "resize", ScaleSlider);
						$Jssor$.$AddEvent(window, "orientationchange", ScaleSlider);
						/*#endregion responsive code end*/
					};
					
					var number_format = function (number, decimals, dec_point, thousands_sep) {
					    var n = number, prec = decimals;

					    var toFixedFix = function (n,prec) {
					        var k = Math.pow(10,prec);
					        return (Math.round(n*k)/k).toString();
					    };

					    n = !isFinite(+n) ? 0 : +n;
					    prec = !isFinite(+prec) ? 0 : Math.abs(prec);
					    var sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep;
					    var dec = (typeof dec_point === 'undefined') ? '.' : dec_point;

					    var s = (prec > 0) ? toFixedFix(n, prec) : toFixedFix(Math.round(n), prec); 
					    //fix for IE parseFloat(0.55).toFixed(0) = 0;

					    var abs = toFixedFix(Math.abs(n), prec);
					    var _, i;

					    if (abs >= 1000) {
					        _ = abs.split(/\D/);
					        i = _[0].length % 3 || 3;

					        _[0] = s.slice(0,i + (n < 0)) +
					               _[0].slice(i).replace(/(\d{3})/g, sep+'$1');
					        s = _.join(dec);
					    } else {
					        s = s.replace('.', dec);
					    }

					    var decPos = s.indexOf(dec);
					    if (prec >= 1 && decPos !== -1 && (s.length-decPos-1) < prec) {
					        s += new Array(prec-(s.length-decPos-1)).join(0)+'0';
					    }
					    else if (prec >= 1 && decPos === -1) {
					        s += dec+new Array(prec).join(0)+'0';
					    }
					    return s; 
					}