<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Soccer</title>
        
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
              background: #539927;
              border:1px solid black;
            }
        </style>
        
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    </head>
    <body>
    
        <canvas id="canvas" width="500" height="200"></canvas>
        <br>
        Soccer shit
    </body>
    
    <script type="text/javascript" charset="utf-8">
        var ctx = canvas.getContext('2d');
        var width = canvas.width; // size
        
        var bg_img = new Image();
        
        bg_img.src      = '../images/soccer/soccer_bg.png';
        
        function drawImg(pos_x, img_width, img_opac) {
            var bg_height   = 150;
            var bg_width    = 350;
            var bg_x        = 80;
            var bg_y        = 25;
            
            var rect_x      = 230 - pos_x;
            var tri_x       = 210 - pos_x;
            var rect_wid    = 20 + img_width;
            
            var half_width  = bg_width / 2;
            
            ctx.drawImage(bg_img, bg_x, bg_y, bg_width, bg_height);
            //ctx.globalAlpha = img_opac;
            ctx.fillStyle= 'rgba(255, 0, 0, '+ img_opac +')';
            ctx.fillRect(rect_x, 30, rect_wid, 140);
            //ctx.globalAlpha = 1.0;
            
            /*  Draw Triangle   */
            ctx.beginPath();
            
            ctx.moveTo(rect_x, 70);
            ctx.lineTo(rect_x, 120);
            ctx.lineTo(tri_x, 90);
            ctx.fill();
        }
        
        function drawLbl(pos_x, dsp_txt) {
            var lbl_x       = 250 - pos_x;
            
            ctx.fillStyle   = 'rgba(255, 255, 255, 1)';
            ctx.font        = "16px Georgia";
            ctx.fillText(dsp_txt, lbl_x, 100);
        }
        
        function animDngAttk(pos_x, width, img_opac) {
            
            var upd_pos_x       = pos_x + 0.5;
            var upd_img_width   = width + 0.5;
            var upd_lbl_txt     = pos_x;
            var upd_img_opac    = img_opac + 0.003;
            
            ctx.clearRect(0, 0, 500, 500);
            
            if (50 < upd_pos_x) {
                upd_pos_x       = 50;
            }
            
            if (50 < upd_img_width) {
                upd_img_width   = 50;
            }
            
            if (50 < upd_lbl_txt) {
                upd_lbl_txt     = 50;
            }
            
            if (0.5 < upd_img_opac) {
                upd_img_opac    = 0.2;
            }
            
            drawImg(upd_pos_x, upd_img_width, upd_img_opac);
            drawLbl(upd_lbl_txt, 'Dangerous Attack');
            
            window.requestAnimationFrame(function() {
                animDngAttk(upd_pos_x, upd_img_width, upd_img_opac);
            });
        }
        
        function drawCornerBall(pos_x, pos_y, route) {
            var ball_img    = new Image();
            
            var bg_height   = 150;
            var bg_width    = 350;
            var bg_x        = 80;
            var bg_y        = 25;
            
            if (1 == route) {
                var ball_pos_x  = 380 - pos_x;
                var ball_pos_y  = 180 - pos_y;
            }
            
            if (2 == route) {
                var ball_pos_x  = 320 + pos_x;
                var ball_pos_y  = 120 - pos_y;
            }
            
            var half_width  = bg_width / 2;
            
            ball_img.src      = '../images/soccer/soccer-ball.png';
            
            ctx.drawImage(bg_img, bg_x, bg_y, bg_width, bg_height);
            ctx.drawImage(ball_img, ball_pos_x, ball_pos_y, 15, 15);
        }
        
        function animCornerBall(pos_x, pos_y, route, text_fix) {
            var upd_pos_x   = pos_x + 0.5;
            var upd_pos_y   = pos_y + 0.5;
            var upd_route   = route;
            var upd_lbl_txt = pos_x;
            var upd_text_fix= text_fix;
            
            ctx.clearRect(0, 0, 500, 500);
            
            if (60 < upd_pos_x) {
                upd_pos_x = 1;
                
                if (1 == upd_route) {
                    upd_route = 2;
                }
                else {
                    upd_route = 1;
                }
            }
            
            if (60 < upd_pos_y) {
                upd_pos_y = 1;
            }
            
            if ((18 < upd_lbl_txt)
            || (1 == upd_text_fix )) {
                upd_lbl_txt     = 18;
                upd_text_fix    = 1;
            }
            
            drawCornerBall(upd_pos_x, upd_pos_y, upd_route);
            drawLbl(upd_lbl_txt, 'Corner');
            
            window.requestAnimationFrame(function() {
                animCornerBall(upd_pos_x, upd_pos_y, upd_route, upd_text_fix);
            });
        }
        
        //animDngAttk(10, 10, 0.2);
        animCornerBall(1, 1, 1, 0);
        
    </script>
</html>