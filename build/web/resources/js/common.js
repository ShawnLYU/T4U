function hashPassword(form){
    form.userPassword.value=md5(form.userPassword.value);
}
//function setLocaleEN(){  
//    var url = window.location.pathname.split('?')[0];
//    window.location = url+"?locale=en_US";  
//}  
//function setLocaleCN(){  
//    var url = window.location.pathname.split('?')[0];
//    window.location = url+"?locale=zh_CN";  
//}
//function setLocaleHK(){  
//    var url = window.location.pathname.split('?')[0];
//    window.location = url+"?locale=zh_HK";  
//} 
function addParameterToURL(param){
    _url = window.location.href;
    _url += (_url.split('?')[1] ? '&':'?') + param;
    return _url;
}
function setLocaleEN(){  
//    var url = window.location.search;
//    if (url.match("locale").length > 0) {
//        
//    }
    var uri = window.location.href;
    var key = "locale";
    var value = "en_US";
    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
      window.location = uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
      window.location = uri + separator + key + "=" + value;
    }
//    window.location = addParameterToURL("locale=en_US");  
}  
function setLocaleCN(){  
    
//    window.location = addParameterToURL("locale=zh_CN");  
var uri = window.location.href;
    var key = "locale";
    var value = "zh_CN";
    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
      window.location = uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
      window.location = uri + separator + key + "=" + value;
    }
}
function setLocaleHK(){  
    
//    window.location = addParameterToURL("locale=zh_HK");  
var uri = window.location.href;
    var key = "locale";
    var value = "zh_HK";
    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
      window.location = uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
      window.location = uri + separator + key + "=" + value;
    }
} 
