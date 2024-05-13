// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/Test.sol";
import "ds-test/test.sol";
import "../src/Dex.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "forge-std/Vm.sol";
import {Vesting} from "../src/Vesting.sol";

contract MockToken is ERC20 {
    constructor() ERC20("MockToken", "MTK") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
contract MockToken2 is ERC20 {
    constructor() ERC20("MockToken2", "USD") {}
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract DexTest is Test {
    Dex dex;
    Vesting vesting;
    MockToken tokenX;
    MockToken2 usdt;
    address deployer;
    address user1;

    function setUp() public {
        deployer = address(this);

        tokenX = new MockToken();
        usdt = new MockToken2();

        // Mint some initial balances
        //usdt.mint(deployer, 10e6);  // 10 USDT

        vesting = new Vesting(address(tokenX), 2000, deployer);
        // Vesting vest = new Vesting(tokenLunarX, 2000, ownerAddress);

        // Deploy the Dex contract
        dex = new Dex(deployer, address(vesting), address(tokenX), address(usdt));
        //Dex dex = new Dex(ownerAddress, vestingAddress, tokenLunarX);

        // Allow the Dex contract to spend user's USDT
       // vm.prank(deployer);
       
        emit log_address(address(vesting));
        emit log_address(address(dex));
        emit log_address(address(tokenX));
        emit log_address(address(usdt));
    }

    function testDepositUSDTandReceiveTokenX() public {
      
         vm.startPrank(address(this));
          vesting.setDexAddress(address(dex));
        //console.log(usdt.approve(address(dex), 10e6));
        tokenX.mint(address(dex), 1000e18);

        usdt.approve(address(dex), 10e6);
        usdt.mint(deployer, 10e6);
       // dex.depositUSDTandReciveToken(10e6, block.timestamp,  v,  r,  s);   import Permit, using getSignature
    }
}
