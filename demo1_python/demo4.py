import requests

url = "https://petstore.swagger.io/v2/pet/789/uploadImage"

payload = {'additionalMetadata': 'image/jpg'}
files=[
  ('file',('demo.jpg',open('C:\\Users\\Balaji_Dinakaran\\Pictures\\demo.jpg','rb'),'image/jpeg'))
]
headers = {}

response = requests.request("POST", url, headers=headers, data=payload, files=files)

print(response.text)
