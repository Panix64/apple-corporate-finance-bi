# ========================================================
# PROYECTO 2: CORPORATE FINANCE (APPLE INC.)
# STEP 4: AUDITORÍA Y CÁLCULO DE ROA VIA SQL
# ========================================================

import sqlite3
import pandas as pd

# 1. Conectar a la base de datos que acabas de crear
conn = sqlite3.connect('apple_corporate_finance.db')

# 2. La Query mágica de negocio: Cruzar ingresos y activos para calcular el ROA (%)
# Fórmula del ROA: (Beneficio Neto / Activos Totales) * 100
query = """    SELECT 
        i.year AS Año,
        i.total_revenue AS Ventas_M,
        i.net_income AS Beneficio_Neto_M,
        a.total_assets AS Activos_Totales_M,
        ROUND((i.net_income / a.total_assets) * 100, 2) AS ROA_Porcentaje
    FROM apple_income i
    INNER JOIN apple_assets a ON i.year = a.year
    WHERE i.year != 'TTM'; -- Quitamos el acumulado para ver solo años cerrados limpios
"""

# 3. Ejecutar la consulta y mostrarla bonita con Pandas
df_resultado = pd.read_sql_query(query, conn)
conn.close()

print("\n📊 --- REPORTE EJECUTIVO DE RENTABILIDAD (APPLE INC.) ---")
print(df_resultado)