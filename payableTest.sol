// SPDX-License-Identifier: no licence
pragma solidity >=0.8.11;

error EtherTransferFailed();

contract payableTest {

    uint public depositAmount;
    address immutable ethReceiver;

    
    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    constructor(address _ethReceiver) payable {
        depositAmount += msg.value;
        ethReceiver = _ethReceiver;
    }   

    function depositETH() payable external {
        depositAmount += msg.value;
    }

    function sendETH() external {
        (bool success,) = payable(ethReceiver).call{value:depositAmount}("");
        if (!success) {
            revert EtherTransferFailed(); 
        } 

        depositAmount = 0;
    }

    function send() external {
       // bool success = payable(ethReceiver).send(depositAmount);
        bool success = payable(msg.sender).send(depositAmount);
        if (!success) {
            revert EtherTransferFailed(); 
        } 
        depositAmount = 0;
    }

    function test() external {
        depositAmount += 100;
    }

    function testP() external payable {
        depositAmount += 100;
    }
}
