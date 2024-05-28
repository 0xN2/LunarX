// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./DexWithApprove.sol";
import "./Vesting.sol";



contract LunarXFactory {
    
    address[] public vestingDeployedContracts;
    address[] public dexDeployedContracts;
    
    event VestingDeployed(address indexed contractAddress, address indexed _initialOwner);
    event dexDeployed(address indexed contractAddress, address indexed _initialOwner);


    function deployVesting(address _token, uint256 _expiryDuration, address _initialOwner) external {
        
        Vesting vesting = new Vesting(_token, _expiryDuration, _initialOwner);
        
        
        vestingDeployedContracts.push(address(vesting));
        
        
        emit VestingDeployed(address(vesting), _initialOwner);
    }

    function getVestingDeployedContracts() external view returns (address[] memory) {
        return vestingDeployedContracts;
    }

     function deployDex(address _initialOwner, address _vestingAddress, address _tokenX, address _tokenUSDT ) external {
        
        Dex dex = new Dex( _initialOwner,  _vestingAddress,  _tokenX,  _tokenUSDT) ;
        
        
        dexDeployedContracts.push(address(dex));
        
        
        emit dexDeployed(address(dex), _initialOwner);
    }

    function getDexDeployedContracts() external view returns (address[] memory) {
        return dexDeployedContracts;
    }
}
