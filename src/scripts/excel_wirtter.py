import json
from openpyxl import Workbook
import requests

# URL del archivo JSON en el servidor Django
json_url = 'http://192.168.1.8:8000/get-json'

# Hacer la solicitud HTTP para descargar el archivo JSON
response = requests.get(json_url)

if response.status_code == 200:
    products = response.json()

    # Crear un nuevo libro de trabajo y seleccionar la hoja activa
    wb = Workbook()
    ws = wb.active
    ws.title = "Products"

    # Escribir los encabezados
    headers = ["Código", "Nombre", "Stock Inicial", "Stock Final"]
    ws.append(headers)

    # Escribir los datos del producto
    for product in products:
        ws.append([
            product['codigo'],
            product['nombre'],
            product['stock_inicial'],
            product['stock_final']
        ])

    # Guardar el archivo Excel
    wb.save("products.xlsx")
    print("Archivo Excel guardado como 'products.xlsx'")
else:
    print(f"Error al descargar el archivo JSON: {response.status_code}")
