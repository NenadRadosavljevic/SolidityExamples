// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    uint8 constant _decimals = 2; //18;
    uint256 constant _totalSupply = 10 * (10**3) * 10**_decimals;  // 10k tokens for distribution
  //  uint256 constant _totalSupply = 100 * (10**6) * 10**_decimals;  // 100m tokens for distribution

    constructor() ERC20("MyToken", "MYT") {        
        _mint(msg.sender, _totalSupply);
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }
}

