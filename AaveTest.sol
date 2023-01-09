// SPDX-License-Identifier: MIT
pragma solidity >=0.8.11;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

interface IWETHGateway {
    function depositETH(
    address lendingPool,
    address onBehalfOf,
    uint16 referralCode
    ) external payable;

    function withdrawETH(
    address lendingPool,
    uint256 amount,
    address onBehalfOf
    ) external;

    function getWETHAddress() external returns(address);
}

interface ILendingPool {
    function getUserAccountData(address user)
    external
    view
    returns (
    uint256 totalCollateralETH,
    uint256 totalDebtETH,
    uint256 availableBorrowsETH,
    uint256 currentLiquidationThreshold,
    uint256 ltv,
    uint256 healthFactor
    );
}

contract SampleContract {
    //IWETHGateway interface for the Goerli testnet
    IWETHGateway public iWethGateway = IWETHGateway(0xd5B55D3Ed89FDa19124ceB5baB620328287b915d);
    //ILendingPool interface
    ILendingPool public iLendingPool = ILendingPool(lendingPoolAddress);
    //Lending Pool address for the Aave (v3) lending pool on Goerli testnet
    /// Retrieve LendingPool address
  //  LendingPoolAddressesProvider provider = LendingPoolAddressesProvider(address(0xc4dCB5126a3AfEd129BC3668Ea19285A9f56D15D)); // mainnet address, for other addresses: https://docs.aave.com/developers/deployed-contracts/deployed-contract-instances 
  //  LendingPool lendingPool = LendingPool(provider.getLendingPool());
    address public constant lendingPoolAddress = 0x368EedF3f56ad10b9bC57eed4Dac65B26Bb667f6;
    //Contract Address for the aWeth tokens generated after depositing ETH to keep track of the amount deposited in lending pool
    address public constant aWethAddress = 0x27B4692C93959048833f40702b22FE3578E77759;
   // address public immutable aWethAddress; // = iWethGateway.getWETHAddress();
    address public owner;

    constructor() payable {
    owner = msg.sender;
    // aWethAddress = iWethGateway.getWETHAddress();
    }

    function stakeEther() external payable {
    //Deposit ETH via WETHGateway
    //It will convert ETH to WETH and also send funds to the lending pool
    iWethGateway.depositETH{value: msg.value}(lendingPoolAddress, address(this), 0);
    }

    function withdrawEther(uint _amount) external {
    //Withdraw lended funds via the Weth Gateway
    //It will convert back the WETH to ETH and send it to the contract
    //Ensure you set the relevant ERC20 allowance of aWETH, before calling this function, so the WETHGateway contract can burn the associated aWETH
    IERC20(aWethAddress).approve(address(iWethGateway), type(uint256).max);
    iWethGateway.withdrawETH(lendingPoolAddress, _amount, address(this));
    }

    //To check the balance of aWeth tokens for our contract address
    function getContractAWETHBalance() external view returns(uint) {
    return IERC20(aWethAddress).balanceOf(address(this));
    }

    //Receive function is needed because withdrawETH is sending funds to the contract without call data
    receive() external payable {
    }
}


