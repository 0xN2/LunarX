// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/Vesting.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 import "forge-std/Vm.sol";

contract MockToken is ERC20 {
    constructor() ERC20("MockToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }
}

contract VestingTest is Test {
    Vesting vesting;
    MockToken token;
    address beneficiary;
      

    function setUp() public {
        token = new MockToken();
        beneficiary = address(0x1);
        vesting = new Vesting(address(token), 365 days, payable(address(this)));

        // Grant the Vesting contract some tokens to work with
        token.transfer(address(vesting), 500000 * 10 ** 18);
    }

    function testLock() public {
        uint256 amountToLock = 1000 * 10 ** 18;

        // Act as the owner of the contract
        vm.startPrank(address(this));

        vesting.lock(amountToLock, beneficiary);
        
        // Check the locked amount is correct
        uint256 lockedAmount = vesting.getBeneficiaryAmount(beneficiary);
        assertEq(lockedAmount, amountToLock, "Locked amount is incorrect.");

        vm.stopPrank();
    }

    function testWithdraw() public {
        uint256 amountToLock = 1000 * 10 ** 18;

        // Act as the owner and lock some tokens
        vm.startPrank(address(this));
        vesting.lock(amountToLock, beneficiary);
        vm.stopPrank();

        // Fast forward time to after the expiry
        vm.warp(block.timestamp + 366 days);

        // Act as the beneficiary
        vm.startPrank(beneficiary);
        vesting.withdraw();

        // Check the beneficiary received the tokens
        uint256 balance = token.balanceOf(beneficiary);
        assertEq(balance, amountToLock, "Withdrawal amount is incorrect.");
        vm.stopPrank();
    }
function testFailWithdrawEarly() public {
        uint256 amount = 500 ether;
        token.transfer(address(vesting), amount);
        vesting.lock(amount, beneficiary);
        vm.warp(block.timestamp + 1 hours);  // Use the existing `vm` instance
        vesting.withdraw();
    }
   
}
