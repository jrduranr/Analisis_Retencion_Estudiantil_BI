# 📉 Proyecto de Portafolio: Dashboard de Riesgo y Retención Estudiantil

## 🎯 Objetivo del Proyecto

El objetivo principal de este proyecto es construir un **Modelo de Segmentación de Riesgo** que permita a una institución educativa identificar proactivamente a los estudiantes con **alta probabilidad de deserción **, basándose en el rendimiento académico inicial y factores financieros.

El resultado es un Dashboard interactivo en Power BI diseñado para enfocar recursos de tutoría e intervención en los grupos más vulnerables.

## 🛠️ Metodología y Stack Tecnológico

El proyecto sigue un flujo de trabajo de ETL (Extraer, Transformar, Cargar) y Modelado, utilizando las siguientes herramientas:

| Herramienta | Función en el Proyecto |
| :--- | :--- |
| **SQL Server** | Limpieza de datos, resolución de problemas de **codificación** y **cálculo de métricas** clave (e.g., Tasa de Éxito Curricular). |
| **Excel / DAX (Power BI)** | **Modelado de la Lógica de Negocio** y creación de la columna final **`Segmento_Riesgo`** (`Alto`, `Medio`, `Bajo`). |
| **Power BI** | Creación de un dashboard interactivo con navegación entre páginas, y uso de **Medidas DAX** (e.g., `Total Femenino`, `Tasa Desercion`). |

---

## 📂 Estructura del Repositorio

La organización del proyecto se divide en tres carpetas principales para reflejar el flujo de trabajo de BI, facilitando la revisión del código y los datos:

/ ├── DATOS/ │ ├── Modelo_Riesgo_Estudiantil_Final.xlsx # Fuente de datos limpia y modelada (con Segmento_Riesgo). │ ├── student_dataset.csv # Archivo de datos brutos original. ├── POWER BI/ │ └── Modelo_Riesgo_Estudiantil_Final.pbix # Archivo final del Dashboard. └── SQL/ ├── 01_create_db_tables.sql # Scripts para crear la BD y la tabla de datos brutos. └── 02_Calculo_Metricas_Riesgo.sql # Scripts para la transformación de datos y cálculo de métricas.

---

## ⚙️ Fases de Transformación de Datos

### 1. Ingesta y Transformación (SQL)

* **Limpieza:** Se resolvió el conflicto de tipos de datos en la importación (texto de encabezado en columnas `INT`) utilizando sentencias `ALTER TABLE... NULL`.
* **Cálculo:** El script `02_Calculo_Metricas_Riesgo.sql` calculó la **`Tasa_Exito_1er_Semestre`** (Unidades aprobadas / Unidades matriculadas) y tradujo códigos clave como `Estado_Financiero` (Al Día/Deudor) y `Estado_Final` (Deserción/Activo/Graduado).

### 2. Modelado de Riesgo (Excel y DAX)

* **Lógica de Negocio:** La tabla limpia fue enriquecida con la columna **`Segmento_Riesgo`** implementada en Excel/DAX, aplicando la siguiente jerarquía de riesgo:
    * **ALTO:** Si `Tasa_Exito_1er_Semestre` < 50% **O** `Estado_Financiero` = Deudor.
    * **MEDIO:** Si `Tasa_Exito_1er_Semestre` < 80% **Y** `Estado_Financiero` = Al Día.
    * **BAJO:** En cualquier otro caso.
* **Traducción:** Se usó una Columna Calculada DAX (`Género Etiqueta`) para traducir los códigos **0 y 1** a **Femenino y Masculino** para una visualización clara.
