// SPDX-License-Identifier: MIT

pragma solidity 0.6.2;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract ticket is ERC721{
    //Address of Who Deployed Smart Contract
    address owner;
    //Number of Tickets Distributed
    uint256 public tokensMinted;
    //Total Revenue 
    uint256 totalRevenue;
    //Tiers 
    string[] public allTiers; 
    // How much each ticket at each tier costs 
    mapping(string => uint256) public tierPricing;
    // How many tickets are still available in each tier 
    mapping(string => int) public tierCount;
    
    
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

    constructor() ERC721 ("Ticket", "TIX"){
        owner = msg.sender;
    }
    
    //Allows Anyone To Buy a Ticket as They are Available
    function purchaseTicket(string memory tier) public payable {
        require(msg.value >= tierPricing[tier], "Insufficient Funds");
        require( tierCount[tier] > 0, "No More Tickets Available");
        //Transfer Funds 
        //address contractAddress = address(this);
        bool checkTransfer;
        
        checkTransfer = payable(msg.sender).send(msg.value - tierPricing[tier]);
        require(checkTransfer, "Couldn't send excess funds back");
        
        checkTransfer = payable(owner).send(tierPricing[tier]);
        require(checkTransfer, "Couldn't recieve funds");
        
        
        totalRevenue += tierPricing[tier];
        
        //Mint Ticket
        //TODO: tokenURI -> IPFS store JSON metadata
        _mint(msg.sender, tokensMinted);
        _setTokenURI(newItemId, tokenURI);
        tokensMinted += 1;
        
    }
    
    //Allows the Owner To Add A Tier 
    function addTier(string memory tier, uint256 cost, int count) public onlyOwner{
        require(tierCount[tier] == 0, "Tier Has Already Been Created");
        allTiers.push(tier);
        tierPricing[tier] = cost;
        tierCount[tier] = count;
    }
    
    //Modify The Cost of Tickets of An Existing Tier 
    function modifyCostTier(string memory tier, uint256 newPrice) public onlyOwner{
        require(tierCount[tier] != 0, "No More Tickets Available or Tier Doesn't Exist");
        tierPricing[tier] = newPrice;
    }
    
    //Modify The Number of Tickets of An Existing Tier 
    function modifyCountTier(string memory tier, int newCount) public onlyOwner{
        require(tierCount[tier] != 0, "No More Tickets Available or Tier Doesn't Exist");
        tierCount[tier] = newCount;
    }
    
    function widthrawRevenue() public onlyOwner{
        bool checkTransfer = payable(owner).send(totalRevenue);
        require(checkTransfer, "Unable To Retrieve all Funds");
    }
}