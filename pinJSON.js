// Derived From https://github.com/PinataCloud/Pinata-SDK#hashMetadata-anchor
var jsonDoc = JSON.parse(process.argv[2]);
const pinataSDK = require('@pinata/sdk');
//const pinata = pinataSDK(TODO: PUBLIC KEY HERE, TODO: PRIVATE KEY HERE);
const fs = require('fs');
const options = {}

pinata.pinJSONToIPFS(jsonDoc, options).then((result) => {
    //handle results here
    console.log(result["IpfsHash"]);
}).catch((err) => {
    //handle error here
    console.log(err);
});