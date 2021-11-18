// Codigo que utilizamos para poner la clase creada en CSS y asi se quede el navegador fijo
// Y tambien para cuando se clicke en el Menu en movil aparezca el menu
$(document).ready(function(){
	let altura = $('.navegador').offset().top;
	let count= 1;

	$(window).on('scroll', function(){
		if ( $(window).scrollTop() > altura ){
			$('.navegador').addClass('navegador-scroll');
            // Para cambiar el logo si se hace scroll 
            $('.logo').attr("src","images/logos/petinder.svg");
        } else {
			$('.navegador').removeClass('navegador-scroll');
            //Para volver a cambiar el logo
            $('.logo').attr("src","images/logos/petinder_white.svg");
		}
	});

});

$(document).ready(main);

let contador = 1;

function main () {
	$('.nav-mo').click(function(){
		if (contador == 1) {
			$('.navegador ul').animate({
				left: '0',
			});
			contador = 0;
		} else {
			contador = 1;
			$('.navegador ul').animate({
				left: '-100%',
			});
		}
	});
}