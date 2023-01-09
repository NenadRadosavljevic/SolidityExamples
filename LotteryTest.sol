//SPDX-License-Identifier: Unlicense
pragma solidity >0.8.0;

import "hardhat/console.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract Lottery {

     address public manager;
     address payable[] public participants;
     using Strings for uint;

     constructor() {
         manager = msg.sender;
     }

     receive() external payable {
         require(msg.value == 1 ether, "Participants must deposit 1 Ether !");
         require(msg.sender != manager, "Manager can't participate in lottery !");
         participants.push(payable(msg.sender));
     }

     function getBalance() public view returns(uint) {
         require(manager == msg.sender, "Not called by manager!");
         return address(this).balance;
     }

    function random() public view returns(uint){
         console.log("block.difficulty", block.difficulty);
         console.log("block.timestamp", block.timestamp);
         console.log("participants", participants.length);

        console.log("----------------------------------------");
        //string memory str = string(abi.encodePacked(block.difficulty));
        string memory str = block.difficulty.toHexString();
        console.log("Hex block.difficulty: ", str);
        str = block.timestamp.toHexString();
        console.log("Hex block.timestamp: ", str);
        str = participants.length.toHexString();
        console.log("participants", str);

       // bytes memory tmpByteArray = abi.encodePacked(block.difficulty, block.timestamp, participants.length);
    //    str = string(tmpByteArray);
       // console.log("Encoded packed: ", iToHex(tmpByteArray));

         return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));
    }

    function pickWinner() external returns(address winner){
        require(manager == msg.sender, "Not called by manager!");
        require(participants.length >= 3, "At least three people are required to pick the winner of the lottery.");

        uint winnerIndex = random() % participants.length;
        console.log("Winner index is: ", winnerIndex);
        winner = address(participants[winnerIndex]);

        delete participants;
        payable(winner).transfer(getBalance());
       
        // participants = new address payable[](0);      
    }

    function allocateOldArray() public {
        participants = new address payable[](3);
    }

    function iToHex(bytes memory buffer) public pure returns (string memory) {

        // Fixed buffer size for hexadecimal convertion
        bytes memory converted = new bytes(buffer.length * 2);

        bytes memory _base = "0123456789abcdef";

        for (uint256 i = 0; i < buffer.length; i++) {
            converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
            converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
        }

        return string(abi.encodePacked("0x", converted));
    }

}

