[[_TOC_]]

# PAUTAS DEL TRABAJO PRÁCTICO

## Generalidades

### Introducción
El presente **Trabajo Práctico Integrador** (de aquí en adelante **TPI**) tiene por objetivo llevar
a la práctica los contenidos vistos a lo largo de las clases teóricas del ciclo lectivo. De este
modo se espera una realimentación entre la comprensión de los diferentes conceptos teóricos y su
aplicación práctica efectiva, desarrollando en el alumno un enfoque sistemático que le permita
resolver problemas de ingeniería utilizando las diferentes herramientas impartidas en clase.

El **TPI** consta de la resolución de un subconjunto de 14 ejercicios seleccionados del total de
ejercicios sugeridos para el año 2022. 

Los enunciados de los ejercicios podrán consultarse en la
guía publicada en el Campus Virtual del curso de Técnicas Digitales R3052 correspondiente al año
2022. Para mayor información, seguir el siguiente [**Guía TPs 2021/22**](https://aulasvirtuales.frba.utn.edu.ar/pluginfile.php/2175946/mod_resource/content/26/gde.pdf).

### Régimen de aprobación 
Los requisitos para la aprobación del presente **TPI** se detallan a continuación: 
* Se deberá entregar el **TPI** en tiempo y forma, sin excepciones. 
* La no entrega del **TPI** en las fechas establecidas equivale a la no aprobación del mismo. 
* Para aspirar a la **regularización** de la materia se deberá alcanzar, como mínimo, la suma de **6
  puntos** como condición necesaria para la aprobación del **TPI**. 
* Para aspirar a la **promoción** de la materia se deberá alcanzar, como mínimo, la suma de **8
  puntos** como condición necesaria para la aprobación del **TPI**.

#### Sistema de puntuación 

A continuación se detalla el sistema de puntuación para los diferentes ejercicios del **TPI**

| Clase del Tramo VHDL | Conteo | Ejercicio | Puntuación | Observaciones |
|----------------------|--------|-----------|------------|---------------|
| Parte 1              | 1      | 8.7       | 0,50       |               |
| Parte 1              | 2      | 8.8       | 0,50       |               |
| Parte 1              | 3      | 8.9       | 0,50       |               |
| Parte 2              | 4      | 8.10      | 0,50       |               |
| Parte 2              | 5      | 8.14      | 0,50       |               |
| Parte 2              | 6      | 8.15      | 0,50       |               |
| Parte 3              | 7      | 8.18      | 0,50       |               |
| Parte 3              | 8      | 8.20      | 1,00       |               |
| Parte 4              | 9      | 8.22      | 0,75       |               |
| Parte 4              | 10     | 8.25      | 0,75       |               |
| Parte 5              | 11     | 8.26.a    | 1,00       |               |
| Parte 5              | 12     | 8.26.b    | 1,00       |               |
| Parte 6              | 13     | 8.27      | 1,00       |               |
| Parte 7              | 14     | 8.30      | 1,00       |               |


### Régimen de entregas 

#### Cronograma de entregas 
El trabajo práctico ha sido planificado a fin de que los alumnos puedan hacer entregas parciales
clase a clase y puedan medir por sí mismos su progreso.

Idealmente los alumnos publicarán en los repositorios semana a semana los resultados parciales que
obtengan. 

Si lo así lo desearan, los alumnos podrán adelantar sus tareas, aún cuando el cronograma pautado por
el curso no haya abarcado los temas que deseen adelantar.

**La fecha límite para la entrega del trabajo práctico será el mismo día que se haya acordado para
la resolución del último parcial de la asignatura.**

#### Procedimiento para las entregas 
La entrega del **TPI** se realizará a traves de los repositorios que la Facultad tiene a su
dispoción.

La resolución del trabajo práctico consiste en 14 ejercicios, a razón de un promedio de 2 ejercicios
por clase. 

El directorio de trabajo constará de una carpeta por ejercicio, organizada de la siguiente manera:
* **ejxx/**: directorio raíz para el ejercicio xx de la guía de ejercicios.
  * **rtl/**: directorio destinado únicamente a almanacenar los códigos RTL escritos en lenguaje
    VHDL
     * Aquí los alumnos publicarán sus soluciones. Para la gran mayoría de los ejercicios sólo será
       necesario publicar un único archivo, razón por la cual, no estará permitido que se publiquen
       otros archivos que no sean necesarios. 
     * Al momento de publicar los entregables, téngase en cuenta que las herramientas crean archivos
       adicionales al código VHDL ( \*.vhd ) que los alumnos **no deberán publicar**. 
     * Los docentes asumen que los códigos VHDL compilan libres de errores y warnings atribuibles a
       un pobre estilo de codificación. Errores de este índole anulan la calificación del punto
       correspondiente del TPI. 
     * Asimismo los docentes suponen que los códigos entregados como resolución fueron simulados con
       los bancos de prueba que les fueron suministrados a los alumnos. En consecuencia la simulación
       debe ser exitosa. 
  * **sim/**: directorio destinado para la simulación del módulo digital que se está diseñando. Los
    alumnos no deberán publicar nada en este directorio ni tampoco modificar ningún archivo que éste
    contenga. 
  * **xtras/**: directorio destinado únicamente a almanacenar el/los archivo/s que contengan toda otra 
    información ajena al código RTL y que el alumno necesite publicar para poder compartir con los 
    docentes.

#### Lista de comandos comunes

* Clonar el repositorio

`git clone https://gitlab.frba.utn.edu.ar/forge/tdi_r3052_tpi_2021.git`

* _Checkout_ de la rama de trabajo (cada alumno debe trabajar en la rama que lleva su apellido)

`git checkout <apellido>`

* Agregar un archivo

`git add <archivo>`

* _Commitear_ un (o más) archivo(s) (sólo lo versiona en el repositorio local)

`git commit -m <comentario>`

* _Pushear_ un (o más) archivo(s) (los archivos se publican en el reposositorio remoto)

`git push`

# Canal de Youtube

Para acceder al canal de Youtube de Técnicas Digitales I, siga el siguiente [**enlace**](https://www.youtube.com/channel/UCUmwVNkoA9DMOJ7rm-almwA).

## Listas de reproducción
* [Capítulo 6: Máquinas de Estados](https://www.youtube.com/watch?v=tXWYOdDbsDI&list=PLda85bW_myIpD61YsfF2oeqq9ekwV3htu)
* [Capítulo 7: Análisis Temporal Estático](https://www.youtube.com/watch?v=kNm640hZkRU&list=PLda85bW_myIqi54maDPz8CO9jVwPBMCQW)
* [Instalación de Herramientas en **Windows**](https://www.youtube.com/playlist?list=PLda85bW_myIpFrpr__4aFceOfMHaTCfJH)
* [Instalación de Herramientas en **Ubuntu**](https://www.youtube.com/watch?v=_sT_yOUKFxk&list=PLda85bW_myIpvb4aPnz22Tn7zbXiQ4avI)
* [Capítulo 8: Lenguajes descriptores - VHDL]()
