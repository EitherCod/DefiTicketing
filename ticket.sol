// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "hardhat/console.sol";

//Ticket NFT Code
contract ticket is ERC721, Ownable{
    mapping(uint256 => string) private _tokenURI;
    string private _rootURI;

    constructor() ERC721("NFTIX", "TIX") {
    }

    function setRootURI(string memory rootURI) external onlyOwner{
        _rootURI = rootURI;
    }

    function giveManagerAccess(address managerAddress) public onlyOwner{
        transferOwnership(managerAddress);
    }

    function _setTokenURI(uint256 id, string memory URI) internal{
        require(_exists(id), "Ticket Has Not Been Minted");
        _tokenURI[id] = URI;
    }

    function tokenURI(uint256 id) public view virtual override returns(string memory){
        require(_exists(id), "Ticket Has Not Been Minted");
        string memory URI = _tokenURI[id];
        string memory divider = '/';
        return string(abi.encode(_rootURI, divider, URI));
    }

    function mint(address to, string memory URI, uint256 tokenID) external onlyOwner{
        require(!_exists(tokenID), "Token ID Has Been Used");
        _mint(to, tokenID);
        _setTokenURI(tokenID, URI);
    }
}