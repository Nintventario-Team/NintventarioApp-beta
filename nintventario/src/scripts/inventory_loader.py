import pandas as pd
import json

# Leer el archivo Excel
excel_file = 'src\\files\\inventario.xlsx'  # Reemplaza con el nombre de tu archivo Excel
df = pd.read_excel(excel_file, skiprows=5)

# Mostrar los nombres de las columnas para verificar
print("Columnas en el DataFrame:", df.columns)

# Limpiar los nombres de las columnas para asegurarse de que no haya espacios en blanco adicionales
df.columns = df.columns.str.strip()

# Imprimir las primeras 20 filas del DataFrame para comprobar que se lee bien
print("Primeras 20 filas del DataFrame:")
print(df.head(20))

# Seleccionar las columnas necesarias (asegurarse de que los nombres coincidan exactamente)
filtered_df = df[['Código', 'Nombre', 'Stock Final']]

# Renombrar las columnas
filtered_df.columns = ['codigo', 'nombre', 'stock']

# Convertir el DataFrame a una lista de diccionarios
data = filtered_df.to_dict(orient='records')

# Variable para el path específico del archivo JSON
json_file_path = 'src\\files\\inventario.json'  # Reemplaza con el path específico donde quieres guardar el JSON

# Guardar los datos en un archivo JSON
with open(json_file_path, 'w') as f:
    json.dump(data, f, indent=4)

print(f"Datos guardados en {json_file_path}")

# Imprimir las columnas 'codigo', 'nombre' y 'stock'
print("Código\tNombre\tStock")
for item in data:
    print(f"{item['codigo']}\t{item['nombre']}\t{item['stock']}")
