// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Vesting is ReentrancyGuard, Ownable {

    struct ScheduleLocked {
        uint256 amount;
        bool claimed;
    }

    IERC20  public immutable token ;

    address dexAddress;

    // Common expiry time for all schedules
    uint256 public immutable commonExpiry;  

    mapping(address => ScheduleLocked) public beneficiaryVesting;

    constructor(address _token, uint256 _expiryDuration, address initialOwner) Ownable(initialOwner) {
        // Check that the token address is not 0x0.
        require(_token != address(0x0));
        token = IERC20(_token);
        // Set a common expiry for all future vesting
        commonExpiry = block.timestamp + _expiryDuration;  
    }

    //add pause role

    function lock(uint256 _amount, address _beneficiary) external {
          require(block.timestamp < commonExpiry, "Tokens have been unlocked");
          require(msg.sender == owner() || msg.sender == dexAddress, "Unauthorized");
        ScheduleLocked storage schedule = beneficiaryVesting[_beneficiary];
        if (!schedule.claimed) {
           // Add to the existing amount if not yet claimed
            schedule.amount += _amount;
        }
    }

    function withdraw() external nonReentrant {
        ScheduleLocked storage schedule = beneficiaryVesting[msg.sender];
        require(block.timestamp > commonExpiry, "Tokens have not been unlocked");
        require(!schedule.claimed, "Tokens have already been claimed");
        schedule.claimed = true;
        
        SafeERC20.safeTransfer(token, msg.sender, schedule.amount);
        //using C E I
        schedule.amount = 0;
    }

    function withdrawEmergencyTokens(uint256 amount) external onlyOwner {   
        SafeERC20.safeTransfer(token, msg.sender, amount);
    }

    function getBeneficiaryAmount(address _beneficiary) external view returns (uint256) {
        return beneficiaryVesting[_beneficiary].amount;
    }

     function getSupply(address _tokenAddress) public view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function setDexAddress(address _dexAddress) public onlyOwner {
        dexAddress = _dexAddress;
    }

     function getDifferenceTime() public view returns(uint256) {
        if (block.timestamp >= commonExpiry) {
            return 0; // Return zero if the current time is past the expiry
        }
        return commonExpiry - block.timestamp;
    }
}
