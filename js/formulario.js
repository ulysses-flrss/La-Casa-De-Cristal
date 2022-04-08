let warning = document.getElementById("warnings");
let nombres = document.getElementById("first-name");
let apellidos = document.getElementById("surname");
let correo = document.getElementById("email");
let telefono = document.getElementById("phone");
let regExp = /^ [A-Za-z] \\ w {5, 29} $/;


const validarNombre = () => {
    
    if (regExp.test(nombres)) {
        console.log("sajhdjaadnj");
        warning.innerHTML = "El tipo de dato ingresado es invalido";
    } else {
        console.log("NO");
    }
}

nombres.addEventListener("keypress", validarNombre);

