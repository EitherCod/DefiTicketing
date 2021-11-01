import subprocess
import webbrowser
import pyqrcode
from pyqrcode import QRCode

#Create Test JSON File For The Ticket Info
node_path = "/usr/local/bin/node"
startOfUrl = "https://ipfs.io/ipfs/"
jsonString = '{"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1}'

#Store the JSON to IPFS
hashJSON = str(subprocess.check_output([f'{node_path}','./pinJSON.js', jsonString]))[2:-3]

#create QR code
jsonURL = startOfUrl + hashJSON
QRCode = pyqrcode.create(jsonURL)
QRCode.png("QRTicket.png", scale = 6)

#store QR Code on IPFS
hashQR = str(subprocess.check_output([f'{node_path}','./pinImg.js', "./QRTicket.png"]))[2:-3]

jsonString = '{"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1, "QRURL": "' + startOfUrl + hashQR + '"}'
print("JSON STRING ", jsonString)

hashJSON = str(subprocess.check_output([f'{node_path}','./pinJSON.js', jsonString]))[2:-3]

webbrowser.open(startOfUrl + hashJSON)