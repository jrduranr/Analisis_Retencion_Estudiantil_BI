----------------------------------------------script para crear la base de datos --------------------------------------------------
CREATE DATABASE Retencion_Estudiantil_DB;
GO 
USE Retencion_Estudiantil_DB;


----------------------------------------------script para crear las tablas de la base de datos --------------------------------------------------

-- Crea la tabla con los tipos de datos optimizados
CREATE TABLE dbo.student_data_raw (
    [Marital status] INT,
    [Application mode] INT,
    [Application order] INT,
    [Course] INT,
    [Daytime/evening attendance] INT,
    [Previous qualification] INT,
    [Nacionality] INT,
    [Mother's qualification] INT,
    [Father's qualification] INT,
    [Mother's occupation] INT,
    [Father's occupation] INT,
    [Displaced] INT,
    [Educational special needs] INT,
    [Debtor] INT,
    [Tuition fees up to date] INT,
    [Gender] INT,
    [Scholarship holder] INT,
    [Age at enrollment] INT,
    [International] INT,
    
    -- Unidades curriculares y notas (necesitan ser decimales o numéricos)
    [Curricular units 1st sem (credited)] INT,
    [Curricular units 1st sem (enrolled)] INT,
    [Curricular units 1st sem (evaluations)] INT,
    [Curricular units 1st sem (approved)] INT,
    [Curricular units 1st sem (grade)] DECIMAL(5,2),
    [Curricular units 1st sem (without evaluations)] INT,
    
    [Curricular units 2nd sem (credited)] INT,
    [Curricular units 2nd sem (enrolled)] INT,
    [Curricular units 2nd sem (evaluations)] INT,
    [Curricular units 2nd sem (approved)] INT,
    [Curricular units 2nd sem (grade)] DECIMAL(5,2),
    [Curricular units 2nd sem (without evaluations)] INT,
    
    -- Variables económicas y de entorno
    [Unemployment rate] DECIMAL(4,2),
    [Inflation rate] DECIMAL(4,2),
    [GDP] DECIMAL(4,2),
    
    -- Variable Objetivo
    [Target] VARCHAR(10)
);