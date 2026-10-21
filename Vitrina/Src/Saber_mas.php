<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saber más</title>
    <link rel="stylesheet" href="../Styles/EstiloSaber.css">
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


        <!-- CONTENEDOR PRINCIPAL -->
    <div id="vista-inicio"></div>
    <div id="vista-principal">
        <div class="contenedor-imagen">
            <img src="../Imagenes/Logo.jpg" alt="Logo CWE">
        </div>

    <!-- QUÉ ES CWE -->
    <section class="seccion-que-es">
        <div class="cuadro-que-es">
            <h2>¿Qué es CWE?</h2>
            <p><strong>CWE, "Conecta con la tierra"</strong>, es una aplicación que acerca los productos del campo a la ciudad. Puedes buscar, comparar precios y hacer tu pedido desde el celular.</p>
        </div>
    </section>

    <!-- PASOS -->
    <section class="seccion-pasos">
        <h2 class="titulo-pasos">COMPRAR ES ASÍ DE FÁCIL</h2>

        <div class="contenedor-pasos">
            <div class="paso">
                <span class="numero-paso">1</span>
                <h3>Explora el catálogo</h3>
                <p>Busca por nombre o filtra por categoría para encontrar lo que necesitas.</p>
            </div>

            <div class="paso">
                <span class="numero-paso">2</span>
                <h3>Agrega al carrito</h3>
                <p>Toca el botón "+" de cada producto. Verás su precio por kilo y quién lo vende.</p>
            </div>

            <div class="paso">
                <span class="numero-paso">3</span>
                <h3>Haz tu pedido</h3>
                <p>Confirma tu compra desde Mercado y consulta su estado en Mis Pedidos.</p>
            </div>
        </div>
    </section>

    <!-- CATEGORÍAS Y BENEFICIOS -->
    <section class="seccion-beneficios">
        <h2 class="titulo-beneficios">QUÉ ENCUENTRAS EN LA APP</h2>

        <div class="chips">
            <span class="chip">Frutas</span>
            <span class="chip">Verduras</span>
            <span class="chip">Hortalizas</span>
            <span class="chip">Tubérculos</span>
            <span class="chip">Hierbas</span>
        </div>

        <div class="contenedor-beneficios">
            <div class="beneficio">
                <span class="etiqueta-fresco">Fresco</span>
                <h3>Productos frescos</h3>
                <p>Cada producto muestra su foto, su precio y el proveedor que lo ofrece.</p>
            </div>

            <div class="beneficio">
                <span class="icono-beneficio">💲</span>
                <h3>Precios claros</h3>
                <p>Precios en pesos colombianos, por kilo Sin sorpresas.</p>
            </div>

            <div class="beneficio">
                <span class="icono-beneficio">🌱</span>
                <h3>Apoyas al campo</h3>
                <p>Conectamos a quienes cultivan con quienes compran.</p>
            </div>
        </div>
    </section>

    <!-- PREGUNTAS FRECUENTES -->
    <section class="seccion-preguntas">
        <h2 class="titulo-preguntas">Preguntas frecuentes</h2>

        <div class="contenedor-preguntas">
            <details>
                <summary>¿Cómo se cobran los productos?</summary>
                <p>Cada producto indica si el precio es por kilo (COP / kg).</p>
            </details>

            <details>
                <summary>¿Puedo ver quién vende cada producto?</summary>
                <p>Sí. En cada tarjeta aparece el nombre del proveedor.</p>
            </details>

            <details>
                <summary>¿Dónde puedo contactarlos?</summary>
                <p>Escríbenos a contacto@gmail.com o al +57 305 4661890.</p>
            </details>
        </div>
    </section>

    <!-- LLAMADO FINAL -->
    <section class="seccion-final">
        <div class="cuadro-final">
            <h2>¿Quieres provar el aplicativo?</h2>
            <p>Haz click aqui y descarga nuestro sistema</p>
            <a class="boton-final" href="../Apk/app-release.apk" download>CWE.APK</a>
        </div>
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
