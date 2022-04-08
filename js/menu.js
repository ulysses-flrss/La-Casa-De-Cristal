let open = document.getElementById("menu-icon");
let close = document.getElementById("close");
let menu = document.getElementById("menu");
let imagen = document.getElementById(`cover`);
let titulo =  document.getElementById(`titulo`);
let body = document.getElementById("body");
let up = document.getElementById("up");

const topPage = () => {
    window.scroll(0,0)
}

const openMenu = ()=> {
    menu.style.visibility = "visible";
    menu.style.transform = "translate(0, 0)";
    open.style.visibility = "hidden";
    body.className = "noScroll";
}

const closeMenu = ()=> {
    menu.style.visibility = "hidden";
    menu.style.transform = "translate(-250px, 0)";
    open.style.visibility = "visible";
    body.className = null;
}

open.addEventListener("click", openMenu);
close.addEventListener("click", closeMenu);
up.addEventListener("click", topPage);