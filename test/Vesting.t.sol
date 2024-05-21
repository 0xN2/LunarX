// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../src/Vesting.sol";
import "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract VestingTest is Test {
    Vesting vesting;
    ERC20Mock token;
    address owner = address(0x1);
    address beneficiary = address(0x2);
    address dexAddress = address(0x3);
    uint256 expiryDuration = 1 weeks;

    function setUp() public {
        token = new ERC20Mock();
        vm.prank(owner);
        vesting = new Vesting(address(token), expiryDuration, owner);

        // Mint tokens to owner
        token.mint(owner, 10 ether);

        // Transfer some tokens to the contract
        vm.prank(owner);
        token.transfer(address(vesting), 10 ether);
        
    }

    function testLockTokens() public {
        vm.startPrank(owner);
        vesting.setDexAddress(dexAddress);
        vesting.lock(10 ether, beneficiary);
        vm.stopPrank();

        assertEq(vesting.getBeneficiaryAmount(beneficiary), 10 ether);
    }

    function testWithdrawTokens() public {
        // Lock tokens first
        vm.startPrank(owner);
        vesting.setDexAddress(dexAddress);
        vesting.lock(10 ether, beneficiary);
        vm.stopPrank();

        // Move time forward to after the expiry
        vm.warp(block.timestamp + expiryDuration + 1);

        // Beneficiary withdraws tokens
        vm.startPrank(beneficiary);
        vesting.withdraw();
        vm.stopPrank();

        assertEq(token.balanceOf(beneficiary), 10 ether);
    }

    function testEmergencyWithdrawal() public {
        vm.startPrank(owner);
        uint256 initialOwnerBalance = token.balanceOf(owner);
        vesting.withdrawEmergencyTokens(10 ether);
        assertEq(token.balanceOf(owner), initialOwnerBalance + 10 ether);
    }

    function testPauseUnpause() public {
        vm.startPrank(owner);
        vesting.setDexAddress(dexAddress);
        vesting.pause();
        vm.expectRevert(0xd93c0665);
        vesting.lock(10 ether, beneficiary);
        vesting.unpause();
        vesting.setDexAddress(dexAddress);
        vesting.lock(10 ether, beneficiary);
        assertEq(vesting.getBeneficiaryAmount(beneficiary), 10 ether);
    }

    function testWithdrawWhenPaused() public {
        // Lock tokens first
        vm.startPrank(owner);
        vesting.setDexAddress(dexAddress);
        vesting.lock(10 ether, beneficiary);
        vm.stopPrank();

        // Move time forward to after the expiry
        vm.warp(block.timestamp + expiryDuration + 1);

        // Pause the contract
        vm.startPrank(owner);
        vesting.pause();
        vm.stopPrank();

        // Beneficiary tries to withdraw tokens when paused
        vm.startPrank(beneficiary);
        vm.expectRevert(0xd93c0665);
        vesting.withdraw();
        vm.stopPrank();
        
        vm.startPrank((owner));
        vesting.unpause();
        vm.stopPrank();
    }

    function testSetDexAddress() public {
        vm.startPrank(owner);
        vesting.setDexAddress(dexAddress);
        vm.stopPrank();
        // assertEq(vesting.dexAddress(), dexAddress);
    }
}
