let open = document.getElementById("menu-icon");
let close = document.getElementById("close");
let menu = document.getElementById("menu");
let imagen = document.getElementById(`cover`);
let titulo =  document.getElementById(`titulo`);
let subtitulo = document.getElementById(`subtitulo`);
let body = document.getElementById("body");
let up = document.getElementById("up");





const topPage = () => {
    window.scroll(0,0)
}


const openMenu = ()=> {
    menu.style.transform = "translate(0, 0)";
    open.style.display = "none";
    body.className = "noScroll";
    body.style.filter = "brightness(0.3)";
    up.style.filter = "brightness(0.3)";
}

const closeMenu = ()=> {
    menu.style.transform = "translate(-250px, 0)";
    open.style.display = "flex";
    body.className = null;
    body.style.filter = "brightness(1)";
    up.style.filter = "brightness(1)";
}

open.addEventListener("click", openMenu);
close.addEventListener("click", closeMenu);
up.addEventListener("click", topPage);