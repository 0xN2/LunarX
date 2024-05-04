// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Vesting} from "./Vesting.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Using SafeTransfer in all transfer


contract Dex is ReentrancyGuard, Ownable {
    //address payable public owner;

    IERC20 private  tokenX;
    IERC20 private  usdt;
    
    address vestingAddress= 0x3A282826128170Bfff3c9a60b863a06138850222; 

    Vesting private vestingContract = Vesting(vestingAddress);

    uint256 private constant tokenX_PRICE_IN_USDT = 100;

    // keeps track of individuals' tokenX balances
    mapping(address => uint256) public tokenXBalances;

    // keeps track of individuals' USDC balances
    mapping(address => uint256) public usdtBalances;



/// @dev tokens ERC20
// @param tokenX token to delivery, ERC20 with 18 decimals
// @param usdT ERC20 with 6 decimals

    constructor(address payable initialOwner, address _vestingAddress, address _tokenX) Ownable(initialOwner) {
        //owner = (initialOwner);   //payable(msg.sender);
        tokenX = IERC20(_tokenX);
        usdt = IERC20(0x72441784AeAFDb42a26880FE4b6e17370029a16c);    
        vestingAddress = _vestingAddress;
    }

    function depositUSDTandReciveToken(uint256 _amount) nonReentrant public {
        usdtBalances[msg.sender] += _amount;

        uint256 allowance = usdt.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");
        usdt.transferFrom(msg.sender, address(this), _amount);
        
        uint256 tokenToReceive = ((usdtBalances[msg.sender] *
            tokenX_PRICE_IN_USDT) * 1e12);
            usdtBalances[msg.sender] -= _amount;
        tokenX.transfer(address(vestingContract), tokenToReceive);
        address beneficiary = msg.sender;
        vestingContract.lock(tokenToReceive, beneficiary);

    }

    function getBalance(address _tokenAddress) public view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) public onlyOwner {
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }
}

