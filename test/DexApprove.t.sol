// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/DexWithApprove.sol";
import "../src/Vesting.sol";
import "./ERC20mock.sol";
import "forge-std/console.sol";

contract DexTestApprove is Test {
    Dex dex;
    Vesting vesting;
    MockToken tokenX;
    MockToken2 usdt;
    address owner = address(0x1);
    address user = address(this);

    uint256 expiryDuration = 1 weeks;
    uint256 tokenXPriceInUsdt = 100;
    uint256 constant USER_PRIVATE_KEY = 2;

    function setUp() public {
        tokenX = new MockToken();
        usdt = new MockToken2();

        vesting = new Vesting(address(tokenX), expiryDuration, owner);
        dex = new Dex(owner, address(vesting), address(tokenX), address(usdt));
        console.log(address(dex));
        console.log(address(vesting));
        console.log(address(usdt));
        console.log(address(tokenX));
        console.log(address(this));

        vm.prank(address(user));

        usdt.approve(address(dex), 1000 ether);
        usdt.mint(address(user), 100e6);

        vm.prank(owner);

        vesting.setDexAddress(address(dex));
        usdt.mint(user, 100e6);

        // Mint tokens to vesting contract
        tokenX.mint(address(dex), 100000e18);
    }

    function testDepositUSDTandReceiveToken() public {
        uint256 amount = 1e6;
        console.log(address(dex));
        vm.prank(user);
        usdt.approve(address(dex), 1000 ether);
        dex.depositUSDTandReciveToken(amount);

        uint256 expectedTokenXAmount = amount * tokenXPriceInUsdt * 1e12;
        assertEq(vesting.getBeneficiaryAmount(user), expectedTokenXAmount);
    }

    function testGetBalance() public {
        uint256 amount = 10e6;

        vm.prank(user);
        usdt.approve(address(dex), 100e6);
        dex.depositUSDTandReciveToken(amount);

        assertEq(dex.getBalance(address(usdt)), 10e6);
    }

    function testWithdraw() public {
        uint256 amount = 10e6;

        vm.prank(user);
        usdt.approve(address(dex), 100e6);
        dex.depositUSDTandReciveToken(amount);

        vm.startPrank(owner);
        dex.withdraw(address(usdt));
        vm.stopPrank();

        assertEq(usdt.balanceOf(owner), 10e6);
    }

    function testPauseUnpause() public {
        vm.startPrank(owner);
        dex.pause();
        vm.expectRevert(0xd93c0665);
        dex.depositUSDTandReciveToken(100e6);
        dex.unpause();
        vm.stopPrank();

        uint256 amount = 100e6;

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount);
        assertEq(
            vesting.getBeneficiaryAmount(user),
            amount * tokenXPriceInUsdt * 1e12
        );
    }

    function testWithdrawWhenPaused() public {
        uint256 amount = 100e6;

        vm.prank(user);
        usdt.approve(address(dex), 100e6);
        dex.depositUSDTandReciveToken(amount);

        vm.startPrank(owner);
        dex.pause();
        dex.withdraw(address(usdt));
        vm.stopPrank();
    }

    
    function testFuzzDepositUSDTandReceiveToken(uint256 amount) public {
        vm.assume(amount > 0 && amount < 1e19); 
        console.log("Fuzz test with amount: ", amount);

        vm.prank(user);
        usdt.approve(address(dex), 1e19);
        usdt.mint(address(this), amount*1e19);
        tokenX.mint(address(dex), amount * 1e23);
        dex.depositUSDTandReciveToken(amount);

        uint256 expectedTokenXAmount = amount * tokenXPriceInUsdt * 1e12;
        assertEq(vesting.getBeneficiaryAmount(user), expectedTokenXAmount);
    }
} 
