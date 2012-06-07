//jQuery should be available to use
(function() {

    //Get and sort the images on the parent page
    var images = $('img', window.parent.document),
        image_list = $('.image-list'),
        iframes = $('iframe', window.parent.document);
        
    iframes.each(function(i, ifr) {
        try {
            var doc = ifr.contentWindow.document;
        } catch(e) {
            //Not same origin…
        }
        
        if(doc) {
            images = images.add($('img', doc));
        } else {
            //iframe not same origin
        }
    });

    //Returns the best-guess at the image's actual width/height
    function getWidth(i)  { return i.naturalWidth  || i.width;  }
    function getHeight(i) { return i.naturalHeight || i.height; }
    
    //Pull all the images out of the parent window, sort them by area, stuff them into the image list
    images.sort(function(l, r) {
        //TODO: IECOMPAT, naturalWidth/naturalHeight
        //Sort by area, descending
        return ((getWidth(r) * getHeight(r)) - (getWidth(l) * getHeight(l)));
    });
    images.filter(function() {
        //remove small images with a small dimension
        return Math.max(getWidth(this), getHeight(this)) > 100;
    }).map(function(i, el) {
        var newImage = document.createElement('img');

        newImage.src = el.src;
        return newImage;
    }).appendTo(image_list).wrap("<div class='image-item'><div class='image-wrap'></div></div>");
    
    //Liven up the image list to post the appropriate url to a new window
    image_list.delegate('.image-item', 'click', function(ev) {
        var imgSrc = $(this).find('img')[0].src,
            cheezWin = window.open('http://techsoftcomputing.com?url=' + encodeURIComponent(imgSrc));
    });
    
    //Hook up Close
    $(document.body).delegate('a[rel="close"]', 'click', function(ev) {
        ev.preventDefault();
        //Find our iframe in the parent window and destroy it
        $('#icanhaz', window.parent.document).remove();
    });
})();