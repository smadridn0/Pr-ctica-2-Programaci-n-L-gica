### Prac2-LogProg
Autores: Matías Cardona Acosta, Simón Madrid Noreña, Miguel Muñoz
________________________________________
 Índice del repositorio
El repositorio está organizado en las siguientes secciones principales:
•	README: documento central que contiene la explicación general del proyecto, los dos challenges desarrollados, las pruebas realizadas, los problemas encontrados y las conclusiones.
•	Challenge 1 — Base de datos de plataformas: incluye la base de conocimiento de dispositivos de cómputo junto con consultas básicas y complejas.
•	Challenge 4 — Travel Planning Software: contiene el modelo de rutas de viaje, predicados para encontrar trayectos y reglas de optimización.
•	Pruebas: se documentan las consultas utilizadas para validar el funcionamiento de los predicados de ambos challenges, incluyendo casos límite y escenarios sin solución.
•	Conclusiones: sección final en la que se presentan los aprendizajes obtenidos, la importancia de las pruebas y la valoración del uso de Prolog para resolver problemas de bases de datos y planificación de rutas.
________________________________________
Challenge 1 — Base de datos de plataformas
Este challenge consiste en construir una base de conocimiento en Prolog que modele diferentes plataformas de cómputo (laptops, PCs, tablets). Cada hecho captura atributos clave: marca, identificador de serie, año de adquisición, memoria RAM, fabricante y núcleos de CPU, capacidad de disco, tipo de dispositivo, fabricante de GPU y cantidad de memoria de video.
Con más de 50 registros, la base cubre escenarios reales de mercado: equipos de distintas marcas y años, con variedad de configuraciones que permiten poner a prueba consultas sencillas y complejas.
Consultas básicas implementadas
•	CPU AMD después de 2021: identifica dispositivos modernos de esa arquitectura.
•	Tablets con más de 2GB de RAM: útil para distinguir equipos funcionales frente a gama baja.
•	Discos entre 32GB y 512GB: filtra los dispositivos de almacenamiento intermedio.
•	Contar ASUS: ejemplo de conteo de hechos en la base.
•	Laptops con RAM > 4GB y Disco < 512GB: combina restricciones de memoria y almacenamiento.
Consultas complejas implementadas
•	Plataformas gaming: busca configuraciones con GPU NVIDIA potente y CPU multinúcleo.
•	Balance RAM/Núcleos: mide eficiencia de hardware.
•	Ecosistema integrado: detecta equipos de un solo fabricante en CPU/GPU con buenas prestaciones.
•	Ranking de rendimiento: genera orden descendente de equipos con un puntaje calculado.
Pruebas realizadas
Se diseñaron y ejecutaron múltiples consultas en SWI-Prolog:
•	Validación de filtros por año: se ejecutó plataformas_amd_post_2021/2 y se verificó que todos los resultados tuvieran año > 2021 y CPU AMD.
•	Verificación de límite de memoria en tablets: se consultó tablets_ram_mayor_2gb/3 con resultados esperados que superaran RAM = 2, descartando los de 2GB exactos.
•	Prueba de disco en rango: se probaron valores frontera, como 32GB y 512GB, confirmando inclusión de extremos.
•	Conteo ASUS: se cruzó manualmente el número de registros ASUS en la base para comprobar que contar_asus/1 devolviera la cantidad exacta.
•	Ranking de rendimiento: se ejecutó top_rendimiento(5,Top) y se contrastó con cálculos manuales para confirmar el orden.
Estas pruebas se registraron en tests/test_ch1.pl, con ejemplos de entradas y salidas esperadas.
________________________________________
Challenge 2 — Travel Planning Software
Este challenge modela un planificador de viajes que trabaja como un sistema de rutas entre ciudades. Cada ruta almacena información detallada: ciudad de origen y destino, medio de transporte, hora de salida, hora de llegada, precio en USD y disponibilidad.
El objetivo fue implementar un sistema capaz de construir itinerarios válidos considerando tiempos de conexión, disponibilidad, precios y evitando rutas repetidas.
Predicados principales
•	camino/5: construye un trayecto entre dos ciudades acumulando tiempo total y precio.
•	caminoentre/7: versión que restringe los caminos a un intervalo horario definido por el usuario.
•	cheapest/5: busca el trayecto con menor costo global.
•	fastest/5: encuentra la ruta más rápida en tiempo total.
•	cheapestentre/7 y fastestentre/7: variantes con restricción horaria.
Pruebas realizadas
Se llevaron a cabo diferentes pruebas en SWI-Prolog:
•	Verificación de acumuladores: se validó que camino/5 sumara correctamente tiempo y costo en trayectos con escalas múltiples.
•	Pruebas de franja horaria: caminoentre/7 fue evaluado con intervalos reducidos (ej. [1,5]) confirmando que descartara rutas fuera de la ventana.
•	Cheapest y Fastest: se probaron múltiples pares de ciudades. Por ejemplo, cheapest(medellin, bogota, ...) retornó el trayecto de menor costo (100), mientras que fastest(...) devolvió el de menor tiempo (2 horas). Se compararon manualmente contra las rutas disponibles.
•	Evitación de ciclos: se intentó forzar bucles cerrados (ej. Medellín → Bogotá → Medellín) y se comprobó que el sistema no los aceptaba, gracias al uso de Visitados.
•	Restricción de horarios vencidos: se comprobó que el predicado no permitiera elegir rutas que partían antes de llegar al destino previo.
•	Pruebas sin solución: se consultaron pares de ciudades sin rutas disponibles, confirmando que el sistema devolviera false en vez de trayectos inválidos.
________________________________________
Problemas encontrados
•	Comparaciones con variables no instanciadas: resuelto asegurando instanciación antes de usar operadores.
•	Recursión infinita: solucionada con Visitados para evitar ciclos.
•	Orden en findall/min_member: se normalizó usando tuplas (Score, Marca, Serial).
•	Horarios decimales: se recomienda representar en minutos enteros para mayor precisión.
•	Mayor o igual en rutas: fue necesario crear un predicado aparte mayor_o_igual/2, ya que >= no funcionaba con variables.
•	Restricción de horarios vencidos: se añadió la condición de no permitir tomar rutas en horarios ya pasados respecto al último tramo recorrido.
•	Acumuladores de estado: se implementaron acumuladores para guardar rutas recorridas, precio y hora final. No teníamos total claridad sobre este punto, por lo que se investigó sobre acumuladores y recursión en Prolog para conseguirlo.
________________________________________
Conclusiones
1.	La práctica permitió comprender cómo estructurar bases de conocimiento en Prolog y consultarlas de manera declarativa, destacando la diferencia frente a lenguajes imperativos.
2.	Se evidenció la importancia de diseñar predicados recursivos robustos, asegurando condiciones de parada y el uso de listas de visitados para evitar ciclos en problemas de grafos.
3.	Se aprendió a manejar restricciones complejas (como horarios y recursos) a través de reglas lógicas, lo que mostró la flexibilidad de Prolog para resolver problemas de planificación y optimización.
4.	El uso de predicados como findall/3, setof/3 y min_member/2 fue clave para generar consultas más expresivas y obtener soluciones óptimas de manera sencilla.
5.	Esta práctica resaltó la relevancia de un modelado adecuado de datos (ejemplo: unidades de tiempo, relación RAM/núcleos) para obtener resultados precisos y útiles.
6.	Al realizar pruebas exhaustivas en cada challenge se evidenció la importancia de diseñar casos de prueba que incluyan valores frontera, condiciones excepcionales y escenarios sin solución, fortaleciendo así la validación del sistema.
________________________________________

