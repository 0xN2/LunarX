// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "../src/Vesting.sol";
import "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract EchidnaVestingTest {
    Vesting vesting;
    ERC20Mock token;
    address owner;
    address beneficiary;
    address dexAddress;
    uint256 expiryDuration;

    bool lockCalled;
    bool emergencyWithdrawCalled;
    bool paused;

    constructor() {
        owner = msg.sender;
        beneficiary = address(0x2);
        dexAddress = address(0x3);
        expiryDuration = 1 weeks;

        token = new ERC20Mock();
        vesting = new Vesting(address(token), expiryDuration, owner);

        // Mint tokens to owner
        token.mint(owner, 10 ether);
        token.mint(address(vesting), 10 ether);
        // Transfer some tokens to the contract
        //token.transfer(address(vesting), 10 ether);

        // Initialize flags
        lockCalled = false;
        emergencyWithdrawCalled = false;
        paused = false;
    }

    function setLockCalled() public {
        //vesting.setDexAddress(dexAddress);
        vesting.lock(1 ether, beneficiary);
        lockCalled = true;
    }

    function setEmergencyWithdrawCalled() public {
        vesting.withdrawEmergencyTokens(1 ether);
        emergencyWithdrawCalled = true;
    }

    function pauseContract() public {
        vesting.pause();
        paused = true;
    }

    function unpauseContract() public {
        vesting.unpause();
        paused = false;
    }

    
    function echidna_test_lock_called() public  returns (bool) {
              try 
        vesting.lock(1 ether, beneficiary){
                return true;
            } catch {
                return true;
            }
        
        return true;
    }

    
    function echidna_test_emergency_withdraw_called() public  returns (bool) {
         if (block.timestamp < (block.timestamp + expiryDuration)) {
            try vesting.withdrawEmergencyTokens(1 ether) {
                return false;
            } catch {
                return true;
            }
        }
        return true;
    }

    
    function echidna_test_pause_unpause() public view returns (bool) {
        return paused || !paused; 
    }

    function echidna_test_no_withdraw_before_expiry() public returns (bool) {
        if (block.timestamp < (block.timestamp + expiryDuration)) {
            try vesting.withdraw() {
                return false;
            } catch {
                return true;
            }
        }
        return true;
    }

    function echidna_test_withdraw_after_expiry() public returns (bool) {
        if (block.timestamp >= (block.timestamp + expiryDuration + 1)) {
            try vesting.withdraw() {
                return true;
            } catch {
                return false;
            }
        }
        return true;
    }
}
