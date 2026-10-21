<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio</title>
    <link rel="stylesheet" href="../Styles/EstiloInicio.css">
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

    <section id="hero">
        <h1>Del campo a la ciudad <br>a un click de distancia</h1>
    </section>

    <footer class="footer">

        <div class="footer-contenido">

            <!-- Información -->
            <div class="footer-seccion">
                <h3>Valores</h3>
                <ul>
                    <li>Innovacion</li>
                    <li>Calidad de servicio</li>
                    <li>Seguridad y confianza</li>
                </ul>
            </div>

            <!-- Contacto -->
            <div class="footer-seccion">
                <h3>Contáctanos</h3>
                <p>📍 Bogotá, Cundinamarca</p>
                <p>📞 +57 305 4661890</p>
                <p>✉️ contacto@gmail.com</p>
            </div>

            <!-- Redes sociales -->
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
