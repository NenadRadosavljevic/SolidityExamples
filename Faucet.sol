// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.4.19;

contract Faucet {


// Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
    // Limit withdrawal amount
        require(withdraw_amount <= 100000000000000000);

        // Send the amount to the address that requested it
        msg.sender.transfer(withdraw_amount);
    }

    // Accept any incoming amount
    function () public payable {}
}
