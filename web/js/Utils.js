function checkInput(val) {
    if (val != null && val.trim() != "") {
        return true;
    } else {
        return false;
    }
}

function zeropadInt(num, padlen) {
    var pad_char = '0';
    var pad = new Array(1 + padlen).join(pad_char);
    return (pad + num).slice(-pad.length);
}

function capitalletters(string){
    if(string=="" || string==null)
        return "";
    return string[0].toUpperCase()+string.slice(1);
}