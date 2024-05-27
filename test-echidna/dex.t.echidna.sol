// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../src/Dex.sol";
import "../src/Vesting.sol";
import "../test/ERC20mockPermit.sol";

contract EchidnaDexTest {
    Dex dex;
    Vesting vesting;
    ERC20PermitMock tokenX;
    ERC20PermitMock usdt;
    address owner;
    address user;

    uint256 expiryDuration = 1 weeks;
    uint256 tokenXPriceInUsdt = 100;

    constructor() {
        owner = msg.sender;
        user = address(0x2);

        tokenX = new ERC20PermitMock("TokenX", "TX");
        usdt = new ERC20PermitMock("USDT", "USDT");

        vesting = new Vesting(address(tokenX), expiryDuration, owner);
        dex = new Dex(owner, address(vesting), address(tokenX), address(usdt));

        // Mint tokens to user
        usdt.mint(user, 1000 ether);
        tokenX.mint(address(vesting), 1000 ether);
    }

    // Precomputed values
    uint8 v = 27;
    bytes32 r = 0x5f6cbe57ab42cd83a3c34c5bfb70f14e0e6936fb1553f0651ad93b5d0c1a1b70;
    bytes32 s = 0x4ba42dc16c4c4b2a03c5291d8b29cb618be8e4c5cc3d8e1e5c0a9b1c2c2fddff;

    function echidna_test_deposit_updates_balances() public returns (bool) {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;

        usdt.approve(address(dex), amount);

        try dex.depositUSDTandReciveToken(amount, deadline, v, r, s) {
            uint256 expectedTokenXAmount = (amount * tokenXPriceInUsdt) * 1e12;
            return vesting.getBeneficiaryAmount(user) == expectedTokenXAmount;
        } catch {
            return false;
        }
    }

    function echidna_test_withdraw_by_owner() public returns (bool) {
        try dex.withdraw(address(usdt)) {
            return msg.sender == owner;
        } catch {
            return msg.sender != owner;
        }
    }

    function echidna_test_pause_unpause() public returns (bool) {
        try dex.pause() {
            bool paused = dex.paused();
            dex.unpause();
            return paused && !dex.paused();
        } catch {
            return false;
        }
    }

    function echidna_test_permit_functionality() public returns (bool) {
        uint256 amount = 10 ether;
        uint256 deadline = block.timestamp + 1 days;

        try IERC20Permit(usdt).permit(user, address(dex), amount, deadline, v, r, s) {
            return true;
        } catch {
            return false;
        }
    }

    function echidna_test_total_balance_consistency() public view returns (bool) {
        uint256 totalUsdtBalance = usdt.balanceOf(address(dex)) + usdt.balanceOf(owner) + usdt.balanceOf(user);
        uint256 totalTokenXBalance = tokenX.balanceOf(address(dex)) + tokenX.balanceOf(owner) + tokenX.balanceOf(user);
        return totalUsdtBalance == 1000 ether && totalTokenXBalance == 1000 ether;
    }

    function echidna_test_lock_called() public returns (bool) {
        try vesting.lock(10 ether, user) {
            return vesting.getBeneficiaryAmount(user) == 10 ether;
        } catch {
            return false;
        }
    }

    function echidna_test_emergency_withdraw_called() public returns (bool) {
        uint256 initialBalance = usdt.balanceOf(owner);
        try vesting.withdrawEmergencyTokens(10 ether) {
            return usdt.balanceOf(owner) == initialBalance + 10 ether;
        } catch {
            return false;
        }
    }

    function echidna_test_no_withdraw_before_expiry() public returns (bool) {
        uint256 amount = 10 ether;
        vesting.lock(amount, user);
        try vesting.withdraw() {
            return false; // Should fail as expiry hasn't passed
        } catch {
            return true; // Expected behavior
        }
    }

  /*   function echidna_test_withdraw_after_expiry() public returns (bool) {
        uint256 amount = 10 ether;
        vesting.lock(amount, user);

        // Simulate time passing
        block.timestamp += expiryDuration + 1;

        try vesting.withdraw() {
            return true; // Should succeed as expiry has passed
        } catch {
            return false;
        }
    } */
}
