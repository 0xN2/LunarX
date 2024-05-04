// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {console2 as console} from "forge-std/console2.sol";
import "../src/tokenLunarX.sol";
import "../src/tokenUsdt.sol";
import "../src/Vesting.sol";
import "../src/Dex.sol";

contract RepayScript is Script {
    function run() external {
        console.log("Repay...");

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address tokenLunarX = 0x88722fe08849E91eD6dA694B62EFD37885c5dBFd;
        
        address tokenUsdt = 0x72441784AeAFDb42a26880FE4b6e17370029a16c;
        
        address vestingAddress = 0x3A282826128170Bfff3c9a60b863a06138850222;
        address owner = 0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5;

        address dexAddress =  0x26Eef5ADFd6d0524c5C256930afB0C18BfAb4edd;
        Vesting vestingContract = Vesting(vestingAddress);
        LunarX lunarXContract = LunarX(tokenLunarX);
        UsdT usdTContract = UsdT(tokenUsdt);

        Dex dexContract = Dex(dexAddress);

        vm.startBroadcast(deployerPrivateKey);
       // LunarX Lunar = new LunarX(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5);
       // Old
       //UsdT Usd = new UsdT(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5);
                
        //Vesting vest = new Vesting(tokenLunarX, 20000, payable(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5));
        
       // Dex dex = new Dex(payable(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5), vestingAddress, tokenLunarX);


// last call all together

       vestingContract.setDexAddress(dexAddress);
        lunarXContract.mint(dexAddress, 100e18);
        usdTContract.approve(dexAddress, 200e6);
        
        usdTContract.mint(owner, 100e6); 

       dexContract.depositUSDTandReciveToken(199e6);


       

/*deploy lunarX and Usdt
mint 100e18 to dex
mint and approve 1e6usdt to owner
call deposit on dex
*/

//TODO i think in is better if using a USDC aave faucet sepolia token

        vm.stopBroadcast();
    }
}
