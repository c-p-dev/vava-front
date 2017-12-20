

<script type="text/javascript" src="/js/angular.js"></script> 
<script type="text/javascript" src="/js/angular-animate.min.js"></script> 

<link rel="stylesheet" type="text/css" href="//oss.maxcdn.com/tipped/4.0.10/css/tipped/tipped.css">


<body>
  <div ng-app="myApp" class="ng-scope">
    <div id="" mytip="this is my toolti555p" class="ng-isolate-scope">Hover</div>
</div>
  




<script type="text/javascript">//<![CDATA[

angular.module('myApp', [])
.directive('mytip', function(){
    return {
        restrict: 'A',
        scope: {
            mytip: '@'  
        },
        link: function(scope, elem, attrs) {
            Tipped.create(elem, scope.mytip, {
                position: 'bottomLeft'
            });
        }
    };
});
//]]> 

</script>

  





</body>
