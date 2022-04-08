let warning = document.getElementById("warnings");
let nombres = document.getElementById("first-name");
let apellidos = document.getElementById("surname");
let correo = document.getElementById("email");
let telefono = document.getElementById("phone");


const validarNombre = () => {
    (nombres.value == "")
        ? warning.innerHTML = "El campo no debe quedar vacío"
        : warning.innerHTML = "Lleno Correctamente!"
}

const validarApellido = () => {
    (/^(\w{10-20})$/.test(apellidos) == false)
        ? warning.innerHTML = "El campo no debe quedar vacío"
        : warning.innerHTML = "Lleno Correctamente!"
}

const validarCorreo = () => {
    (/^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i.test(email.value) == false)
        ? warning.innerHTML = "Ingrese un correo valido"
        : warning.innerHTML = "Correo Valido"
}

const validarTelefono = () => {
    (/^(\d{4})[-](\d{4})$/.test(telefono.value) == false)
        ? warning.innerHTML = "Ingrese un telefono valido"
        : warning.innerHTML = "Telefono Valido"
}


nombres.addEventListener("input", validarNombre);
apellidos.addEventListener("input", validarApellido);
correo.addEventListener("input", validarCorreo);
telefono.addEventListener("input", validarTelefono)


