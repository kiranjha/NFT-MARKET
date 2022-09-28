//Contracts/ERC1155BarbiesDress.sol
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
contract NftMarket{
    mapping(address => mapping(uint256 => Listing)) public listing;
    mapping(address => uint256) public balances;
    struct Listing{
        uint256 price;
        address seller;
    }
    enum state{Created, Release}
    state public nftState;
    function addListing(uint256 price, address contractAddr, uint256 tokenId) public {
        ERC1155 token = ERC1155(contractAddr);
        require(token.balanceOf(msg.sender,tokenId)>0,"Caller must own given token");
        require(token.isApprovedForAll(msg.sender,address(this)),"Contract must be Approved");

        listing[contractAddr][tokenId] = Listing(price,msg.sender);
        nftState = state.Created;
    }
    function purchase(address contractAddr, uint256 tokenId, uint256 amount) public payable{
        Listing memory item = listing[contractAddr][tokenId];
        require(msg.value >= item.price*amount,"Insufficient funds sent");
        balances[item.seller]+=msg.value;

        ERC1155 token = ERC1155(contractAddr);
        token.safeTransferFrom(item.seller,msg.sender,tokenId,amount,"");
        nftState = state.Release;
    }
    function withdraw(uint256 amount, address payable destAddr) public{
        require(amount <= balances[msg.sender], "Insufficient funds");
        destAddr.transfer(amount);
        balances[msg.sender] -=amount;
    }
}
