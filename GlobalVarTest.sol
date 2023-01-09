// SPDX-License-Identifier: unlicensed
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract GlobalVarTest {
    string public name;
    uint public count;

   constructor(string memory _name, uint _initCount) public {
       name = _name;
       count = _initCount;
   }

   function increment() payable public {
       count++;
       console.log("Inkrementiran za 1, i nova vrednost je ", count);
       console.log("Ovo je value: ", msg.value);
   }
   
    function decrement() public {
       count--;
   }

   function getResult() public pure returns(uint){
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }

   function getBlockchainInfo() public view returns(address myAddress){
       address adrSender = msg.sender;
       console.log("Ovo je adresa mog account-a: ", adrSender);
       myAddress = adrSender;

        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
        console.log("Balance mog account-a: ", amount);

        console.log("Timestamp block-a: ", block.timestamp);
        console.log("Current block miner's address: ", block.coinbase);
        console.log("Current block difficulty: ", block.difficulty);
        console.log("Current block gaslimit: ", block.gaslimit);
        console.log("Current block number: ", block.number);
        console.log("Remaining gas: ", gasleft());
     //   console.log("Timestamp block-a: ", block.number);
     //   bytes memory _calldata = msg.data;
     //   string memory _strCallData = new string(_calldata);
     //   console.log("Complete calldata: ", _strCallData);
     //  console.log("First four bytes of the calldata (function identifier): ", string(msg.sig));

        console.log("Gas price of the transaction: ", tx.gasprice);
        console.log("Sender of the transaction: ", tx.origin);

        console.log("current chain id: ", block.chainid);
        console.log("current blocks base fee: ", block.basefee);
   }
}



