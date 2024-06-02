import pandas as pd
import json

excelPath = 'src\\files\\inventario.xlsx'

# Lee solo las columnas necesarias del archivo Excel
df = pd.read_excel(excelPath, usecols=["Código", "Nombre", "Stock"])

# Convierte el DataFrame a un diccionario
products_dict = df.to_dict(orient='records')

# Exporta a un archivo .json
with open('productos.json', 'w') as json_file:
    json.dump(products_dict, json_file)


# Main para imprimir la tabla
def main():
    # Lee el archivo JSON
    with open('productos.json', 'r') as f:
        products = json.load(f)

    # Imprime la tabla
    print("Código\tNombre\tStock")
    for product in products:
        print(f"{product['Código']}\t{product['Nombre']}\t{product['Stock']}")

if __name__ == "__main__":
    main()
