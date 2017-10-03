 var videos =  [	 
	 	 "https://www.youtube.com/embed/SCyNP-eqS0Y?modestbranding=1&autoplay=1&controls=0&vq=hd720",
		 "https://www.youtube.com/embed/TD15l1RWqcI?modestbranding=1&autoplay=1&controls=0&vq=hd720",
		 "https://www.youtube.com/embed/HfEEZDtktUk?modestbranding=1&autoplay=1&controls=0&vq=hd720",
		 "https://www.youtube.com/embed/lCE_7j5quOY?modestbranding=1&autoplay=1&controls=0&vq=hd720",
		 "https://www.youtube.com/embed/Tx15fbNMCns?modestbranding=1&autoplay=1&controls=0&vq=hd720",
		 "https://www.youtube.com/embed/mFIOGpIQtVU?modestbranding=1&autoplay=1&controls=0&vq=hd720",	 
		 ];
        window.onload = function () {
            var playerDiv = document.getElementById("random_player");
            var player = document.createElement("IFRAME");
            var randomVideoUrl = videos[Math.floor(Math.random() * videos.length)];
            player.setAttribute('width', '100%');
            player.setAttribute('height', '100%');
            player.setAttribute('src', randomVideoUrl);
            playerDiv.appendChild(player);
        };
