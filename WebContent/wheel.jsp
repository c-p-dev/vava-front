<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>WHEEL OF KAYAMANAAAN</title>
        
        <link rel="stylesheet" href="http://textangular.com/dist/textAngular.css" type="text/css">
        
        <style>
            body{text-align:center;}
            #wheel{
              display:inline-block;
              position:relative;
              overflow:hidden;
            }
            #wheel:after{
              content:"";
              background:red;
              border:2px solid white;
              position:absolute;
              top:-7px;
              left:50%;
              width:10px;
              height:10px;
              margin-left:-7px;
              transform: rotate(45deg)
            }
            #canvas{
              color: #0cff15; 
              background-image: url("images/wheel/back.jpg");
              border:1px solid black;
            }
        </style>
        
    	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular-route.js"></script>
		<script src="js/script.js"></script>
    </head>
    <body ng-app = 'vava007'>
    	<div ng-controller = 'spinCtrl'>
    	
	        <canvas id="canvas" width="1200" height="680"></canvas>
	        <br>
	        
	        <div> 
	        	<span> For Testing </span>
	        	<div>
	        		<form id = 'test-wheel-form' ng-submit = 'testCalculateRng()'>
		        		<label> No. of Tickets: </label>
		        		<input type = 'text' ng-model = 'wheel.ticket_num'>
		        		
		        		<label> Win Amount:</label>
		        		<input type = 'text' ng-model = 'wheel.win_amt'>
		        		
		        		<input type = 'submit'>
	        		</form>
	        		
	        		<div id = 'error-msg'>
	        		
	        		</div>
	        	</div>
	        </div>
        </div>
        
        <script type="text/javascript" charset="utf-8">
            function rand(min, max) {
                return Math.random() * (max - min) + min;
            }


            	angular.module("vava007", []);
                
                angular.module("vava007").controller('spinCtrl', function($scope, $http) {
    				$scope.testCalculateRng = function() {
    					
    				    $http.post("WheelServlet?method=3", $scope.wheel)
    						.then(function success(srv_resp){
    							
    							if (0 < srv_resp.data.length) {
    		                        location.reload();
    							}
    							else {
    		            			$('#error-msg').html("Cannot find combination of numbers to match Win amount");
    		            			$('#error-msg').show();
    		            		}
    						}, function failed(srv_resp) {
    							
    						}
    					);
    				    
    				}
    			});
                
            
            
            $(document).ready(function() {
                
                var v1          = 10000;
                var v2          = 20000;
                var v3          = 50000;            
                var v4          = 100000;                      
                var lose        = 0;
                var jpot        = 100;
                
                var inst_ln1 	= "IBET25 회원님들만을 위한 보너스 스핀게임 입니다!!";
                var	inst_ln2 	= "룰렛판 중앙의 'SPIN' 버튼을 눌러 룰렛을 돌리신 후 나온 금액만큼의 금액을";
                var inst_ln3 	= "포인트로 적립해 드립니다!";
                	
                var color       = ['green','red','green','orange', "grey", 'green', "red", 'grey', "indigo", 'grey','green','grey','blue', "grey", 'red', "orange", 'grey'];
                var spinr_val   = [];
                var spinr_lbl   = [];
                var spin_res    = [];
                
                var slices = color.length;
                var sliceDeg = 360/slices;
                var deg = rand(0, 360);
                var speed = 0;
                var slowDownRand = 0;
                var ctx = canvas.getContext('2d');
                var width = canvas.width; // size
                var center = width/2;      // center
                var spinning = false;

                var lock = false;
                var rng = "";
                var cont = new Image();
                var pin = new Image();
                var arrow = new Image();
                var bg_off = new Image();
                var bg_on = new Image();
                var audiobtn = new Image();
                var lyt = 0;
                var lyt_ctr = 0;
                var wheel_x = 780;
                var wheel_y = 350;
                var cont_x = 80;
                var bglights_x = 473 ;
                var bglights_y = 40 ;
                var bglights_height = 612 ;
                var bglights_width = 695 ;
                var result = 0;
                var tickets = 0;
                var total = 0;
                var total_dsp = "0.00";
                var result_dsp = "0.00";
                var multiplier = 1   
                
                
                var audio       = new Audio("sounds/reel.mp3");
                var win         = new Audio("sounds/win.mp3");
                var click       = new Audio("sounds/start_reel.mp3");
                
                cont.src        = 'images/wheel/container.png';
                pin.src         = 'images/wheel/spin-bnt.png';
                arrow.src		= 'images/wheel/arrow-pnt.png';
                bg_off.src      = 'images/wheel/bg_off.png';
                bg_on.src       = 'images/wheel/bg_on.png';
                audiobtn.src    = 'images/wheel/audio.png';
                
                function deg2rad(deg) {
                    return deg * Math.PI/180;
                }

                function drawBg(lit) {
                    
                    if (0 == lit) {
                        ctx.drawImage(bg_off, bglights_x, bglights_y, bglights_height, bglights_width);
                    }
                    else {
                        ctx.drawImage(bg_on, bglights_x, bglights_y, bglights_height, bglights_width);
                    }

                }
                
                function drawSlice(deg, color) {
                    ctx.beginPath();
                    ctx.fillStyle = color;
                    ctx.moveTo(wheel_x, wheel_y);
                    ctx.lineWidth = 6;
                    ctx.lineTo(wheel_x, wheel_y);
                    ctx.arc(wheel_x, wheel_y, ( 450)/2, deg2rad(deg), deg2rad(deg+sliceDeg));                
                    ctx.lineTo(wheel_x,wheel_y);
                    ctx.stroke();
                    ctx.fill();
                }

                function drawText(deg, text) {
                    ctx.save();
                    ctx.translate(wheel_x, wheel_y);
                    ctx.rotate(deg2rad(deg));                
                    ctx.textAlign   = "right";
                    ctx.fillStyle   = "white";
                    ctx.font        = 'bold 15px sans-serif';
                    ctx.fillText(text+"원", 190, 5);
                    ctx.restore();
                }

                function drawImg() {
                    
                    ctx.clearRect(0, 0,500, 500);
                    
                    ctx.beginPath();
                    ctx.arc(780, 350, 240, 0, 2 * Math.PI, false);
                    ctx.fillStyle = '#4593e4';
                    ctx.fill();
                    
                    
                    for(var i=0; i<slices; i++){
                        drawSlice(deg, color[i]);
                        drawText(deg+sliceDeg/2, spinr_lbl[i]);
                        deg += sliceDeg;
                    }
                    
                    //ctx.drawImage(cont, cont_x, 195, 270 , 80); 
                    //ctx.drawImage(cont, cont_x, 285, 340 , 80); 
                    //ctx.drawImage(cont, cont_x, 375, 340 , 80); 
                    ctx.drawImage(audiobtn, 1100, 90, 50 , 50); 
                    //ctx.drawImage(cont, cont_x, 285, 300 , 80); 
                    //ctx.drawImage(cont, cont_x, 375, 200 , 80); 

                    ctx.fillStyle       ="white";
                    
                    ctx.font            = "30px Georgia";
                    ctx.fillText("남은횟수:", 165, 245);
                    ctx.fillText("획득금액:", 165, 335);
                    ctx.fillText("총 획득금액:", 130, 425);
                    
                    ctx.font            = "15px Georgia";
                    ctx.fillText(inst_ln1, 90, 100);
                    ctx.fillText(inst_ln2, 90, 135);
                    ctx.fillText(inst_ln3, 90, 170);
                    
                    /*
                    ctx.fillStyle       ="green";
                    ctx.fillRect(330,215,70,40);
                    ctx.fillRect(310,305,150,40);
                    ctx.fillRect(310,395,150,40);
                    */
                    
                    ctx.fillStyle   = "#FFFFFF";
                    ctx.font        = "20px Georgia";
                    
                    ctx.fillText(tickets, 320, 240);
                    ctx.fillText(result_dsp, 320, 330);
                    ctx.fillText(total_dsp, 320, 420);
                    //drawBg(lyt);
                    ctx.drawImage(pin, 735 , 305 , 90 , 90);
                    ctx.drawImage(arrow, 757 , 110 , 50 , 50);
                }

                function anim() {
                    deg += speed;
                    deg %= 360;

                    /*  Increase Speed  */
                    if ((spinning)
                    && (20 > speed)) {
                        speed = speed + 1 * 0.1;
                    }
                    else {
                        /*  Wait for AJAX calculation of result before setting stopping spin */
                        if (!lock) {
                            
                            $.get('WheelServlet?method=2', function(srv_resp) {
                                rng_idx     = srv_resp.rng_idx;
                                rng_stop    = rand(1.3, 1.8);
                                rng_deg     = ((360 - 90) - (rng_idx * sliceDeg)) + (sliceDeg / rng_stop);
                                
                                if (0 > rng_deg) {
                                    rng_deg = (360 + rng_deg);
                                }
                                
                                spinning    = false;
                            }, 'json');
                            
                            lock        = true;
                            
                        }
                        else if (!spinning){
                        	/* Convert degree to array index	*/
                        	var ai2 = Math.floor(((360 - deg - 90) % 360) / sliceDeg);
                        	
                        	/* Fix negative index	*/
                        	ai2 = (slices+ai2)%slices;
                            
                            /* Decrease Speed   */
                            if (0.777 >= speed) {
                                speed 		= speed;
                                
                                if (Math.floor(deg) == Math.floor(rng_deg)) {
                                    speed = 0;
                                }
                            }
                            else {
                                speed *= 0.977;
                            }
                            
                        }
                        
                        else {
                            /*  Do nothing  */
                        }
                    }
                    
                    /*  Lights Control  */
                    if (lyt_ctr >= 20) {
                        if (0 == lyt) {
                            lyt = 1;
                        }
                        else {
                            lyt = 0;
                        }
                        
                        lyt_ctr = 0;
                    }
                    else {
                        lyt_ctr++;
                    }
                    
                    /*  Stop    */
                    if (0 >= speed) {
                        lyt = 0;                
                        
                        result = spinr_val[ai2] * multiplier
                        audio.pause();
                        audio.currentTime = 0;
                        
                        if (spinr_val[ai2] > 1){
                            win.play();
                            total		+= result;
                            total_dsp	= number_format(total, 2);
                            result_dsp	= number_format(result, 2);
                        }
                        else {
                            total		+= result;
                            total_dsp 	= number_format(total, 2);
                            result_dsp 	= number_format(result, 2);
                        }
                        
                        drawImg();
                        
                        return 1;
                        
                         // Get Array Item from end Degree
                        

                    }
                    
                    drawImg();
                    window.requestAnimationFrame( anim );
                };
                
                
                $.get('WheelServlet?method=1', function(srv_resp) {
                	
                    spinr_val   = srv_resp.spinr_val;
                    spinr_lbl   = srv_resp.spinr_lbl;
                    spin_res    = srv_resp.spin_result;
                    tickets     = srv_resp.ticket_left;
                    drawImg();
                    //drawBg(0);
                }, 'json');
                
                var elem        = document.getElementById('canvas');
                var clkbl_elems = [];
                
                // Add event listener for `click` events.
                elem.addEventListener('click', function(event) {
                    var elemLeft    = elem.offsetLeft;
                    var elemTop     = elem.offsetTop;
                    var context     = elem.getContext('2d');
                    
                    var x = event.pageX - elemLeft;
                    var y = event.pageY - elemTop;
                    
                    clkbl_elems.forEach(function(element) {
                        if (y > element.top && y < element.top + element.height && x > element.left && x < element.left + element.width) {
                        
                            if (0 >= speed) {
                                if ('spin-btn' == element.id) {
                                    if (tickets > 0){
                                        spinning    = true;
                                        lock        = false;
                                        result      = 0;
                                        result_dsp	= "0.00";
                                        
                                        window.requestAnimationFrame( anim );
                                        tickets -= 1;
                                        
                                        drawImg();
                                        click.play();
                                        audio.play();
                                    }
                                    else {  
                                        alert("NO MORE TICKETS");
                                    }
                                }
                                else if ('audiobtn' == element.id) {
                                    audio.muted = true;
                                    win.muted = true;
                                    click.muted = true;

                                    drawImg();
                                }
                            }
                         }                    
                    });
                
                }, false);
                // Add addbet.
                    colour: 'white',
                    clkbl_elems.push({
                    width: 110,
                    height: 110,
                    top: 290,
                    left: 730,
                    id: 'spin-btn',
                });
                clkbl_elems.push({
                    colour: 'Red',
                    width: 50,
                    height: 50,
                    top: 90, 
                    left: 1100,
                    id: 'audiobtn',
                });
            });
        </script>
    </body>
</html>