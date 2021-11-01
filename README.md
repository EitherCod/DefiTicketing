CS 194-177: Implimenting ticketing in Solidity

File: ticket.sol
This file contains the smart contracts for the tickets. In our system there will be multiple tier for an event and each tier of ticket will cost a different amount. Functions that allow the owner of the contract to set up tiers and modify them have been created. We have partially implimented selling the tickets to clients. The money transfer part of it works, but we still have to mint the NFTS. We want to store a QR code for each ticket but since it will be too expensive we will be using IDFS and storing it over there. Variables are currently public but implimenting view functions might be better for the future. 

File IPFSUpload.py
This file is a test implimentation of how to interact with IPFS and store QR Codes and metadata. It calls two JS programs: pinImg pins an image to IPFS and pinJSON pins meta data to to the IPFS. The general structure is:
1) We create the meta data JSON for the NFT looks like '{"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1}'
2) Create a QRCode to point to the URL of the JSON document and also store it to IDFS 
3) Create a final meta data JSON that looks like  {"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1, "QRURL": "https://ipfs.io/ipfs/QmS9U2bJDB5MZGkxyPMz2BvTBCRVx3dZjdN8CMG7HwDiZd"} (It stores the URL of the QR Code also) 


Make sure to enter your public and private key for the Pinata API line 4 in pinImg.js and pinJSON.js so you uplaod to IPFS from your account 

You can try to modify pinImg.js to uplaod test.png and test2.png to your account

Testing
Mainly using Remix IDE to manually test the contract functionality and also tried it on the RinkeBy TestNet



