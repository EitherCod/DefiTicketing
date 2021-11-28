import subprocess
import sys
import pyqrcode
import os
import pandas as pd

eventName = sys.argv[1]
tierTickets = sys.argv[2]
currentCount = int(sys.argv[3])
numToCreate = int(sys.argv[4])
numCreated = 0
catalog = "catalog.csv"


#Create Test JSON File For The Ticket Info
node_path = "/usr/local/bin/node"
startOfUrl = "https://ipfs.io/ipfs/"

if os.path.exists(catalog):
    df = pd.read_csv(catalog)
else:
    df = pd.DataFrame(columns=["TicketID", "Event Name", "Tier of Ticket", "IPFSURL" ])


while numCreated < numToCreate:
    jsonString = '{{"Event Name" : "{}", "Tier Of Ticket": "{}", "TicketID": {}}}'.format(eventName, tierTickets, currentCount + numCreated)

    #Store the JSON to IPFS
    hashJSON = str(subprocess.check_output([f'{node_path}','./pinJSON.js', jsonString]))[2:-3]

    #create QR code
    jsonURL = startOfUrl + hashJSON
    QRCode = pyqrcode.create(jsonURL)
    QRCode.png("QRTicket.png", scale = 6)

    #store QR Code on IPFS
    hashQR = str(subprocess.check_output([f'{node_path}','./pinImg.js', "./QRTicket.png"]))[2:-3]
    qrURL = startOfUrl + hashQR

    jsonString = '{{"Event Name" : "{}", "Tier Of Ticket": "{}", "TicketID": {}, "QRURL": "{}"}}'.format(eventName, tierTickets, currentCount + numCreated, qrURL)
    hashJSON = str(subprocess.check_output([f'{node_path}','./pinJSON.js', jsonString]))[2:-3]

    #Dont append if this is a rerun
    if numCreated + currentCount not in df["TicketID"]:
        catalogRow = {"TicketID": currentCount + numCreated, "Event Name": eventName, "Tier of Ticket": tierTickets, "IPFSURL" : startOfUrl + hashJSON}
        df = df.append(catalogRow, ignore_index=True)

    print("Token {} has been uploaded to IPFS".format(numCreated + currentCount))
    numCreated += 1

df.to_csv(catalog)
print("Next NFT Ticket Created Must Have ID {}".format(currentCount + numCreated))

