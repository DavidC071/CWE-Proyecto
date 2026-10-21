<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quienes_somos</title>
    <link rel="stylesheet" href="../Styles/EstiloSomos.css">
</head>
<body>
    <header>
        <div class="container">
            <p class="logo">CWE</p>
            <nav>
                <a href="Inicio.php"><h2>Inicio</h2></a>
                <a href="Quienes_somos.php"><h2>Quienes somos</h2></a>
                <a href="Saber_mas.php"><h2>Saber más</h2></a>
            </nav>
        </div>
    </header>


            <section class="portada-saber">
        <h1>Nuestra Empresa</h1>
        <p>Somos una empresa desarrolladora de software colombiana que convierte ideas en aplicaciones y plataformas web. Ayudamos a pequeños negocios y emprendedores a llevar su comercio al mundo digital, con soluciones sencillas, a la medida y a costos accesibles.</p>
    </section>

        <section class="seccion-presentacion">
            <div class="cuadro-gris-fondo">
                <h2>Nosotros</h2>
                <p>Somos estudiantes de Ingeniería de Software de la Universidad Minuto de Dios (UNIMINUTO) y creamos soluciones digitales con propósito. Nuestro proyecto, CWE, nació para acercar los productos del campo colombiano a las familias de la ciudad.</p>
            </div>
        </section>

        <section class="seccion-servicios">
            <h2 class="titulo-servicios">NUESTROS ROLES</h2>

            <div class="contenedor-tarjetas">

                <!-- Tarjeta 1 -->
                <div class="tarjeta-servicio">
                    <div class="marco-arco">
                        <img src="../Imagenes/Farid.jpeg">
                    </div>
                    <div class="contenido-tarjeta">
                        <h3>Scrum Master</h3>
                        <p>Farid Leonardo Casas Mosquera</p>
                    </div>
                </div>

                <!-- Tarjeta 2 -->
                <div class="tarjeta-servicio">
                    <div class="marco-arco">
                        <img src="../Imagenes/Sebastian.jpeg">
                    </div>
                    <div class="contenido-tarjeta">
                        <h3>Prompt Owner</h3>
                        <p>Sebastian Vizcaino Garcia</p>
                    </div>
                </div>
                                <!-- Tarjeta 1 -->
                <div class="tarjeta-servicio">
                    <div class="marco-arco">
                        <img src="../Imagenes/David.jpeg">
                    </div>
                    <div class="contenido-tarjeta">
                        <h3>Desarrollador 1</h3>
                        <p>David Esteban Carrillo Acevedo</p>
                    </div>
                </div>                <!-- Tarjeta 1 -->
                <div class="tarjeta-servicio">
                    <div class="marco-arco">
                        <img src="../Imagenes/Danna.jpeg">
                    </div>
                    <div class="contenido-tarjeta">
                        <h3>Desarrollador 2</h3>
                        <p>Danna Lizeth Rodriguez Bonilla</p>
                    </div>
                </div>

            </div>
        </section>
    </div>

    <footer class="footer">

        <div class="footer-contenido">

            <div class="footer-seccion">
                <h3>Valores</h3>
                <ul>
                    <li>Innovacion</li>
                    <li>Calidad de servicio</li>
                    <li>Seguridad y confianza</li>
                </ul>
            </div>

            <div class="footer-seccion">
                <h3>Contáctanos</h3>
                <p>📍 Bogotá, Cundinamarca</p>
                <p>📞 +57 305 4661890</p>
                <p>✉️ contacto@gmail.com</p>
            </div>

            <div class="footer-seccion">
                <h3>Síguenos</h3>

                <div class="redes-sociales">
                    <a href="#">
                        <img src="../Imagenes/Api1.png" alt="WhatsApp">
                    </a>

                    <a href="#">
                        <img src="../Imagenes/Api2.png" alt="Facebook">
                    </a>

                    <a href="#">
                        <img src="../Imagenes/Api3.png" alt="Instagram">
                    </a>
                </div>
            </div>

        </div>

        <div class="footer-inferior">
            <p>&copy; 2026 CWE<span>sas</span>. Todos los derechos reservados.</p>
        </div>

    </footer>
</body>
</html>
