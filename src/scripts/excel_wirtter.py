import sys
import json
from openpyxl import Workbook
import requests

def generate_excel_from_json(json_url, output_file):
    response = requests.get(json_url)

    if response.status_code == 200:
        products = response.json()

        wb = Workbook()
        ws = wb.active
        ws.title = "Products"

        headers = ["Código", "Nombre", "Stock Inicial", "Stock Final"]
        ws.append(headers)

        for product in products:
            ws.append([
                product['codigo'],
                product['nombre'],
                product['stock_inicial'],
                product['stock_final']
            ])

        wb.save(output_file)
        return True
    else:
        print(f"Error al descargar el archivo JSON: {response.status_code}")
        return False

def upload_file(file_path, upload_url):
    with open(file_path, 'rb') as file:
        response = requests.post(upload_url, files={'file': file})
        if response.status_code == 200:
            print("File uploaded successfully!")
        else:
            print(f"Failed to upload file. Status code: {response.status_code}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python python_script.py <output_file_path> <upload_url>")
        sys.exit(1)

    file_path = sys.argv[1]
    upload_url = sys.argv[2]
    json_url = 'http://192.168.1.8:8000/get-json'

    if generate_excel_from_json(json_url, file_path):
        print('Excel file created and saved successfully!')
        upload_file(file_path, upload_url)
    else:
        print('Failed to create Excel file.')
