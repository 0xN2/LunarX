// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/Dex.sol";
import "../src/Vesting.sol";
import "./ERC20mockPermit.sol";

contract DexTest is Test {
    Dex dex;
    Vesting vesting;
    ERC20PermitMock tokenX;
    ERC20PermitMock2 usdt;
    address owner = address(0x1);
    address user = address(0x2);
    uint256 expiryDuration = 1 weeks;
    uint256 tokenXPriceInUsdt = 100;
    uint256 constant USER_PRIVATE_KEY = 2; 

    function setUp() public {
        tokenX = new ERC20PermitMock();
        usdt = new ERC20PermitMock2();

        vesting = new Vesting(address(tokenX), expiryDuration, owner);
        dex = new Dex(owner, address(vesting), address(tokenX), address(usdt));

       
        usdt.mint(user, 1000 ether);
        vm.prank(user);
        usdt.approve(address(dex), 1000 ether);

        // Mint tokens to vesting contract
        tokenX.mint(address(vesting), 1000 ether);
    }

    function getPermitSignature(address owner, address spender, uint256 value, uint256 nonce, uint256 deadline, uint256 privateKey) internal returns (uint8, bytes32, bytes32) {
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                owner,
                spender,
                value,
                nonce,
                deadline
            )
        );
        bytes32 hash = keccak256(
            abi.encodePacked(
                "\x19\x01",
                usdt.DOMAIN_SEPARATOR(),
                structHash
            )
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, hash);
        return (v, r, s);
    }

    function testDepositUSDTandReceiveToken() public {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;
        uint256 nonce = usdt.nonces(user);
        uint256 privateKey = USER_PRIVATE_KEY;  

        (uint8 v, bytes32 r, bytes32 s) = getPermitSignature(user, address(dex), amount, nonce, deadline, privateKey);

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount, deadline, v, r, s);

        uint256 expectedTokenXAmount = amount * tokenXPriceInUsdt * 1e12;
        assertEq(vesting.getBeneficiaryAmount(user), expectedTokenXAmount);
    }

    function testGetBalance() public {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;
        uint256 nonce = usdt.nonces(user);
        uint256 privateKey = USER_PRIVATE_KEY; 

        (uint8 v, bytes32 r, bytes32 s) = getPermitSignature(user, address(dex), amount, nonce, deadline, privateKey);

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount, deadline, v, r, s);

        assertEq(dex.getBalance(address(usdt)), 10 ether);
    }

    function testWithdraw() public {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;
        uint256 nonce = usdt.nonces(user);
        uint256 privateKey = USER_PRIVATE_KEY; 

        (uint8 v, bytes32 r, bytes32 s) = getPermitSignature(user, address(dex), amount, nonce, deadline, privateKey);

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount, deadline, v, r, s);

        vm.startPrank(owner);
        dex.withdraw(address(usdt));
        vm.stopPrank();

        assertEq(usdt.balanceOf(owner), 10 ether);
    }

    function testPauseUnpause() public {
        vm.startPrank(owner);
        dex.pause();
        vm.expectRevert("Pausable: paused");
        dex.depositUSDTandReciveToken(10 ether, block.timestamp + 1 days, 0, bytes32(0), bytes32(0));
        dex.unpause();
        vm.stopPrank();

        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;
        uint256 nonce = usdt.nonces(user);
        uint256 privateKey = USER_PRIVATE_KEY; 

        (uint8 v, bytes32 r, bytes32 s) = getPermitSignature(user, address(dex), amount, nonce, deadline, privateKey);

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount, deadline, v, r, s);
        assertEq(vesting.getBeneficiaryAmount(user), amount * tokenXPriceInUsdt * 1e12);
    }

    function testWithdrawWhenPaused() public {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;
        uint256 nonce = usdt.nonces(user);
        uint256 privateKey = USER_PRIVATE_KEY; 

        (uint8 v, bytes32 r, bytes32 s) = getPermitSignature(user, address(dex), amount, nonce, deadline, privateKey);

        vm.prank(user);
        dex.depositUSDTandReciveToken(amount, deadline, v, r, s);

        vm.startPrank(owner);
        dex.pause();
        vm.stopPrank();

        vm.startPrank(owner);
        vm.expectRevert("Pausable: paused");
        dex.withdraw(address(usdt));
        vm.stopPrank();
    }
}
