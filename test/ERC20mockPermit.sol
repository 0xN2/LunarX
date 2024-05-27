// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract ERC20PermitMock is ERC20, ERC20Permit {
    constructor() ERC20("MockToken", "MTK") ERC20Permit("") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract ERC20PermitMock2 is ERC20, ERC20Permit {
    constructor() ERC20("MockToken", "MTK") ERC20Permit("") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
     function decimals() public view virtual override   returns (uint8) {
        return 6;
    }

}
