CS 194-177: Implimenting ticketing in Solidity

File: ticket.sol
This file contains the smart contracts for the tickets. For security reasons, make sure to give the deployed ticketManager contract ownership with the method giveManagerAccess to ensure the only way the tickets are interacted with is through the ticketManager contract. This smart contract is a ERC721 instance as the tickets are intended to used as NFTs. 

File: ticketManager.sol
In our system there will be multiple tier for an event and each tier of ticket will cost a different amount. Functions that allow the owner of the contract to set up tiers and modify them have been created. At the start all ticket NFTS will be minted and in the contracts ownership. Anyone can purchase tickets and the NFT will be given to them as long as they have the funds. Each ticket will have a URI which points to a JSON file witch is stored on IPFS. 

File IPFSUpload.py
This file is a test implimentation of how to interact with IPFS and store QR Codes and metadata. It calls two JS programs: pinImg pins an image to IPFS and pinJSON pins meta data to to the IPFS. The general structure is:
1) We create the meta data JSON for the NFT looks like '{"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1}'
2) Create a QRCode to point to the URL of the JSON document and also store it to IPFS 
3) Create a final meta data JSON that looks like  {"Event Name" : "Restaurant Opening Event", "Tier Of Ticket": "VIP", "TicketID": 1, "QRURL": "https://ipfs.io/ipfs/QmS9U2bJDB5MZGkxyPMz2BvTBCRVx3dZjdN8CMG7HwDiZd "}.

Make sure to enter your public and private key for the Pinata API line 4 in pinImg.js and pinJSON.js so you can upload to IPFS from your account 

You can try to modify pinImg.js to upload test.png and test2.png to your account

Example Command Structure: python3 IPFSUpload.py EventName TierOfTicket CurrentCount NumberToCreate 

EventName: The Event The Ticket Corresponds To 
TierOfTicket: The Tier of The Ticket
CurrentCount: Number of Tickets Already Uploaded to IPFS 
NumberToCreate: Number of Tickets To Be Generated

A CSV file named catalog.csv will also be generated so users can keep track of which tokens have been generated.


General Work Flow 
1) Use IPFSUpload.py to upload many tickets onto IPFS and automatically generate the URI's in the proccess
2) Deploy the ticket.sol smart contract
3) Deploy the ticketManager.sol smart contract, which takes in the address of ticket.sol as a parameter
4) Call giveManagerAccess on the ticket smart contract to trasfer owernship to the manager smart contract 
5) Call addTier to make tiers of tickets in ticketManager.sol 
6) Use the mint function to create NFTs and pass in the URI's generated from IPFS.upload
7) Anyone can now call purchaseTicket to buy ticket NFTs! 

Testing
Mainly using Remix IDE to manually test the contract functionality and also tried it on the RinkeBy TestNet



