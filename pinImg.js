// Derived From https://github.com/PinataCloud/Pinata-SDK#hashMetadata-anchor
var imgPath = process.argv[2];
const pinataSDK = require('@pinata/sdk');
//const pinata = pinataSDK(TODO: PUBLIC KEY HERE, TODO: PRIVATE KEY HERE);
const fs = require('fs');
const readableStreamForFile = fs.createReadStream(imgPath);
const options = {}

pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
    //handle results here
    console.log(result["IpfsHash"]);
}).catch((err) => {
    //handle error here
    console.log(err);
});