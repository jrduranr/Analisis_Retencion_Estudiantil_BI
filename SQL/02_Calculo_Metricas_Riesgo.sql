-- ******************************************************
-- PROYECTO 2: ANÁLISIS DE RETENCIÓN ESTUDIANTIL
-- SCRIPT 2.0: CÁLCULO DE MÉTRICAS CLAVE DE RIESGO
-- ******************************************************

-- 1. CREA LA TABLA LIMPIA Y DE MÉTRICAS
-- Esta tabla contendrá solo las variables relevantes y las métricas calculadas
IF OBJECT_ID('dbo.student_metrics_clean') IS NOT NULL 
    DROP TABLE dbo.student_metrics_clean;

SELECT
    -- Identificadores y Factores de Riesgo Clave
    ROW_NUMBER() OVER (ORDER BY [Age at enrollment]) AS StudentID, -- ID único y estable
    [Course] AS Programa_Academico_ID,
    [Age at enrollment] AS Edad_Ingreso,
    [Gender] AS Genero_ID,
    [Daytime/evening attendance] AS Tipo_Asistencia, -- Incluye la columna que faltaba

    -- Factor Financiero (Traducción de 0/1)
    CASE
        WHEN [Tuition fees up to date] = 1 THEN 'Al Dia'
        ELSE 'Deudor'
    END AS Estado_Financiero,

    -- Traducción de la Variable Objetivo (Target)
    CASE
        WHEN Target = 'Dropout' THEN 'Desercion'
        WHEN Target = 'Enrolled' THEN 'Activo'
        WHEN Target = 'Graduate' THEN 'Graduado'
        ELSE 'Otro'
    END AS Estado_Final,

    -- ********* CÁLCULOS DE RENDIMIENTO *********

    -- A. Tasa de Éxito Curricular (Primer Semestre)
    -- Mide la proporción de unidades aprobadas respecto a las unidades matriculadas.
    -- Se usa NULLIF para evitar la división por cero si [enrolled] es 0.
    CAST([Curricular units 1st sem (approved)] AS DECIMAL(5,2)) / NULLIF(CAST([Curricular units 1st sem (enrolled)] AS DECIMAL(5,2)), 0) AS Tasa_Exito_1er_Semestre,

    -- B. Nota Promedio del 2do Semestre
    [Curricular units 2nd sem (grade)] AS Nota_Promedio_2do_Semestre,

    -- C. Factor de Riesgo Académico (Bandera)
    -- ALTO RIESGO si aprobó menos del 50% de las unidades matriculadas en el 1er semestre Y sigue 'Activo' (podría desertar).
    CASE
        WHEN [Curricular units 1st sem (approved)] < ([Curricular units 1st sem (enrolled)] / 2.0) THEN 'Alto Riesgo Académico'
        ELSE 'Bajo Riesgo Académico'
    END AS Factor_Riesgo_Academico

INTO dbo.student_metrics_clean -- Crea la tabla de salida limpia
FROM dbo.student
WHERE [Curricular units 1st sem (enrolled)] > 0; -- Excluye registros que no tomaron cursos.


