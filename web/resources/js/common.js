function hashPassword(form){
    form.userPassword.value=md5(form.userPassword.value);
}
function setLocaleEN(){  
    var url = window.location.pathname.split('?')[0];
    window.location = url+"?locale=en_US";  
}  
function setLocaleCN(){  
    var url = window.location.pathname.split('?')[0];
    window.location = url+"?locale=zh_CN";  
}
function setLocaleHK(){  
    var url = window.location.pathname.split('?')[0];
    window.location = url+"?locale=zh_HK";  
} 