//Bootstrapping phase, no jQuery
(function() {
    //TODO: points these constants at the appriate CDN versions
    //Constants
    var jqueryUrl  = 'http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js',
        contentUrl = 'http://localhost:3000/assets/frame.html';
    
    //0. Bail if there is already an #icanhaz on the page
    if(document.getElementById('icanhaz')) return;
    
    //1. Setup an iframe
    var root = document.createElement('div'),
        ifr = document.createElement('iframe');

    root.innerHTML = "<div style='z-index:1000000000;position:absolute' id='icanhaz'><div id='cheezlightbox' style='position:fixed;top:0;bottom:0;left:0;right:0;background:black;opacity:0.8;'></div></div>";
    root = root.firstChild;

    ifr.setAttribute('style','position:fixed;width:600px;height:400px;top:5%;left:50%;margin:0;border:0;margin-left:-300px;z-index:1000000000');
    root.appendChild(ifr);
    
    document.body.appendChild(root);

    //2. Use document.write to force a doctype
    ifr.contentDocument.open();
    ifr.contentDocument.write("<!DOCTYPE html>");
    ifr.contentDocument.close();

    //3. Load jquery and payload into the iframe
    setTimeout(function() {
        var doc = ifr.contentDocument;
        loadScript(jqueryUrl, doc, function() {
            //jquery is now loaded in the iframe
            var win = ifr.contentWindow,
                $ = win.$;
            
            //IE needs this silly hack to use XDomainRequest
            $.ajaxTransport(xDomainTransport);

            $('body').load(contentUrl);
        });
    }, 0);
    
    
    //Some useful functions for the non jQ code
    function loadScript(url, doc, cb) {
        doc = doc || document; //Default to the current doc
        var scr = doc.createElement('script');
        
        if(cb) {
            if(scr.addEventListener) {
                scr.addEventListener('load', cb,false);
            } else {
                //Hack for IE8
                scr.onreadystatechange= function () {
                    if (this.readyState == 'complete' || this.readyState == 'loaded') cb();
                }
            }
        }

        scr.src = url;
        doc.getElementsByTagName('head')[0].appendChild(scr);
    }
    
  function log(arg) {
        window.console && console.log(arg);
    }
    
    function xDomainTransport( options, originalOptions, jqXHR ) {
        var xdr;

        return {
            send: function( _, completeCallback ) {
                xdr = new XDomainRequest();
                xdr.onload = function() {
                    var responses = {
                        text: xdr.responseText
                    };

                    if (xdr.contentType.match(/\/xml/)){
                        // there is no responseXML in XDomainRequest, so we have to create it manually
                        var dom = new ActiveXObject('Microsoft.XMLDOM');
                        dom.async = false;
                        dom.loadXML(xdr.responseText);
                        responses.xml = dom;

                        if($(dom).children('error').length != 0) {
                            var $error = $(dom).find('error');
                            completeCallback(parseInt($error.attr('response_code')), $error.attr('message_key'), responses);
                        } else {
                            completeCallback(200, 'success', responses);
                        }

                    } else {
                        completeCallback(200, 'success', responses); // we will assume that the status code is 200, XDomainRequest rejects all other successful status codes
                    // see bug https://connect.microsoft.com/IE/feedback/ViewFeedback.aspx?FeedbackID=334804
                    }
                };
                xdr.onerror = xdr.ontimeout = function() {
                    var responses = {
                        text: xdr.responseText
                    };
                    completeCallback(400, 'failed', responses);
                }

                xdr.open(options.type, options.url);
                xdr.send(options.data);
            },
            abort: function() {
                if(xdr) {
                    xdr.abort();
                }
            }
        };
    }


})();