// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "../src/Vesting.sol";
import "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract EchidnaVestingTest {
    Vesting vesting;
    ERC20Mock token;
    address owner;
    address user;
    address dexAddress;

    uint256 expiryDuration = 1 weeks;

    constructor() {
        owner = msg.sender;
        user = address(0x2);
        dexAddress = address(0x3);

        token = new ERC20Mock();
        vesting = new Vesting(address(token), expiryDuration, owner);

        // Mint tokens to vesting contract
        token.mint(address(vesting), 1000 ether);
        token.mint(owner, 1000 ether);
    }

    function echidna_test_lock_called() public returns (bool) {
        // Reset state before test
        vesting.setDexAddress(dexAddress);
        uint256 initialAmount = vesting.getBeneficiaryAmount(user);

        // Perform action
        vesting.lock(10 ether, user);

        // Check invariant
        return vesting.getBeneficiaryAmount(user) == initialAmount + 10 ether;
    }

    function echidna_test_withdraw_after_expiry() public returns (bool) {
        // Assume this test runs after expiry time
        if (block.timestamp > vesting.commonExpiry()) {
            // Reset state before test
            vesting.setDexAddress(dexAddress);
            vesting.lock(10 ether, user);
            uint256 initialBalance = token.balanceOf(user);

            // Perform action
            vesting.withdraw();

            // Check invariant
            return token.balanceOf(user) == initialBalance + 10 ether;
        }
        return true; // Skip this test if current time is before expiry
    }

    function echidna_test_no_withdraw_before_expiry() public returns (bool) {
        // Reset state before test
        vesting.setDexAddress(dexAddress);
        vesting.lock(10 ether, user);

        if (block.timestamp < vesting.commonExpiry()) {
            // Perform action
            (bool success,) = address(vesting).call(abi.encodeWithSignature("withdraw()"));

            // Check invariant
            return !success; // Should fail as expiry hasn't passed
        }
        return true; // Skip this test if current time is after expiry
    }

    function echidna_test_emergency_withdraw_called() public returns (bool) {
        // Reset state before test
        uint256 initialBalance = token.balanceOf(owner);

        // Perform action
        vesting.withdrawEmergencyTokens(10 ether);

        // Check invariant
        return token.balanceOf(owner) == initialBalance + 10 ether;
    }

    function echidna_test_pause_unpause() public returns (bool) {
        // Reset state before test
        bool pausedBefore = vesting.paused();

        // Perform actions
        vesting.pause();
        bool paused = vesting.paused();
        vesting.unpause();
        bool unpaused = !vesting.paused();

        // Check invariants
        return paused != pausedBefore && unpaused == pausedBefore;
    }

    function echidna_test_total_balance_consistency() public view returns (bool) {
        uint256 totalTokenBalance = token.balanceOf(address(vesting)) + token.balanceOf(owner) + token.balanceOf(user);
        return totalTokenBalance == 2000 ether; // Adjusted based on initial minting
    }
}

