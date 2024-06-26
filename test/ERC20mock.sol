// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MockToken is ERC20 {
    constructor() ERC20("MockToken", "MTK")  {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract MockToken2 is ERC20 {
    constructor() ERC20("usdt", "MTK")  {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
     function decimals() public view virtual override   returns (uint8) {
        return 6;
    }

}