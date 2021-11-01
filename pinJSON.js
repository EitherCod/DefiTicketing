// Derived From https://github.com/PinataCloud/Pinata-SDK#hashMetadata-anchor
var jsonDoc = JSON.parse(process.argv[2]);
const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK('67f07684247a63277278', 'bf1ae6be55ca5f84286834474add67f8137d8713c86df381dddc82d264de7996');
const fs = require('fs');
const options = {}

pinata.pinJSONToIPFS(jsonDoc, options).then((result) => {
    //handle results here
    console.log(result["IpfsHash"]);
}).catch((err) => {
    //handle error here
    console.log(err);
});