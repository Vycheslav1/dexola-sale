// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";


contract Tokensale is ERC20, ERC20Permit {

     uint256 public token_amount;

     uint256 public token_sale_limit;

      address public owner;

     bool public isPaused;

     uint public token_price;

     uint256 public start_sale_time;

      uint256 public finish_sale_time;

     uint256 public pause;

     uint256 public start_pause;

     uint256 public finish_pause;

     uint256 public tokens_sold;

     modifier onlyOwner(){
         require(msg.sender == owner, "Only the contract owner can call this function.");
        _;
     }

      modifier whenNotPaused() {
       require(isPaused!=true, "Pausable: not paused");
       _;
   }

      constructor() ERC20("Token Sale", "TKS") ERC20Permit("Tokensale") {
        _mint(msg.sender, 50000000* (10 ** uint256(decimals())));
        owner=msg.sender;
       token_amount=50000000;
       token_sale_limit=50000;
       isPaused=false;
       tokens_sold=0;
       }
   
   

    function setTokenPrice(uint256 price) external onlyOwner{

      token_price=price;
    }

    function setPaused(bool paused) external onlyOwner{
     isPaused=paused;
     if(paused==false) {
     pause=block.timestamp-start_pause;
     finish_sale_time+=pause;
     }
      
      if(paused==true) {
      start_pause=block.timestamp;
      }
       }

    function startSale(uint256 start) external onlyOwner{
        start_sale_time=start;
        finish_sale_time=start_sale_time+5 weeks;
    }

   

function tokenTransfer(address to,uint256 amount) external payable whenNotPaused onlyOwner{
require(block.timestamp<=finish_sale_time);
require(msg.sender!=to);
require(msg.sender.balance!=0);
require(to.balance!=0);
require(tokens_sold<=token_amount);
require(amount<=token_sale_limit);
tokens_sold+=amount;
_transfer(to, msg.sender, amount*token_price);

}
}