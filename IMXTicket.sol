// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./node_modules/@imtbl/imx-contracts/contracts/IMintable.sol";
import "./node_modules/@imtbl/imx-contracts/contracts/utils/Minting.sol";

abstract contract IMXTicket is Ownable, IMintable, ERC721 {
    address public imx;
    mapping(uint256 => bytes) public blueprints; // not sure if we need to store blueprints?
    mapping(uint256 => string) private _tokenURI;
    string private _rootURI;

    event AssetMinted(address to, uint256 id, bytes blueprint);

    constructor(address _imx) ERC721("NFTIX", "TIX") {
        imx = _imx;
    }

    modifier onlyIMX() {
        require(msg.sender == imx, "Function can only be called by IMX");
        _;
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
    
    function mintFor(
        address user,
        uint256 quantity,
        bytes calldata mintingBlob
    ) external override onlyIMX {
        require(quantity == 1, "Mintable: invalid quantity");
        (uint256 tokenID, bytes memory blueprint) = Minting.split(mintingBlob);
        _mintFor(user, id, blueprint);
        blueprints[id] = blueprint;
        emit AssetMinted(user, id, blueprint);
    }

    function _mintFor(
        address to,
        uint256 id,
        bytes memory blueprint
    ) internal override {
      require(!_exists(id), "Token ID Has Been Used");
      string memory URI = string(blueprint); // for now define blueprint as URI
      _safeMint(to, id);
      _setTokenURI(tokenID, URI);
    }
}
