const navbarToggle = document.querySelector('.navbar-toggle');
const navbarToggleIcon = document.querySelector('.navbar-toggle .fa');
const mainMenuUl = document.querySelector('.main-menu-ul');
const subMenuToggle = document.querySelectorAll('.sub-menu-toggle');
function toggleNavbar() {
    navbarToggle.addEventListener('click', () => {
        mainMenuUl.classList.toggle('active');
        navbarToggleIcon.classList.toggle('fa-times');
        navbarToggleIcon.classList.toggle('fa-bars');
    })
}
function toggleSubMenu() {
    subMenuToggle.forEach(item => {
        item.addEventListener('click', () => {
            const subMenu = item.nextElementSibling;
            subMenu.classList.toggle('active');
            const subMenuToggleIcon = item.querySelector('.fa');
            subMenuToggleIcon.classList.toggle('fa-plus');
            subMenuToggleIcon.classList.toggle('fa-minus');
        })
    })
}

toggleNavbar();
toggleSubMenu();