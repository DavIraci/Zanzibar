// Verifica che il paramentro passato non sia nullo o vuoto
function checkInput(val) {
    return val != null && val.trim() !== "";
}

// Effettua il padding con gli '0' del numero inserito
function zeropadInt(num, padlen) {
    let pad_char = '0';
    let pad = new Array(1 + padlen).join(pad_char);
    return (pad + num).slice(-pad.length);
}

// Trasforma la stringa con la prima lettera in maiuscolo
function capitalletters(string){
    if(string==="" || string==null)
        return "";
    return string[0].toUpperCase()+string.slice(1);
}