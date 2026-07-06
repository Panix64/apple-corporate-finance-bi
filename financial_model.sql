-- ========================================================
-- PROYECTO 2: CORPORATE FINANCE (APPLE INC.)
-- STEP 2: MODELADO Y CREACIÓN DE VISTAS ANALÍTICAS (SQL)
-- ========================================================

-- 1. Tabla para los ingresos
CREATE TABLE IF NOT EXISTS apple_income (
    year TEXT PRIMARY KEY,
    total_revenue REAL,
    net_income REAL
);

-- 2. Tabla para los activos totales
CREATE TABLE IF NOT EXISTS apple_assets (
    year TEXT PRIMARY KEY,
    current_assets REAL,
    non_current_assets REAL,
    total_assets REAL,
    FOREIGN KEY (year) REFERENCES apple_income(year)
);

-- 3. VISTA DE NEGOCIO: Filtrada y con métricas precalculadas para Power BI
DROP VIEW IF EXISTS v_apple_clean_metrics;

CREATE VIEW v_apple_clean_metrics AS
SELECT 
    i.year AS ANIO,
    i.total_revenue AS VENTAS_MILLONES,
    i.net_income AS BENEFICIO_NETO_MILLONES,
    a.total_assets AS ACTIVOS_TOTALES_MILLONES,
    -- Cálculo del Margen Neto
    ROUND((i.net_income / i.total_revenue) * 100, 2) AS MARGEN_NETO_PORCENTAJE,
    -- Cálculo del ROA
    ROUND((i.net_income / a.total_assets) * 100, 2) AS ROA_PORCENTAJE
FROM apple_income i
INNER JOIN apple_assets a ON i.year = a.year
WHERE i.year != 'TTM'; -- Aquí blindamos los datos quitando el TTM duplicado