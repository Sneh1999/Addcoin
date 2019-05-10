pragma solidity ^0.4.11;



contract addcoin_ico {
    
    // INtroducing the maximum number od addcoins available for sealed
    uint public max_adcoins = 1000000;
    
    // Introducing the USD to addcoins conversion rate
uint public usd_to_addcoins = 1000;

//Introducing the total number of addcoins that have been bought by the investors
uint public total_addcoins_bought = 0;

//Mapping from the investors address to its equity in addcoins and USD
mapping(address => uint) equity_addcoins;
mapping(address => uint) equity_usd;

// Checking if an investor can buy equity_addcoins
modifier can_buy_addcoins(uint usd_invested){
    require (usd_invested * usd_to_addcoins + total_addcoins_bought <= max_adcoins);
    _;
    
}

//Getting the equity in addcoins of an investor 
function equity_in_addcoins(address investor) external constant returns (uint){
    return equity_addcoins[investor];
    
    
}

function equity_in_usd(address investor) external constant returns (uint){
    return equity_usd[investor];
    }
    
    //Buying addcoins
    function buy_addcoins(address investor,uint usd_invested) external  
    can_buy_addcoins(usd_invested) {
        uint addcoins_bought = usd_invested * usd_to_addcoins;
        equity_addcoins[investor] += addcoins_bought;
        equity_usd[investor] = equity_addcoins[investor] / 1000 ;
        total_addcoins_bought += addcoins_bought;
        
    }
    
    //Selling addcoins
    
      function sell_addcoins(address investor,uint addcoins_sold) external {
      
        equity_addcoins[investor] -= addcoins_sold;
        equity_usd[investor] = equity_addcoins[investor] / 1000 ;
        total_addcoins_bought -= addcoins_sold; 
        
    }
    
    

}