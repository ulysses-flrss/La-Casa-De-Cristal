let open = document.getElementById("menu-icon");
let close = document.getElementById("close");
let menu = document.getElementById("menu");
let imagen = document.getElementById(`cover`);
let titulo =  document.getElementById(`titulo`);
let subtitulo = document.getElementById(`subtitulo`);
let body = document.getElementById(`body`);

const openMenu = ()=> {
    menu.style.transform = "translate(0, 0)";
    open.style.display = "none";
    imagen.style.filter = `brightness(0.1)`;
    titulo.style.filter = `brightness(0.3)`;
    subtitulo.style.filter = `brightness(0.3)`;
    body.className = `noScroll`;
    
}

const closeMenu = ()=> {
    menu.style.transform = "translate(-250px, 0)";
    open.style.display = "flex";
    titulo.style.filter = `brightness(1)`;
    subtitulo.style.filter = `brightness(1)`;
    imagen.style.filter = `brightness(0.3)`;
    body.className = null;
}

open.addEventListener("click", openMenu);
close.addEventListener("click", closeMenu);